return {
    'vim-skk/skkeleton',
    event = "InsertEnter",
    dependencies = {
        "vim-denops/denops.vim",
    },
    config = function()
        vim.fn["skkeleton#config"]({
            globalDictionaries = { '~/.config/eskk/SKK-JISYO.L' },
            eggLikeNewline = true,
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
