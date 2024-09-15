import datetime
import json
import subprocess
import dbus
from collections import defaultdict

# NowPlaying only returns the string, as `title - artist`,
# when there is a music playing on dbus
# If there is no music, it just returns an empty block
class NowPlaying ():
    def __init__ (self, bus):
        self.bus = bus
        self.player_properties = None

        count = 0

        for ss in self.bus.list_names():
            if ss.startswith('org.mpris.MediaPlayer2.'):
                bus_object = self.bus.get_object(ss, '/org/mpris/MediaPlayer2')

                iface = dbus.Interface(bus_object, "org.freedesktop.DBus.Properties")

                properties = iface.GetAll("org.mpris.MediaPlayer2.Player")

                for key, value in properties.items():
                    if key == "PlaybackStatus" and value == "Playing":
                        self.player_properties = properties
                
    def now_playing(self):
        if self.player_properties == None:
            return ""

        str = ""

        for key, value in self.player_properties.items():
            if key == "Metadata":
                if "xesam:title" in value:
                    str = str + value["xesam:title"]
                if "xesam:artist" in value:
                    str = str + " - " + value["xesam:artist"][0]


        return str

# kitty dependencies
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)

timer_id = None


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id

    # if timer_id is None:
    #     timer_id = add_timer(_redraw_tab_bar, 2.0, True)
    draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )

    if is_last:
        draw_right_status(draw_data, screen)

    return screen.cursor.x


def draw_right_status(draw_data: DrawData, screen: Screen) -> None:
    # The tabs may have left some formats enabled. Disable them now.
    draw_attributed_string(Formatter.reset, screen)
    cells = create_cells()
    # Drop cells that wont fit
    while True:
        if not cells:
            return
        padding = screen.columns - screen.cursor.x - \
            sum(len(c) + 3 for c in cells)
        if padding >= 0:
            break
        cells = cells[1:]

    if padding:
        screen.draw(" " * padding)

    tab_bg = as_rgb(int(draw_data.inactive_bg))
    tab_fg = as_rgb(int(draw_data.inactive_fg))
    default_bg = as_rgb(int(draw_data.default_bg))
    for cell in cells:
        # Draw the separator
        if cell == cells[0]:
            screen.cursor.fg = tab_bg
            screen.draw("")
        else:
            screen.cursor.fg = default_bg
            screen.cursor.bg = tab_bg
            screen.draw("")
        screen.cursor.fg = tab_fg
        screen.cursor.bg = tab_bg
        screen.draw(f" {cell} ")


def create_cells() -> list[str]:
    now = datetime.datetime.now()
    return [
        currently_playing(),
        now.strftime("%d %b"),
        now.strftime("%H:%M"),
    ]


STATE = defaultdict(lambda: "", {"Paused": "", "Playing": ""})

def currently_playing():
    status = " "
    
    now_playing = NowPlaying(dbus.SessionBus())

    ns = now_playing.now_playing() 

    if ns == "":
        return status
    
    status = status + " " + ns
    return status


def _redraw_tab_bar(timer_id):
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()
