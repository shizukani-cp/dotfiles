vim.scriptencoding = 'utf-8'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.fileencodings = "utf-8,cp932,euc-jp,sjis"
vim.diagnostic.config({ virtual_text = true })

vim.g.clipboard = {
    name = 'win32yankClipboard',
    copy = {
        ['+'] = 'win32yank.exe -i --crlf',
        ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
        ['+'] = 'win32yank.exe -o --lf',
        ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 1,
}

vim.o.helplang = "ja,en"
vim.wo.cursorline = true
vim.opt.number = true
vim.opt.whichwrap = 'b,s,h,l,<,>'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 4

local term_grp = vim.api.nvim_create_augroup("NeovimTerminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    group = term_grp,
    pattern = "*",
    callback = function()
        vim.opt_local.number = false
        vim.cmd("startinsert")
    end,
})

local manager = require("utils.manager")

local lsp_servers = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = {'vim'} },
                workspace = {
                    library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
                        "${3rd}/luv/library",
                        "${3rd}/busted/library",
                        "${3rd}/luassert/library",
                    }),
                    checkThirdParty = "Disable",
                },
            },
        },
    },
    pylsp = {
        cmd = { "pylsp" },
        settings = {
            pylsp = {
                plugins = {
                    pyflakes = { enabled = true },
                    pylint = { enabled = true },
                },
            },
        },
    },
    rust_analyzer = {},
    html = {},
    cssls = {},
    ts_ls = {},
    jsonls = {},
}

local installed_servers = vim.tbl_keys(lsp_servers)

local function set_keymap(mode, lhs, rhs, plugin_id, opts)
    vim.keymap.set(
        mode, lhs,
        function ()
            manager.load(plugin_id)
            vim.keymap.set(mode, lhs, rhs, opts)
            if type(rhs) == "string" then
                local keys = vim.api.nvim_replace_termcodes(rhs, true, false, true)
                vim.api.nvim_feedkeys(keys, 'n', true)
            else
                rhs()
            end
        end,
        opts
    )
end

manager.add({
    id = "nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons",
    config = function ()
        require("nvim-web-devicons").setup()
    end
})

manager.add({
    id = "plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim",
})

manager.add({
    id = "nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim",
})

manager.add({
    id = "denops.vim",
    url = "https://github.com/vim-denops/denops.vim"
})

manager.add({
    id = "tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim",
    config = function ()
        vim.cmd[[colorscheme tokyonight]]
    end,
})
manager.load("tokyonight.nvim")

manager.add({
    id = "nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter",
})
manager.load("nvim-treesitter")

manager.add({
    id = "nvim-scrollbar",
    url = "https://github.com/petertriho/nvim-scrollbar",
    config = function ()
        require("scrollbar").setup({})
    end
})
manager.add({
    id = "gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim",
    dependencies = { "nvim-scrollbar" },
    config = function ()
        require("gitsigns").setup()
        require("scrollbar.handlers.gitsigns").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("gitsigns.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("gitsigns.nvim")
    end
})

manager.add({
    id = "oil-git-signs.nvim",
    url = "https://github.com/FerretDetective/oil-git-signs.nvim",
    dependencies = {
        "oil.nvim"
    },
    config = function()
        require("oil-git-signs").setup()
    end
})
manager.add({
    id = "oil.nvim",
    url = "https://github.com/stevearc/oil.nvim",
    dependencies = {
        "nvim-web-devicons",
    },
    config = function ()
        require("oil").setup({
            win_options = {
                signcolumn = "yes:2",
                statuscolumn = "",
            },
            view_options = {
                show_hidden = true,
            },
        })
    end
})
set_keymap("n", "<Space>f", "<cmd>Oil<CR>", "oil-git-signs.nvim", { noremap = true, silent = true, desc = "Open oil buffer" })

manager.add({
    id = "nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs",
    config = function ()
        require("nvim-autopairs").setup()
    end
})
vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("nvim-autopairs_load", { clear = true }),
    pattern = "*",
    callback = function()
        manager.load("nvim-autopairs")
    end,
})

