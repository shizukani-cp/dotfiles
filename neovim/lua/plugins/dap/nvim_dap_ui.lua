return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "nvim-neotest/nvim-nio",
        { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
    opts = {
        controls = {
            element = "repl",
        },
    },
}
