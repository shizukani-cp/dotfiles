return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        adapters = {
            ollama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    schema = {
                        model = {
                            default = "phi4-mini:latest",
                        },
                    },
                })
            end,
        },
        strategies = {
            chat = {
                adapter = "ollama",
            },
            inline = {
                adapter = "ollama",
            },
            agent = {
                adapter = "ollama",
            },
        },
        language = "Japanese",
    },
    keys = {
        {
            "<Space>l",
            "<Cmd>CodeCompanionChat<Cr>",
            mode = { "n" },
            silent = true,
            desc = "chat with llm",
        }
    }
}
