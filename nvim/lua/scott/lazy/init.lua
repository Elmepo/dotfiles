return {
    {
        require("lazy").setup({
            -- {
            --   "christoomey/vim-tmux-navigator",
            --   cmd = {
            --     "TmuxNavigateLeft",
            --     "TmuxNavigateDown",
            --     "TmuxNavigateUp",
            --     "TmuxNavigateRight",
            --   },
            --   keys = {
            --     { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            --     { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            --     { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            --     { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            --   },
            -- },

            {'theprimeagen/vim-be-good'},

            -- {
            --     'nvim-telescope/telescope.nvim',
            --     tag = '0.1.5',
            --     dependencies = { {'nvim-lua/plenary.nvim'} }
            -- },

            -- {
            --     'rose-pine/neovim',
            --     name = 'rose-pine',
            --     config = function()
            --         vim.cmd('colorscheme rose-pine-moon')
            --     end
            -- },

            -- {
            --     'nvim-treesitter/nvim-treesitter',
            --     build = function()
            --         local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            --         ts_update()
            --     end,
            -- },

            -- TESTING { 'nvim-treesitter/playground' },
            -- { 'theprimeagen/harpoon' },
            -- { 'theprimeagen/refactoring.nvim' },
            -- { 'mbbill/undotree' },
            { 'tpope/vim-fugitive' },
            -- TESTING { 'nvim-treesitter/nvim-treesitter-context' },

            -- {
            --     'VonHeikemen/lsp-zero.nvim',
            --     branch = 'v3.x',
            --     dependencies = {
            --         -- LSP Support
            --         { 'neovim/nvim-lspconfig' },
            --         { 'williamboman/mason.nvim' },
            --         { 'williamboman/mason-lspconfig.nvim' },

            --         -- Autocompletion
            --         { 'hrsh7th/nvim-cmp' },
            --         { 'hrsh7th/cmp-buffer' },
            --         { 'hrsh7th/cmp-path'},
            --         { 'saadparwaiz1/cmp_luasnip' },
            --         { 'hrsh7th/cmp-nvim-lsp' },
            --         { 'hrsh7th/cmp-nvim-lua' },

            --         -- Snippets
            --         { 'L3MON4D3/LuaSnip' },
            --         { 'rafamadriz/friendly-snippets' },
            --     }
            -- },

            -- TESTING { 'eandrju/cellular-automaton.nvim' },
        })
    },
}
