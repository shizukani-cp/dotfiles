return {
    'vim-skk/skkeleton',
    event = "InsertEnter",
    dependencies = {
        "vim-denops/denops.vim",
        "Shougo/ddc.vim",
        "Shougo/ddc-ui-native",
    },
    config = function()
        vim.fn["skkeleton#config"]({
            globalDictionaries = { '~/.config/eskk/SKK-JISYO.L' },
            eggLikeNewline = true,
        })
        vim.fn["ddc#custom#patch_global"]('ui', 'native')
        vim.fn["ddc#custom#patch_global"]('sources', { 'skkeleton' })
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
    end,
    keys = {
        {
            "<C-s>",
            "<Plug>(skkeleton-enable)",
            mode = { "i", "c" },
            desc = "skkeleton enable",
        },
    },
}