manager.add({
    id = "lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-web-devicons",
    },
    config = function()
        require("lualine").setup({
            options = {
                theme = "onedark",
                disabled_filetypes = {
                    winbar = {
                        "dap-repl",
                    },
                },
            },
            sections = {
                lualine_a = {
                    'mode',
                    {
                        function()
                            local _, mode = pcall(vim.fn["skkeleton#mode"])
                            if mode == "hira" then
                                return "全ひ"
                            elseif mode == "kata" then
                                return "全カ"
                            elseif mode == "hankata" then
                                return "半ｶﾀ"
                            elseif mode == "zenkaku" then
                                return "全Ａ"
                            elseif mode == "abbrev" then
                                return "abbr"
                            else
                                return "英ab"
                            end
                        end,
                    }
                },
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
    end
})
manager.load("lualine.nvim")

manager.add({
    id = "smear-cursor.nvim",
    url = "https://github.com/sphamba/smear-cursor.nvim",
    config = function ()
        require("smear_cursor").setup({
            stiffness = 0.5,
            trailing_stiffness = 0.49,
            never_draw_over_target = false,
        })
    end
})
manager.load("smear-cursor.nvim")

manager.add({
    id = "tabset.nvim",
    url = "https://github.com/FotiadisM/tabset.nvim",
    config = function ()
        require("tabset").setup({
            default = {
                tabwidth = 4,
                expandtab = true,
            },
            languages = {
                {
                    filetypes = { "javascript", "typescript", "html", "css", "json", },
                    config = {
                        tabwidth = 2,
                    },
                },
            },
        })
    end
})
manager.load("tabset.nvim")

manager.add({
    id = "Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim",
    config = function ()
        require("Comment").setup({
            toggler = {
                line = "<Space>c",
                block = "<Space>C",
            },
            opleader = {
                line = "<Space>c",
                block = "<Space>C",
            }
        })
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("Comment.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("Comment.nvim")
    end
})

manager.add({
    id = "snacks.nvim",
    url = "https://github.com/folke/snacks.nvim",
    config = function ()
        require("snacks").setup({
            dashboard = { enabled = false },
            input = { enabled = true },
            lazygit = { enabled = true },
            picker = { enabled = true },
        })
        vim.api.nvim_set_keymap("n", "<Space>g", "<Cmd>lua require('snacks').lazygit()<CR>", { noremap = true, silent = true, desc = "Show lazygit" })
        vim.api.nvim_set_keymap("n", "<Space>F", "<Cmd>lua require('snacks').picker.files()<CR>", { noremap = true, silent = true, desc = "Open file picker" })
        vim.api.nvim_set_keymap("n", "<Space>b", "<Cmd>lua require('snacks').picker.buffers()<CR>", { noremap = true, silent = true, desc = "Open buffer picker" })
        vim.api.nvim_set_keymap("n", "<Space>s", "<Cmd>lua require('snacks').picker.symbols()<CR>", { noremap = true, silent = true, desc = "Open symbol picker" })
    end
})
manager.load("snacks.nvim")

manager.add({
    id = "skkeleton",
    url = "https://github.com/vim-skk/skkeleton",
    dependencies = {
        "denops.vim"
    },
    config = function ()
        vim.fn["skkeleton#config"]({
            globalDictionaries = { '~/.config/eskk/SKK-JISYO.L' },
            eggLikeNewline = true,
        })
        vim.keymap.set({"i", "c"}, "<C-s>", "<Plug>(skkeleton-toggle)", { noremap = true, silent = true, desc = "Toggle skkeleton enable/disable" })
    end
})
vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("skkeleton_load", { clear = true }),
    pattern = "*",
    callback = function()
        manager.load("skkeleton")
    end,
})

manager.add({
    id = "mason.nvim",
    url = "https://github.com/mason-org/mason.nvim",
    config = function ()
        require("mason").setup()
    end
})

manager.add({
    id = "mason-lspconfig.nvim",
    url = "https://github.com/mason-org/mason-lspconfig.nvim",
    config = function ()
         require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = installed_servers,
        })
    end
})

manager.add({
    id = "nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig",
})

manager.add({
    id = "ddc-ui-native",
    url = "https://github.com/Shougo/ddc-ui-native"
})

manager.add({
    id = "ddc-source-lsp",
    url = "https://github.com/Shougo/ddc-source-lsp",
    dependencies = {
        "mason.nvim",
        "mason-lspconfig.nvim",
        "nvim-lspconfig"
    },
    config = function ()
        local on_attach = function(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        vim.lsp.config('*', {
            capabilities = require("ddc_source_lsp").make_client_capabilities(),
        })

        local global_on_attach = on_attach
        local servers = {}

        for name, cfg in pairs(lsp_servers) do
            if type(cfg) == "table" then
                local user_attach = cfg.on_attach
                cfg.on_attach = function(client, bufnr)
                    if user_attach then user_attach(client, bufnr) end
                    global_on_attach(client, bufnr)
                end
                vim.lsp.config(name, cfg)
                table.insert(servers, name)
            end
        end

        vim.lsp.enable(servers)

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local bufnr = ev.buf
                if client.server_capabilities.completionProvider then
                    vim.lsp.completion.enable(true, client.id, bufnr)
                end
            end,
        })
    end
})
manager.load("ddc-source-lsp")

manager.add({
    id = "ddc-source-buffer",
    url = "https://github.com/matsui54/ddc-source-buffer"
})

manager.add({
    id = "ddc-source-file",
    url = "https://github.com/LumaKernel/ddc-source-file"
})

