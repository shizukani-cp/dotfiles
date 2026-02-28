local function config()
    vim.fn["ddc#custom#set_global"]({
        ui = "native",
        sources = { "denippet", "cmdline", "lsp", "buffer", "file", "path" },
        sourceOptions = {
            _ = {
                matchers = { "matcher_fuzzy" },
                sorters = { "sorter_fuzzy" },
                converters = { "converter_fuzzy" },
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
            denippet = {
                mark = "🧩",
            },
            cmdline = {
                mark = "⚙️",
            },
        },
        sourceParams = {
            lsp = {
                debounce = 500,
            },
            path = {
                cmd = { "fd", "--max-depth", "3" },
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
                },
            },
        },
    })

    vim.keymap.set("i", "<C-j>", function()
        return vim.fn.pumvisible() == 1 and "<C-n>" or vim.fn["ddc#map#manual_complete"]()
    end, { expr = true, silent = true, desc = "ddc candidate next" })
    vim.keymap.set("i", "<C-k>", function()
        return vim.fn.pumvisible() == 1 and "<C-p>" or ""
    end, { expr = true, silent = true, desc = "ddc candidate prev" })
    vim.fn["ddc#custom#patch_filetype"]("skkeleton", {
        sources = { "skkeleton" },
    })

    vim.fn["ddc#custom#patch_global"]({
        sourceOptions = {
            ["skkeleton"] = {
                mark = "skkeleton",
                matchers = {},
                sorters = {},
                converters = {},
                isVolatile = true,
                minAutoCompleteLength = 1,
            },
        },
    })

    vim.fn["ddc#enable"]()
end

return function(manager)
    manager:add({
        id = "ddc.vim",
        url = "https://github.com/Shougo/ddc.vim",
        dependencies = {
            "denops.vim",
            "ddc-ui-native",
            "ddc-source-lsp",
            "ddc-source-buffer",
            "ddc-source-cmdline",
            "ddc-source-file",
            "ddc-path",
            "ddc-filter-match_head",
            "ddc-filter-sorter_rank",
            "ddc-fuzzy",
            "denippet.vim",
            "skkeleton",
        },
        config = config,
    })
    manager:lazyload_event("InsertEnter", "ddc.vim")
end
