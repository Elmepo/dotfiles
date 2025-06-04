vim.keymap.set("n", "<leader>ge", "oif err != nil {<CR>log.Fatal(err)<CR>}<Esc>")
vim.keymap.set("n", "<leader>gl", 'olog.Print("a")<Esc>')