manager.add({
    id = "ddc-path",
    url = "https://github.com/tani/ddc-path"
})

manager.add({
    id = "ddc-filter-match_head",
    url = "https://github.com/Shougo/ddc-filter-matcher_head"
})

manager.add({
    id = "ddc-filter-sorter_rank",
    url = "https://github.com/Shougo/ddc-filter-sorter_rank"
})

manager.add({
    id = "ddc-fuzzy",
    url = "https://github.com/tani/ddc-fuzzy"
})

manager.add({
    id = "ddc.vim",
    url = "https://github.com/Shougo/ddc.vim",
    dependencies = {
        "denops.vim",
        "ddc-ui-native",
        "ddc-source-lsp",
        "ddc-source-buffer",
        "ddc-source-file",
        "ddc-path",
        "ddc-filter-match_head",
        "ddc-filter-sorter_rank",
        "ddc-fuzzy",
        "skkeleton"
    },
    config = function ()
        vim.fn["ddc#custom#set_global"]({
            ui = "native",
            sources = { "lsp", "buffer", "file", "path", },
            sourceOptions = {
                _ = {
                    matchers = { "matcher_fuzzy" },
                    sorters = { "sorter_fuzzy" },
                    converters = { "converter_fuzzy", "converter_kind_labels" },
                },
                lsp = {
                    mark = "⚡",
                    forceCompletionPattern = [[\.\w*|::\w*|->\w*]],
                },
                buffer = {
                    mark = "📃",
                },
                file = {
                    mark = "📄",
                },
                path = {
                    mark = "📁",
                },
            },
            sourceParams = {
                lsp = {
                    debounce = 500,
                },
                path = {
                    cmd = { "fd", "--max-depth", "5", },
                },
            },
        })

        vim.fn["ddc#custom#patch_global"]({
            filterParams = {
                converter_kind_labels = {
                    kindLabels = {
                        Text = "󰉿 Text",
                        Method = "󰆧 Method",
                        Function = "󰊕 Function",
                        Constructor = " Constructor",
                        Field = "󰜢 Field",
                        Variable = "󰀫 Variable",
                        Class = "󰠱 Class",
                        Interface = " Interface",
                        Module = " Module",
                        Property = "󰜢 Property",
                        Unit = "󰑭 Unit",
                        Value = "󰎠 Value",
                        Enum = " Enum",
                        Keyword = "󰌋 Keyword",
                        Snippet = " Snippet",
                        Color = "󰏘 Color",
                        File = "󰈙 FIle",
                        Reference = "󰈇 Reference",
                        Folder = "󰉋 Folder",
                        EnumMember = " EnumMember",
                        Constant = "󰏿 Constant",
                        Struct = "󰙅 Struct",
                        Event = " Event",
                        Operator = "󰆕 Operator",
                        TypeParameter = " TypeParameter",
                    }
                }
            }
        })

        vim.keymap.set(
            'i', '<C-j>',
            function()
                return vim.fn.pumvisible()==1 and '<C-n>' or vim.fn['ddc#map#manual_complete']()
            end,
            { expr=true, silent=true, desc='ddc candidate next' }
        )
        vim.keymap.set(
            'i', '<C-k>',
            function()
                return vim.fn.pumvisible()==1 and '<C-p>' or ''
            end,
            { expr=true, silent=true, desc='ddc candidate prev' }
        )
        vim.fn["ddc#custom#patch_filetype"]("skkeleton", {
            sources = { "skkeleton" },
        })

        vim.fn["ddc#custom#patch_global"]({
            sourceOptions = {
                ["skkeleton"] = {
                    mark = 'skkeleton',
                    matchers = {},
                    sorters = {},
                    converters = {},
                    isVolatile = true,
                    minAutoCompleteLength = 1,
                },
            }
        })

        vim.fn["ddc#enable"]()
    end
})
vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("ddc.vim_load", { clear = true }),
    pattern = "*",
    callback = function()
        manager.load("ddc.vim")
    end,
})

manager.add({
    id = "2048.nvim",
    url = "https://github.com/NStefan002/2048.nvim",
    config = function ()
        require("2048").setup({
            keys = {
                up = "<Up>",
                down = "<Down>",
                left = "<Left>",
                right = "<Right>",
            }
        })
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("2048.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("2048.nvim")
    end
})

manager.add({
    id = "fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim",
    config = function ()
        require("fidget").setup()
    end
})
vim.api.nvim_create_autocmd("LspAttach", {
    group = lspattach_plugin_grp,
    pattern = "*",
    callback = function ()
        manager.load("fidget.nvim")
    end
})

manager.add({
    id = "cmdline-hl.nvim",
    url = "https://github.com/Sam-programs/cmdline-hl.nvim",
    config = function ()
        require("cmdline-hl").setup()
    end
})
vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = vim.api.nvim_create_augroup("cmdline-hl.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("cmdline-hl.nvim")
    end
})

