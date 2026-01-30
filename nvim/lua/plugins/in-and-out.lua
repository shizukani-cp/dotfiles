local lazyload = require("manager.lazyload")

local function config() end

return function(manager)
    manager.add({
        id = "in-and-out.nvim",
        url = "https://github.com/ysmb-wtsg/in-and-out.nvim",
        config = config,
    })
    lazyload.key("i", "<C-CR>", function()
        require("in-and-out").in_and_out()
    end)
end
