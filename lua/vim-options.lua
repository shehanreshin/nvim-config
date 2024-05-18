vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")

vim.cmd(":map <Up> <Nop>")
vim.cmd(":map <Left> <Nop>")
vim.cmd(":map <Right> <Nop>")
vim.cmd(":map <Down> <Nop>")

vim.keymap.set('n', '<C-s>', ':w<CR>', {})
vim.keymap.set('i', '<C-s>', '<C-o>:w<CR>', {})
