return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        {
            "mfussenegger/nvim-dap",
            config = function ()
                local dap = require("dap")
                dap.adapters.gdb = {
                    type = "executable",
                    command = "gdb",
                    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
                }
            end
        },
        {
            "mfussenegger/nvim-dap-python",
            config = function ()
                require("dap-python").setup("uv")
            end
        },
        "nvim-neotest/nvim-nio",
        { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
    opts = {
        controls = {
            element = "repl",
        },
    },
}
