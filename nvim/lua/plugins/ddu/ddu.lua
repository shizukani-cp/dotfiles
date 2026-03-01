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

local function open_ddu_func(source_name)
    return function()
        vim.fn["ddu#start"]({
            sources = { source_name },
            ui = "ff",
        })
    end
end

return function(manager)
    manager:add({
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
            "ddu-source-ghq",
            "ddu-source-keymap",
            "ddu-source-lsp",
            "ddu-source-manager",
            "ddu-ui-ff",
            "denops.vim",
        },
        config = config,
    })

    manager:lazyload_key(
        "n",
        "<Leader>pf",
        open_ddu_func("file_rec"),
        "ddu.vim",
        { noremap = true, silent = true, desc = "File" }
    )
    manager:lazyload_key(
        "n",
        "<Leader>pb",
        open_ddu_func("buffer"),
        "ddu.vim",
        { noremap = true, silent = true, desc = "Buffer" }
    )
    manager:lazyload_key(
        "n",
        "<Leader>ps",
        open_ddu_func("lsp_documentSymbol"),
        "ddu.vim",
        { noremap = true, silent = true, desc = "LSP Symbol" }
    )
    manager:lazyload_key(
        "n",
        "<Leader>pp",
        open_ddu_func("manager_plugins"),
        "ddu.vim",
        { noremap = true, silent = true, desc = "Plugin List" }
    )
    manager:lazyload_key(
        "n",
        "<Leader>pl",
        open_ddu_func("manager_logs"),
        "ddu.vim",
        { noremap = true, silent = true, desc = "manager.nvim logs" }
    )
    manager:lazyload_key(
        "n",
        "<Leader>pg",
        open_ddu_func("git_status"),
        "ddu.vim",
        { noremap = true, silent = true, desc = "Git Status" }
    )
    manager:lazyload_key(
        "n",
        "<Leader>pk",
        open_ddu_func("keymap"),
        "ddu.vim",
        { noremap = true, silent = true, desc = "Keymap" }
    )
    manager:lazyload_key(
        "n",
        "<Leader>pa",
        open_ddu_func("action"),
        "ddu.vim",
        { noremap = true, silent = true, desc = "Action" }
    )
    manager:lazyload_key(
        "n",
        "<Leader>pc",
        open_ddu_func("command_history"),
        "ddu.vim",
        { noremap = true, silent = true, desc = "Command History" }
    )
    manager:lazyload_key(
        "n",
        "<Leader>ph",
        open_ddu_func("ghq"),
        "ddu.vim",
        { noremap = true, silent = true, desc = "ghq" }
    )
end
