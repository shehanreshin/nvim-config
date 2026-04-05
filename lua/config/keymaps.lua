-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "<C-u>", "<C-o>u", { desc = "Undo" })
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

for _, mode in ipairs({ "n", "i", "v", "x", "s" }) do
  vim.keymap.set(mode, "<Up>", "<Nop>")
  vim.keymap.set(mode, "<Down>", "<Nop>")
  vim.keymap.set(mode, "<Left>", "<Nop>")
  vim.keymap.set(mode, "<Right>", "<Nop>")
end
