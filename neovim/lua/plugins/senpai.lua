return {
    "eetann/senpai.nvim",
    build = "bun install",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        {
            "<space>l",
            "<Cmd>Senpai toggleChat<CR>",
            mode = { "n", },
            silent = true,
            desc = "Chat with LLM"
        },
    },
    cmd = { "Senpai" },
    ft = "gitcommit",
    opts = {
        providers = {
            default = "openrouter",
            openrouter = { model_id = "meta-llama/llama-4-scout:free" },
        },
    }
}
