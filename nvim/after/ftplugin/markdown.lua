require("notify")("<leader>ww to get wordcount")
vim.keymap.set("n", "<leader>ww", "g<C-g>")

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_au"

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
