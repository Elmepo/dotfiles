-- local prompts = {
--     -- Code related prompts
--     Explain = "Please explain how the following code works.",
--     Review = "Please review the following code and provide suggestions for improvement.",
--     Tests = "Please explain how the selected code works, then generate unit tests for it.",
--     Refactor = "Please refactor the following code to improve its clarity and readability.",
--     FixCode = "Please fix the following code to make it work as intended.",
--     FixError = "Please explain the error in the following text and provide a solution.",
--     BetterNamings = "Please provide better names for the following variables and functions.",
--     Documentation = "Please provide documentation for the following code.",
--     SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
--     SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
--     -- Text related prompts
--     Summarize = "Please summarize the following text.",
--     Spelling = "Please correct any grammar and spelling errors in the following text.",
--     Wording = "Please improve the grammar and wording of the following text.",
--     Concise = "Please rewrite the following text to make it more concise.",
-- }

return {
    {
        'github/copilot.vim',
        lazy = false,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        name = "copilotchat",
        lazy = false,
        branch = "canary",
        dependencies = {
            { 'github/copilot.vim' },
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-lua/popup.nvim' },
        },
        opts = {
            debug = true,
            proxy = nil, -- [protocol://]host[:port] Use this proxy
            allow_insecure = false, -- Allow insecure server connections

            model = 'gpt-4', -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
            temperature = 0.1, -- GPT temperature

            question_header = '', -- Header to use for user questions
            answer_header = '**Copilot** ', -- Header to use for AI answers
            error_header = '**Error** ', -- Header to use for errors
            separator = '---', -- Separator to use in chat

            show_folds = true, -- Shows folds for sections in chat
            show_help = true, -- Shows help message as virtual lines when waiting for user input
            auto_follow_cursor = true, -- Auto-follow cursor in chat
            auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
            clear_chat_on_new_prompt = false, -- Clears chat on every new prompt

            context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
            -- history_path = vim.fn.stdpath('data') .. '/copilotchat_history', -- Default path to stored history
            callback = nil, -- Callback to use when ask response is received

            -- default selection (visual or line)
            -- selection = function(source)
            --   return select.visual(source) or select.line(source)
            -- end,

            -- default prompts
            -- prompts = {
            --   Explain = {
            --     prompt = '/COPILOT_EXPLAIN Write an explanation for the code above as paragraphs of text.',
            --   },
            --   Tests = {
            --     prompt = '/COPILOT_TESTS Write a set of detailed unit test functions for the code above.',
            --   },
            --   Fix = {
            --     prompt = '/COPILOT_FIX There is a problem in this code. Rewrite the code to show it with the bug fixed.',
            --   },
            --   Optimize = {
            --     prompt = '/COPILOT_REFACTOR Optimize the selected code to improve performance and readablilty.',
            --   },
            --   Docs = {
            --     prompt = '/COPILOT_REFACTOR Write documentation for the selected code. The reply should be a codeblock containing the original code with the documentation added as comments. Use the most appropriate documentation style for the programming language used (e.g. JSDoc for JavaScript, docstrings for Python etc.',
            --   },
            --   FixDiagnostic = {
            --     prompt = 'Please assist with the following diagnostic issue in file:',
            --     selection = select.diagnostics,
            --   },
            --   Commit = {
            --     prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
            --     selection = select.gitdiff,
            --   },
            --   CommitStaged = {
            --     prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
            --     selection = function(source)
            --       return select.gitdiff(source, true)
            --     end,
            --   },
            -- },

            -- default window options
            window = {
              layout = 'float', -- 'vertical', 'horizontal', 'float'
              -- Options below only apply to floating windows
              relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
              border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
              width = 0.8, -- fractional width of parent
              height = 0.6, -- fractional height of parent
              row = nil, -- row position of the window, default is centered
              col = nil, -- column position of the window, default is centered
              title = 'Copilot Chat', -- title of chat window
              footer = nil, -- footer of chat window
              zindex = 1, -- determines if window is on top or below other floating windows
            },

            -- default mappings
            mappings = {
              complete = {
                detail = 'Use @<Tab> or /<Tab> for options.',
                insert ='<Tab>',
              },
              close = {
                normal = 'q',
                insert = '<C-c>'
              },
              reset = {
                normal ='<C-l>',
                insert = '<C-l>'
              },
              submit_prompt = {
                normal = '<CR>',
                insert = '<C-m>'
              },
              accept_diff = {
                normal = '<C-y>',
                insert = '<C-y>'
              },
              yank_diff = {
                normal = 'gy',
              },
              show_diff = {
                normal = 'gd'
              },
              show_system_prompt = {
                normal = 'gp'
              },
              show_user_selection = {
                normal = 'gs'
              },
            },
        },
    },
}
