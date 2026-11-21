vim.g.mapleader = " "

local keymap = vim.keymap.set

keymap("n", "<leader>ee", vim.cmd.Ex, {desc = "open the file explore"})

keymap("i", "jk", "<Esc>", {desc = "Enter noremal mode"})

keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap("n", "<leader>gh", "<C-w>h", { desc = "Move to left split" })
keymap("n", "<leader>gj", "<C-w>j", { desc = "Move to bottom split" })
keymap("n", "<leader>gk", "<C-w>k", { desc = "Move to top split" })
keymap("n", "<leader>gl", "<C-w>l", { desc = "Move to right split" })

keymap("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
