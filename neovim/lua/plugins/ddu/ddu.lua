local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "ddu.vim",
    url = "https://github.com/Shougo/ddu.vim",
    dependencies = {
        "ddu-filter-converter_devicon",
        "ddu-filter-matcher_substring",
        "ddu-kind-file",
        "ddu-source-buffer",
        "ddu-source-file_rec",
        "ddu-source-line_dir",
        "ddu-source-lsp",
        "ddu-ui-ff",
        "denops.vim",
    },
    config = function()
        vim.fn["ddu#custom#set_global"]({
            ui = "ff",
            uiParams = {
                ff = {
                    startAutoAction = true,
                    autoAction = {
                        name = "preview"
                    },
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
                    converters = { "converter_devicon" },
                    ignoreCase = true,
                },
                buffer = {},
                file_rec = {},
                manager = {
                    sorters = { "manager_sorter" },
                    converters = { "manager_converter" }
                },
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
            end,
        })
        vim.api.nvim_set_hl(0, 'MyStatusHL', { fg = '#569CD6' })
    end
})

lazyload.key("n", "<Leader>pf", "<Cmd>call ddu#start({ 'sources': ['file_rec'], 'ui': 'ff' })<CR>", "ddu.vim",
    { noremap = true, silent = true, desc = "Open File Picker." })
lazyload.key("n", "<Leader>pb", "<Cmd>call ddu#start({ 'sources': ['buffer'], 'ui': 'ff' })<CR>", "ddu.vim",
    { noremap = true, silent = true, desc = "Open Buffer Picker." })
lazyload.key("n", "<Leader>ps", "<Cmd>call ddu#start({ 'sources': ['lsp_documentSymbol'], 'ui': 'ff' })<CR>", "ddu.vim",
    { noremap = true, silent = true, desc = "Open Symbol Picker." })
lazyload.key("n", "<Leader>pp", "<Cmd>call ddu#start({ 'sources': ['manager'], 'ui': 'ff' })<CR>", "ddu.vim",
    { noremap = true, silent = true, desc = "Open Plugin List." })
lazyload.key("n", "<Leader>pl", "<Cmd>call ddu#start({ 'sources': ['line_dir'], 'ui': 'ff' })<CR>", "ddu.vim",
    { noremap = true, silent = true, desc = "Open Line Picker" })
