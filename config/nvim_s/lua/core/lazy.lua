-- start plugins setup using packer

--
local fn = vim.fn

-- A `packpath` is the path which neovim uses to search for packages
--      `:h packages`
-- shows more details in neovim
--
-- From neovim documents
--
--  Nvim searches for |:runtime| files in:
--      1. all path in 'runtimepath'
--      2. all "pack/*/start/*" dirs
--
-- This is reason why lazy bootstrap needs to either clone to pack/* directory
-- or update the `rtp` as - vim.opt.rtp:prepend(lazy_path)


local lazy_path = fn.stdpath("data") .. "/lazy/lazy.nvim"

-- add to 'runtimepath'
vim.opt.rtp:prepend(lazy_path)

if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazy_path,
    })
end

local ok, lazy = pcall(require, "lazy")
if not ok then
    return
end

-- Load plugins from specifications
-- (The leader key must be set before this)
lazy.setup("plugins")
