local lazyload = require("utils.lazyload")

local function config()
    local sm = require("nvim-submode")
    local leave_normal_sm = sm.build_submode(
        {
            name = "EXINS",
            color = "#7DB9B4",
            after_enter = function()
                vim.schedule(function() require("lualine").refresh() end)
            end,
            after_leave = function()
                vim.schedule(function() require("lualine").refresh() end)
            end,
            is_count_enable = false
        },
        { { 'j',
            function()
                vim.cmd [[stopinsert]]
                vim.cmd [[write]]
                return '', sm.EXIT_SUBMODE
            end
        }, { 'k',
            function()
                vim.cmd [[stopinsert]]
                return '', sm.EXIT_SUBMODE
            end
        }, { 'h',
            function()
                vim.cmd [[stopinsert]]
                vim.cmd [[write]]
                vim.cmd [[quit]]
                return '', sm.EXIT_SUBMODE
            end
        }, { '<any>',
            function(_, keys, anys)
                local any_key = sm.replace_any(keys, anys)
                local pos = vim.api.nvim_win_get_cursor(0)
                local row, col = pos[1], pos[2]
                local line = vim.api.nvim_get_current_line()
                local new_line = line:sub(1, col) .. "f" .. any_key .. line:sub(col + 1)
                vim.api.nvim_set_current_line(new_line)
                vim.api.nvim_win_set_cursor(0, { row, col + 2 })
                return '', sm.EXIT_SUBMODE
            end
        } }
    )
    vim.keymap.set({ "i", "c" }, "f", function()
        sm.enable(leave_normal_sm)
    end)
end

return function(manager)
    manager.add({
        id = "nvim-submode",
        url = "https://github.com/sirasagi62/nvim-submode",
        dependencies = {
            "lualine.nvim"
        },
        config = config,
    })
    lazyload.event("VimEnter", "nvim-submode")
end
