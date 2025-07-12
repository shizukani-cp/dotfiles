return {
    'vim-skk/skkeleton',
    event = "InsertEnter",
    dependencies = {
        "vim-denops/denops.vim",
        "Shougo/ddc.vim",
    },
    config = function()
        vim.fn["skkeleton#config"]({
            globalDictionaries = { '~/.config/eskk/SKK-JISYO.L' },
            eggLikeNewline = true,
        })

        -- ddc.vim の設定
        -- skkeleton が有効なとき (filetype=skkeleton) の ddc の設定
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
    end,
    keys = {
        {
            "<C-s>",
            "<Plug>(skkeleton-toggle)",
            mode = { "i", "c" },
            desc = "toggle skkeleton enable/disable",
        },
    },
}
