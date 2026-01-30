local lazyload = require("manager.lazyload")

local function config()
    vim.fn["ddu#custom#set_global"]({
        ui = "ff",
        uiParams = {
            ff = {
                startAutoAction = true,
                autoAction = {
                    name = "preview",
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
            },
        },
        sourceOptions = {
            _ = {
                matchers = { "matcher_substring" },
                converters = { "converter_devicon", "converter_hl_dir" },
                ignoreCase = true,
            },
            action = {},
            buffer = {},
            command_history = {},
            file_rec = {},
            git_status = {},
            keymap = {},
            manager_plugins = {
                sorters = { "sorter_alpha" },
            },
            lsp_documentSymbol = {
                converters = { "converter_lsp_symbol" },
            },
        },
        sourceParams = {
            manager_logs = {
                level = 1,
            },
        },
        kindOptions = {
            action = {
                defaultAction = "do",
            },
            file = {
                defaultAction = "open",
            },
            git_status = {
                defaultAction = "open",
            },
            keymap = {
                defaultAction = "type",
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
    vim.api.nvim_set_hl(0, "MyStatusHL", { fg = "#569CD6" })
end

return function(manager)
    manager.add({
        id = "ddu.vim",
        url = "https://github.com/Shougo/ddu.vim",
        dependencies = {
            "ddu-filter-converter_devicon",
            "ddu-filter-converter_hl_dir",
            "ddu-filter-matcher_substring",
            "ddu-filter-sorter_alpha",
            "ddu-kind-file",
            "ddu-source-action",
            "ddu-source-buffer",
            "ddu-source-command_history",
            "ddu-source-file_rec",
            "ddu-source-git_status",
            "ddu-source-keymap",
            "ddu-source-lsp",
            "ddu-source-manager",
            "ddu-ui-ff",
            "denops.vim",
        },
        config = config,
    })

    lazyload.key(
        "n",
        "<Leader>pf",
        "<Cmd>call ddu#start({ 'sources': ['file_rec'], 'ui': 'ff' })<CR>",
        "ddu.vim",
        { noremap = true, silent = true, desc = "File" }
    )
    lazyload.key(
        "n",
        "<Leader>pb",
        "<Cmd>call ddu#start({ 'sources': ['buffer'], 'ui': 'ff' })<CR>",
        "ddu.vim",
        { noremap = true, silent = true, desc = "Buffer" }
    )
    lazyload.key(
        "n",
        "<Leader>ps",
        "<Cmd>call ddu#start({ 'sources': ['lsp_documentSymbol'], 'ui': 'ff' })<CR>",
        "ddu.vim",
        { noremap = true, silent = true, desc = "LSP Symbol" }
    )
    lazyload.key(
        "n",
        "<Leader>pp",
        "<Cmd>call ddu#start({ 'sources': ['manager_plugins'], 'ui': 'ff' })<CR>",
        "ddu.vim",
        { noremap = true, silent = true, desc = "Plugin List" }
    )
    lazyload.key(
        "n",
        "<Leader>pl",
        "<Cmd>call ddu#start({ 'sources': ['manager_logs'], 'ui': 'ff' })<CR>",
        "ddu.vim",
        { noremap = true, silent = true, desc = "manager.nvim logs" }
    )
    lazyload.key(
        "n",
        "<Leader>pg",
        "<Cmd>call ddu#start({ 'sources': ['git_status'], 'ui': 'ff' })<CR>",
        "ddu.vim",
        { noremap = true, silent = true, desc = "Git Status" }
    )
    lazyload.key(
        "n",
        "<Leader>pk",
        "<Cmd>call ddu#start({ 'sources': ['keymap'], 'ui': 'ff' })<CR>",
        "ddu.vim",
        { noremap = true, silent = true, desc = "Keymap" }
    )
    lazyload.key(
        "n",
        "<Leader>pa",
        "<Cmd>call ddu#start({ 'sources': ['action'], 'ui': 'ff' })<CR>",
        "ddu.vim",
        { noremap = true, silent = true, desc = "Action" }
    )
    lazyload.key(
        "n",
        "<Leader>pc",
        "<Cmd>call ddu#start({ 'sources': ['command_history'], 'ui': 'ff' })<CR>",
        "ddu.vim",
        { noremap = true, silent = true, desc = "Command History" }
    )
end
