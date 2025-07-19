return {
    "Shougo/ddc.vim",
    dependencies = {
        "vim-denops/denops.vim",
        "Shougo/ddc-ui-native",
        "Shougo/ddc-source-lsp",
        "matsui54/ddc-source-buffer",
        "LumaKernel/ddc-source-file",
        "tani/ddc-path",
        "Shougo/ddc-filter-matcher_head",
        "Shougo/ddc-filter-sorter_rank",
        "tani/ddc-fuzzy",
    },
    config = function()
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

        vim.fn["ddc#enable"]()
    end,
    keys = {
        {
            "<C-Space>",
            function ()
                vim.fn["ddc#pum#open()"]()
            end,
        }
    }
}
