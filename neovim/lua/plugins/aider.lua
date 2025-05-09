return {
    "joshuavial/aider.nvim",
    opts = {
        default_bindings = false,
    },
    keys = {
        {
            "<Space>l",
            "<CMD>AiderOpen --model openrouter/mistralai/mistral-7b-instruct:free<CR>",
            desc = "Open Aider",
            mode = "n",
        },
    }
}
