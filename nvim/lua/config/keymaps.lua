-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<up>", "<C-u>")
map("n", "<down>", "<C-d>")

map("", "<C-h>", "<C-w>h", { desc = "Goto Left Window" })
map("", "<C-l>", "<C-w>l", { desc = "Goto Right Window" })
map("", "<C-j>", "<C-w>j", { desc = "Goto Down Window" })
map("", "<C-k>", "<C-w>k", { desc = "Goto Up Window" })

-- Copy and Paste
map("i", "<D-v>", '<C-o>"+gp')
map("c", "<D-v>", "<C-r>+")
map("t", "<D-v>", '<C-\\><C-n>"+gpa')
map("v", "<S-y>", '"+y')

-- open terminal
map("i", "<C-.>", "<Esc><C-.>", { remap = true })
map({ "i", "n" }, "<C-/>", "<C-.>", { remap = true })

local esc_timer
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Double escape to normal mode" })

-- Resize window using <ctrl> arrow keys
map("n", "<S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Build and run based on asynctasks.nvim
map("n", "<F5>", "<cmd>AsyncTask project-build<cr>", { desc = "Build Current Project" })
map("n", "<F6>", "<cmd>AsyncTask project-run<cr>", { desc = "Run Current Project" })
map("n", "<F8>", "<cmd>AsyncTask file-debug<cr>", { desc = "Debug Current File" })
map("n", "<F9>", "<cmd>AsyncTask file-build<cr>", { desc = "Build Current File" })
map("n", "<F10>", "<cmd>AsyncTask file-run<cr>", { desc = "Run Current File" })
map("n", "<S-F10>", "<cmd>AsyncTask file-run-terminal<cr>", { desc = "Run Current File in Terminal" })
map("i", "<F8>", "<esc><F8>", { remap = true })
map("i", "<F9>", "<esc><F9>", { remap = true })
map("i", "<F10>", "<esc><F10>", { remap = true })
map("i", "<S-F10>", "<esc><S-F10>", { remap = true })
map({ "n", "i" }, "<F11>", "<F9><F10>", { remap = true })
map({ "n", "i" }, "<F22>", "<S-F10>", { remap = true })

map("n", "<F12>", "<cmd>cclose<cr>")
