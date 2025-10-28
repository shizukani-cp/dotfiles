local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "dial.nvim",
    url = "https://github.com/monaqa/dial.nvim",
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group {
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias["%Y/%m/%d"],
            },
        }
    end
})

lazyload.key("n", "<C-a>", function()
    require("dial.map").manipulate("increment", "normal")
end, "dial.nvim")

lazyload.key("n", "<C-x>", function()
    require("dial.map").manipulate("decrement", "normal")
end, "dial.nvim")

lazyload.key("n", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gnormal")
end, "dial.nvim")

lazyload.key("n", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gnormal")
end, "dial.nvim")

lazyload.key("x", "<C-a>", function()
    require("dial.map").manipulate("increment", "visual")
end, "dial.nvim")

lazyload.key("x", "<C-x>", function()
    require("dial.map").manipulate("decrement", "visual")
end, "dial.nvim")

lazyload.key("x", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gvisual")
end, "dial.nvim")

lazyload.key("x", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gvisual")
end, "dial.nvim")
