--- @diagnostic disable: duplicate-set-field

--- @class Defaults
--- @field title? string
--- @field padding? table
--- @field min_width? integer
--- @field max_width? integer
--- @field border? boolean
--- @field border_chars? string[]
--- @field show_refs? boolean
--- @field with_qf_list? boolean
--- @field with_popup? boolean
--- @field mappings? string
--- @field handler? function

local function config()
    require("renamer").setup({})
end

return function(manager)
    manager:add({
        id = "renamer.nvim",
        url = "https://github.com/filipdutescu/renamer.nvim",
        dependencies = {
            "plenary.nvim",
        },
        config = config,
    })

    manager:lazyload_key(
        "n",
        "<Leader>cr",
        "<Cmd>lua require('renamer').rename()<Cr>",
        "renamer.nvim",
        { noremap = true, silent = true, desc = "Rename symbol" }
    )
    manager:lazyload_key(
        "v",
        "<Leader>r",
        "<Cmd>lua require('renamer').rename()<Cr>",
        "renamer.nvim",
        { noremap = true, silent = true, desc = "Rename symbol" }
    )
end
