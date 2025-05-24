return {
    "joshuavial/aider.nvim",
    opts = {
        default_bindings = false,
    },
    keys = {
        {
            "<Space>l",
            "<CMD>AiderOpen --model openrouter/mistralai/mistral-7b-instruct:free --dark-mode --read ~/.aiderprmt<CR>",
            desc = "Open Aider",
            mode = "n",
        },
    }
}
