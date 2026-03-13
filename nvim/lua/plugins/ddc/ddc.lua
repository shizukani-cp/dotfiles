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
