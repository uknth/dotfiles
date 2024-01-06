if [ -f "$dotfiles_dir/config/curl.txt" ]; then
    alias curlf="curl -w \"@$dotfiles_dir/config/curl.txt\" -o /dev/null -s"
    alias curlfr="curl -w \"@$dotfiles_dir/config/curl.txt\" -s"
fi