local lazyload = require("manager.lazyload")

local function config()
    vim.api.nvim_create_autocmd("CursorHold", {
        pattern = "*",
        callback = function()
            require('ufo').peekFoldedLinesUnderCursor()
        end,
    })
    require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
            if filetype == "dashboard" then
                return
            end
            return { 'indent' }
        end
    })
end

return function(manager)
    manager.add({
        id = "nvim-ufo",
        url = "https://github.com/kevinhwang91/nvim-ufo",
        dependencies = {
            "promise-async",
        },
        config = config,
    })
    lazyload.event("BufWinEnter", "nvim-ufo")
end
