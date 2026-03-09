local function config()
    vim.api.nvim_create_autocmd("CursorHold", {
        pattern = "*",
        callback = function()
            require("ufo").peekFoldedLinesUnderCursor()
        end,
    })
    require("ufo").setup({
        provider_selector = function(_, filetype, _)
            if filetype == "dashboard" then
                return
            end
            return { "indent" }
        end,
    })
end

return function(manager)
    manager:add({
        id = "nvim-ufo",
        url = "https://github.com/kevinhwang91/nvim-ufo",
        dependencies = {
            "promise-async",
        },
        config = config,
    })
    manager:lazyload_event("SafeState", "nvim-ufo")
end
