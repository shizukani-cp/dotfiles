return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            vim.cmd[[colorscheme tokyonight]]
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        visible = true,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                },
                window = {
                    position = "float",
                    width = 40,
                    height = 30,
                },
            })
        end,
    },
    {
        "j-morano/buffer_manager.nvim",
        config = function()
            require("buffer_manager").setup()
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "onsails/lspkind-nvim",
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
		        automatic_installation = true,
                ensure_installed = { "lua_ls", "pylsp", "rust_analyzer", "html", "cssls", "ts_ls" },
            })

            local lspconfig = require("lspconfig")
            local on_attach = function(_, bufnr)
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
            end

            lspconfig.lua_ls.setup{
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = {'vim'},
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            }

            lspconfig.pylsp.setup{
                on_attach = on_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                cmd = { "pylsp" },
                settings = {
                    pylsp = {
                        plugins = {
                            pyflakes = { enabled = true },
                            pylint = { enabled = true },
                        }
                    }
                }
            }

            lspconfig.rust_analyzer.setup{
                on_attach = on_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            }

            lspconfig.html.setup{
                on_attach = on_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            }
            lspconfig.cssls.setup{
                on_attach = on_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            }
            lspconfig.ts_ls.setup{
                on_attach = on_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            }
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require('lualine').setup({
                options = {
                    theme = "onedark",
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch'},
                    lualine_c = {
                        {
                            'diff',
                            symbols = {added = ' ', modified = ' ', removed = ' '},
                        },
                        {
                            'diagnostics',
                             symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
                        },
                    },
                    lualine_x = {'encoding'},
                    lualine_y = {
                        'filetype',
                        { 'filename', path=1 }
                    },
                    lualine_z = {'location'}
                },
            })
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function ()
            require('colorizer').setup({})
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function ()
            require('Comment').setup({
                toggler = {
                    line = "<Space>c",
                    block = "<Space>C",
                },
            })
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        'petertriho/nvim-scrollbar',
        config = function ()
            require("scrollbar").setup()
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function ()
            require("gitsigns").setup()
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },
    {
      "j-hui/fidget.nvim",
      opts = {},
    },
    {
        'stevearc/aerial.nvim',
        opts = {},
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
        opts = {},
    },
    {
        'jghauser/mkdir.nvim'
    },
    {
      'nacro90/numb.nvim',
      config = function()
        require('numb').setup()
      end,
    }
}
