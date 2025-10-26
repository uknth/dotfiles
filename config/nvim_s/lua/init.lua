-- start plugins setup using packer

--
local fn = vim.fn

local function set_leader(key)
  vim.g.mapleader = key
  vim.g.maplocalleader = key
  vim.keymap.set({"n", "v"}, key, "<nop>", { silent = true})
end

local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end


-- set leader before we start anything
set_leader(" ")

-- BOOTSTRAP LAZY 
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
--
-- Setup LAZY
lazy.setup("plugins")

-- INIT
-- Autocmd
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),

	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},

	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
--
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})


-- Language Specific Setup in init/*.lua
require("init.go")
