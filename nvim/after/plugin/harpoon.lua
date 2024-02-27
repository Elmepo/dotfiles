local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-i>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-o>", function() ui.nav_file(2) end)
-- Trying to set up tmux at the moment and I really want to be able to switch between
-- panes with <C-hjkl>, but I can't think of a better four letters than I currently have.
--
-- vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
-- vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)
