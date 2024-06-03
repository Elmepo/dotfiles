return {
    {
        'theprimeagen/vim-be-good',
        lazy = false
    },
    {
        'tpope/vim-fugitive',
        lazy = false
    },
    {
        'NStefan002/speedtyper.nvim',
        cmd = "Speedtyper",
        name = "speedtyper",
        opts = {},
        lazy = false
    },
    {
        'rcarriga/nvim-notify',
        init = function()
            vim.notify = require('notify')
        end,
    },
    {
        'f-person/git-blame.nvim',
        cmd = "GitBlameToggle",
        name = "GitBlame",
        config = function()
            vim.keymap.set("n", "<leader>bb", vim.cmd.GitBlameToggle)
        end,
        lazy = false,
        init = function()
            -- Setting it to false on startup because I typically only use blame occasionally/for specific purposes
            vim.g.gitblame_enabled = 0
        end,
    },
    {
        'stevearc/dressing.nvim',
        name = 'dressing',
        opts = {},
        config = function()
            require('dressing').setup()
        end,
    },
    {
        'numToStr/Comment.nvim',
        lazy = false,
        opts = {}
    },
    {
        "NStefan002/2048.nvim",
        cmd = "Play2048",
        config = true,
    },
    {
        "jim-fx/sudoku.nvim",
        cmd = "Sudoku",
        config = function()
            require("sudoku").setup({
            })
        end
    }
}
