local fns = {}
local function noop()
    print("NOOP")
end

local ok, close_buffers = pcall(require, "close_buffers")
if ok then
    fns.delete_this = function()
        close_buffers.delete({ type = "this" })
    end
    fns.delete_all = function()
        close_buffers.delete({ type = "all", force = true })
    end
    fns.delete_others = function()
        close_buffers.delete({ type = "other", force = true })
    end
else
    fns.delete_this = function()
        vim.cmd.bdelete()
    end
    fns.delete_all = noop
    fns.delete_others = noop
end

return fns
