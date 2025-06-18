return {
    "joshuavial/aider.nvim",
    opts = {
        default_bindings = false,
    },
    keys = {
        {
            "<Space>l",
            "<CMD>AiderOpen --model openrouter/mistralai/devstral-small:free --dark-mode --read ~/.aiderprmt<CR>",
            desc = "Open Aider",
            mode = "n",
        },
    }
}
