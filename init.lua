vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
}

local opts = {}

require("lazy").setup(plugins, opts)

local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "lua", "javascript", "html" },
          highlight = { enable = true },
          indent = { enable = true }  
        })

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
