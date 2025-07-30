local manager = require("utils.manager")

manager.add({
    id = "smear-cursor.nvim",
    url = "https://github.com/sphamba/smear-cursor.nvim",
    config = function ()
        require("smear_cursor").setup({
            stiffness = 0.5,
            trailing_stiffness = 0.49,
            never_draw_over_target = false,
        })
    end
})
manager.load("smear-cursor.nvim")
