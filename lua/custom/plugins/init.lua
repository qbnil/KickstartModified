-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    -- plugins/quarto.lua
    {
        'quarto-dev/quarto-nvim',
        dependencies = {
            'jmbuhr/otter.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
    },
    {
        'theprimeagen/harpoon',
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            vim.keymap.set('n', '<leader>a', function()
                require('harpoon.mark').add_file()
            end)
            vim.keymap.set('n', '<A-a>', function()
                require('harpoon.ui').toggle_quick_menu()
            end)
            vim.keymap.set('n', '<A-1>', function()
                require('harpoon.ui').nav_file(1)
            end)
            vim.keymap.set('n', '<A-2>', function()
                require('harpoon.ui').nav_file(2)
            end)
            vim.keymap.set('n', '<A-3>', function()
                require('harpoon.ui').nav_file(3)
            end)
            vim.keymap.set('n', '<A-4>', function()
                require('harpoon.ui').nav_file(4)
            end)
            vim.keymap.set('n', '<A-5>', function()
                require('harpoon.ui').nav_file(5)
            end)
            vim.keymap.set('n', '<A-6>', function()
                require('harpoon.ui').nav_file(6)
            end)
            vim.keymap.set('n', '<A-7>', function()
                require('harpoon.ui').nav_file(7)
            end)
            vim.keymap.set('n', '<A-8>', function()
                require('harpoon.ui').nav_file(8)
            end)
            vim.keymap.set('n', '<A-9>', function()
                require('harpoon.ui').nav_file(9)
            end)
            vim.keymap.set('n', '<A-0>', function()
                require('harpoon.ui').nav_file(10)
            end)
        end,
    },
    {
        'numToStr/Comment.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('Comment').setup {
                ---Add a space b/w comment and the line
                padding = true,
                ---Whether the cursor should stay at its position
                sticky = true,
                ---Lines to be ignored while (un)comment
                ignore = nil,
                ---LHS of toggle mappings in NORMAL mode
                toggler = {
                    ---Line-comment toggle keymap
                    line = 'sdd',
                    ---Block-comment toggle keymap
                    block = 'gbc',
                },
                opleader = {
                    ---Line-comment keymap
                    line = 'sd',
                    ---Block-comment keymap
                    block = 'gb',
                },
                ---LHS of extra mappings
                extra = {
                    ---Add comment on the line above
                    above = 'gcO',
                    ---Add comment on the line below
                    below = 'gco',
                    ---Add comment at the end of line
                    eol = 'gcA',
                },
                ---Enable keybindings
                ---NOTE: If given `false` then the plugin won't create any mappings
                mappings = {
                    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    basic = true,
                    ---Extra mapping; `gco`, `gcO`, `gcA`
                    extra = true,
                },
                ---Function to call before (un)comment
                pre_hook = nil,
                ---Function to call after (un)comment
                post_hook = nil,
            }
        end,
    },
    {
        'tpope/vim-fugitive',
        event = 'VeryLazy',
        config = function()
            vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

            local archi_fugitive = vim.api.nvim_create_augroup('archi_fugitive', {})

            local autocmd = vim.api.nvim_create_autocmd
            autocmd('BufWinEnter', {
                group = archi_fugitive,
                pattern = '*',
                callback = function()
                    if vim.bo.ft ~= 'fugitive' then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts = { buffer = bufnr, remap = false }
                    vim.keymap.set('n', '<leader>p', function()
                        vim.cmd.Git 'push'
                    end, opts)

                    -- rebase always
                    -- vim.keymap.set("n", "<leader>P", function()
                    --     vim.cmd.Git({'pull',  '--rebase'})
                    -- end, opts)
                    vim.keymap.set('n', '<leader>P', function()
                        vim.cmd.Git 'pull'
                    end, opts)

                    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                    -- needed if i did not set the branch up correctly
                    vim.keymap.set('n', '<leader>t', ':Git push -u origin ', opts)
                end,
            })
        end,
    },
    {
        'CRAG666/code_runner.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('code_runner').setup {
                filetype = {
                    java = {
                        'cd $dir &&',
                        'javac $fileName &&',
                        'java $fileNameWithoutExt',
                    },
                    python = 'python',
                    javascript = 'node',
                    typescript = 'deno run',
                    rust = {
                        'cd $dir &&',
                        'rustc $fileName &&',
                        '$dir/$fileNameWithoutExt',
                    },
                    php = 'php -f',
                    bash = 'bash -c',
                    cplus = {
                        'cd $dir &&',
                        'g++ $fileName -o $fileNameWithoutExt &&',
                        './$fileNameWithoutExt',
                    },
                    go = {
                        'cd $dir &&',
                        'go run $fileName',
                    },
                },
            }
            vim.keymap.set('n', '<leader>R', ':RunCode<CR>', { noremap = true, silent = false })
            vim.keymap.set('n', '<leader>fr', ':RunFile<CR>', { noremap = true, silent = false })
            vim.keymap.set('n', '<leader>pr', ':RunProject<CR>', { noremap = true, silent = false })
            vim.keymap.set('n', '<leader>cr', ':RunClose<CR>', { noremap = true, silent = false })
            vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
            vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })
        end,
    },
    {
        'ray-x/sad.nvim',
        lazy = true,
        event = 'VeryLazy',
        dependencies = { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
        config = function()
            require('sad').setup {
                debug = false, -- print debug info
                diff = 'less', -- you can use `less`, `diff-so-fancy`
                ls_file = 'fd', -- also git ls-files
                exact = true, -- exact match
                vsplit = false, -- split sad window the screen vertically, when set to number
                -- it is a threadhold when window is larger than the threshold sad will split vertically,
                height_ratio = 0.6, -- height ratio of sad window when split horizontally
                width_ratio = 0.6, -- height ratio of sad window when split vertically
            }
            vim.keymap.set('n', '<leader>r', vim.cmd.Sad)
        end,
    },
    {
        'folke/trouble.nvim',
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = 'Trouble',
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>cl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>xL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>xQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix List (Trouble)',
            },
        },
    },
}
