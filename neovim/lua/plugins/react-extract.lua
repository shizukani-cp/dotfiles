local lazyload = require("utils.lazyload")

local function config()
    require("react-extract").setup()
end

return function(manager)
    manager.add({
        id = "react-extract.nvim",
        url = "https://github.com/napmn/react-extract.nvim",
        config = config,
    })
    lazyload.key('x', '<Leader>crn', function() require("react-extract").extract_to_new_file() end, "react-extract.nvim",
        { noremap = true, silent = true, desc = "Export as a new file in a React component" })
    lazyload.key('x', '<Leader>crc', function() require("react-extract").extract_to_new_file() end, "react-extract.nvim",
        { noremap = true, silent = true, desc = "Export as a current file in a React component" })
end