manager.add({
    id = "hlchunk.nvim",
    url = "https://github.com/shellRaining/hlchunk.nvim",
    config = function ()
         require("hlchunk").setup({
            chunk = { enable = true, },
            indent = { enable = true, },
            blank = { enable = true, },
        })
    end
})
manager.load("hlchunk.nvim")

manager.add({
    id = "lspsaga.nvim",
    url = "https://github.com/nvimdev/lspsaga.nvim",
    config = function ()
        require("lspsaga").setup({
            lightbulb = { enabled = false }
        })
    end
})
set_keymap("n", "<space>r", "<Cmd>Lspsaga rename<CR>", "lspsaga.nvim", { noremap = true, silent = true, desc = "Rename symbol" })

manager.add({
    id = "mkdir.nvim",
    url = "https://github.com/jghauser/mkdir.nvim",
})
manager.load("mkdir.nvim")

manager.add({
    id = "nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify",
    config = function ()
        require("notify").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("nvim-notify_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("nvim-notify")
    end
})

manager.add({
    id = "noice.nvim",
    url = "https://github.com/folke/noice.nvim",
    dependencies = {
        "nui.nvim",
        "nvim-notify",
        "nvim-treesitter",
    },
    config = function ()
        require("noice").setup()
    end
})
vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = vim.api.nvim_create_augroup("noice.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("noice.nvim")
    end
})

manager.add({
    id = "numb.nvim",
    url = "https://github.com/nacro90/numb.nvim",
    config = function ()
        require("numb").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("numb.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("numb.nvim")
    end
})

manager.add({
    id = "nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua",
    config = function ()
        require("colorizer").setup({
            css = {
                css = true,
                css_fn = true,
            },
            html = {
                css = true,
                css_fn = true,
            },
            javascript = {
                css = true,
                css_fn = true,
            }
        })
    end
})
manager.load("nvim-colorizer.lua")

manager.add({
    id = "nvim-spectre",
    url = "https://github.com/nvim-pack/nvim-spectre",
    dependencies = {
        "plenary.nvim",
        "nvim-web-devicons"
    },
    config = function ()
        require("spectre").setup()
    end
})
set_keymap("n", "<Space>S", "<Cmd>lua require('spectre').toggle()<Cr>", "nvim-spectre", { noremap = true, silent = true, desc = "Toggle spectre" })

manager.add({
    id = "render-markdown.nvim",
    url = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter",
        "nvim-web-devicons",
    },
    config = function ()
        require("render-markdown").setup()
    end
})
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "FileType" }, {
    group = vim.api.nvim_create_augroup("render-markdown.nvim_load", { clear = true }),
    pattern = { "*.md", "*.markdown", "*.norg", "*.rmd", "*.org" },
    callback = function(event)
        manager.load("render-markdown.nvim")
    end,
})

manager.add({
    id = "treesj",
    url = "https://github.com/Wansmer/treesj",
    dependencies = {
        "nvim-treesitter"
    },
    config = function ()
        require("treesj").setup()
    end
})
set_keymap("n", "<Space>t", "<Cmd>lua require('treesj').toggle()<Cr>", "treesj", { noremap = true, silent = true, desc = "Yank to clipboard" })

manager.add({
    id = "which-key.nvim",
    url = "https://github.com/folke/which-key.nvim",
    config = function ()
        require("which-key").setup()
    end
})
manager.load("which-key.nvim")

manager.add({
    id = "wtf.nvim",
    url = "https://github.com/piersolenski/wtf.nvim",
    dependencies = {
        "plenary.nvim",
        "nui.nvim",
    },
    config = function ()
        require("wtf").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("wtf.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("wtf.nvim")
    end
})

manager.add({
    id = "gemini.nvim",
    url = "https://github.com/shizukani-cp/gemini.nvim",
    config = function ()
        require("gemini").setup({
            default_bindings = false
        })
    end
})
set_keymap("n", "<Space>G", "<Cmd>GeminiOpen<Cr>", "gemini.nvim", { noremap = true, silent = true, desc = "Open Gemini CLI" })

manager.add({
    id = "reglist.nvim",
    url = "https://github.com/shizukani-cp/reglist.nvim",
    config = function ()
        require("reglist").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("reglist.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("reglist.nvim")
    end
})

vim.api.nvim_set_keymap('v', '<Space>y', '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.api.nvim_set_keymap('n', '<Space>p', '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.api.nvim_set_keymap('n', '<Space>P', '"+P', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set({'n','x'}, 'gg', 'gg^', { noremap = true, silent = true, desc = "Go to the top of the file" })
vim.keymap.set({'n','x'}, 'G', 'G$', { noremap = true, silent = true, desc = "Go to the end of the file" })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
