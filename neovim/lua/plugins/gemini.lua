return {
    "shizukani-cp/gemini.nvim",
    dev = false,
    opts = {
        default_bindings = false,
    },
    keys = {
        {
            "<Space>G",
            "<CMD>GeminiOpen<CR>",
            desc = "Open Gemini CLI",
            mode = "n",
        },
    },
}
