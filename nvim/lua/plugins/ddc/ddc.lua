local function config()
    local ddc_ts_path = vim.fs.joinpath(vim.fn.stdpath("config"), "denops", "ddc.ts")
    vim.fn["ddc#custom#load_config"](ddc_ts_path)

    vim.keymap.set("i", "<C-j>", function()
        return vim.fn.pumvisible() == 1 and "<C-n>" or vim.fn["ddc#map#manual_complete"]()
    end, { expr = true, silent = true, desc = "ddc candidate next" })
    vim.keymap.set("i", "<C-k>", function()
        return vim.fn.pumvisible() == 1 and "<C-p>" or ""
    end, { expr = true, silent = true, desc = "ddc candidate prev" })

    vim.fn["ddc#enable"]()
end

local function add_ddc_plugins(manager)
    manager:add({
        id = "ddc-filter-match_head",
        url = "https://github.com/Shougo/ddc-filter-matcher_head",
    })
    manager:add({
        id = "ddc-filter-sorter_rank",
        url = "https://github.com/Shougo/ddc-filter-sorter_rank",
    })
    manager:add({
        id = "ddc-fuzzy",
        url = "https://github.com/tani/ddc-fuzzy",
    })
    manager:add({
        id = "ddc-path",
        url = "https://github.com/tani/ddc-path",
    })
    manager:add({
        id = "ddc-source-buffer",
        url = "https://github.com/matsui54/ddc-source-buffer",
    })
    manager:add({
        id = "ddc-source-cmdline",
        url = "https://github.com/Shougo/ddc-source-cmdline",
    })
    manager:add({
        id = "ddc-source-file",
        url = "https://github.com/LumaKernel/ddc-source-file",
    })
    manager:add({
        id = "ddc-source-lsp",
        url = "https://github.com/Shougo/ddc-source-lsp",
    })
    manager:add({
        id = "ddc-ui-native",
        url = "https://github.com/Shougo/ddc-ui-native",
    })
end

return function(manager)
    add_ddc_plugins(manager)
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
