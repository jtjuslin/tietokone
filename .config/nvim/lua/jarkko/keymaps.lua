vim.g.mapleader = " "

-- Misc
vim.keymap.set("n", "<S-u>", "<C-r>", { desc = "Redo" })
-- make this work pls
vim.keymap.set("i", "<C-ö>", "<Esc>", { desc = "Make C-ö Esc" })

-- Yank to clipboard yo
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- One bind to toggle highlights off
-- and the rest to turn them on when searching.
vim.keymap.set("n", "<leader>hl", ":set nohls<CR>", { desc = "Toggle highlights" })
vim.keymap.set("n", "/", ":set hls<CR>/", { desc = "Search w/ highlights", noremap = true })
vim.keymap.set("n", "?", ":set hls<CR>?", { desc = "Search rev w/ highlights", noremap = true })
vim.keymap.set("n", "n", ":set hls<CR>nzz", { desc = "Next search result", noremap = true })
vim.keymap.set("n", "N", ":set hls<CR>Nzz", { desc = "Previous search result", noremap = true })

-- Put cursor in the middle after half page jump.
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump half page up", noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump half page down", noremap = true })

-- Move lines around.
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Switch buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { desc = "Previous buffer" })

-- Quickfix
vim.keymap.set("n", "<Right>", function()
	if not pcall(vim.cmd.cnext) then
		pcall(vim.cmd.cfirst)
	end
end, { desc = "Next quickfix item" })
vim.keymap.set("n", "<Left>", function()
	if not pcall(vim.cmd.cprev) then
		pcall(vim.cmd.clast)
	end
end, { desc = "Previous quickfix item" })
