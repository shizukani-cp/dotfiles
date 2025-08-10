local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "ddu.vim",
    url = "https://github.com/Shougo/ddu.vim",
    dependencies = {
        "ddu-filter-matcher_substring",
        "ddu-kind-file",
        "ddu-source-buffer",
        "ddu-source-file_rec",
        "ddu-source-lsp",
        "ddu-ui-ff",
        "denops.vim",
    },
    config = function ()
        vim.fn["ddu#custom#set_global"]({
            ui = "ff",
            uiParams = {
                ff = {
                    filterFloatingPosition = "bottom",
                    filterSplitDirection = "floating",
                    floatingBorder = "rounded",
                    previewSplit = "horizontal",
                    previewFloating = true,
                    previewFloatingBorder = "rounded",
                    previewFloatingTitle = "Preview",
                    prompt = "> ",
                    split = "floating",
                    startFilter = true,
                }
            },
            sourceOptions = {
                _ = {
                    matchers = { "matcher_substring" },
                    ignoreCase = true,
                },
                file_rec = {},
                lsp_documentSymbol = {
                    converters = { "converter_lsp_symbol" }
                }
            },
            kindOptions = {
                file = {
                    defaultAction = "open",
                },
                colorscheme = {
                    defaultAction = "set",
                },
                lsp = {
                    defaultAction = "open",
                },
            },
        })

        vim.fn["ddu#custom#patch_local"]("file_recursive", {
            sources = {
                { name = { "file_rec" } },
            },
            kindOptions = {
                file = { defaultAction = "open" },
            },
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "ddu-ff",
            callback = function()
                local opts = { noremap = true, silent = true, buffer = true }
                vim.keymap.set("n", "q", [[<Cmd>call ddu#ui#do_action("quit")<CR>]], opts)
                vim.keymap.set("n", "<CR>", [[<Cmd>call ddu#ui#do_action("itemAction")<CR>]], opts)
                vim.keymap.set("n", "i", [[<Cmd>call ddu#ui#do_action("openFilterWindow")<CR>]], opts)
                vim.keymap.set("n", "P", [[<Cmd>call ddu#ui#do_action("togglePreview")<CR>]], opts)
            end,
        })
    end
})
set_keymap("n", "<Space>F", "<Cmd>call ddu#start({ 'sources': ['file_rec'], 'ui': 'ff' })<CR>", "ddu.vim", { noremap = true, silent = true, desc = "Open File Picker." })
set_keymap("n", "<Space>b", "<Cmd>call ddu#start({ 'sources': ['buffer'], 'ui': 'ff' })<CR>", "ddu.vim", { noremap = true, silent = true, desc = "Open Buffer Picker." })
set_keymap("n", "<Space>s", "<Cmd>call ddu#start({ 'sources': ['lsp_documentSymbol'], 'ui': 'ff' })<CR>", "ddu.vim", { noremap = true, silent = true, desc = "Open Symbol Picker." })
