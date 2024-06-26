vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")

vim.cmd(":map <Up> <Nop>")
vim.cmd(":map <Left> <Nop>")
vim.cmd(":map <Right> <Nop>")
vim.cmd(":map <Down> <Nop>")

vim.keymap.set("n", "<C-s>", ":w<CR>", {})
vim.keymap.set("n", "U", ":redo<CR>", {})
vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>", {})
vim.keymap.set("i", "ii", "<ESC>")
vim.keymap.set("i", "<C-u>", "<C-o>:u<CR>", {})

vim.keymap.set("n", "<leader>sx", "<C-w>v")
vim.keymap.set("n", "<leader>sy", "<C-w>s")
vim.keymap.set("n", "<leader>se", "<C-w>=")
vim.keymap.set("n", "<leader>s<ESC>", ":close<CR>")
vim.keymap.set("n", "<leader>sj", "<C-w>j")
vim.keymap.set("n", "<leader>sk", "<C-w>k")
vim.keymap.set("n", "<leader>sh", "<C-w>h")
vim.keymap.set("n", "<leader>sl", "<C-w>l")
vim.keymap.set("n", "<leader>s+", "<C-w>+")
vim.keymap.set("n", "<leader>s-", "<C-w>-")

vim.opt.mouse = ""
