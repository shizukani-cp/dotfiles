local M = {}

local manager = require("manager")

function M.setup()
    vim.api.nvim_create_user_command("Manager", function(opts)
        local args = opts.fargs
        local sub = args[1]
        local target = args[2]

        if not sub then
            vim.notify("Usage: :Manager <load|lock|unlock|update|clean|remove|list> [plugin_id]", vim.log.levels.WARN)
            return
        end

        if sub == "load" then
            if not target then
                vim.notify("Please specify plugin id to load.", vim.log.levels.WARN)
                return
            end
            manager.load(target)
        elseif sub == "lock" then
            manager.lock()
            vim.notify("Manager locked.")
        elseif sub == "unlock" then
            manager.unlock()
            vim.notify("Manager unlocked and queued loads processed.")
        elseif sub == "update" then
            manager.update(target)
            if target then
                vim.notify("Updating plugin: " .. target)
            else
                vim.notify("Updating all plugins.")
            end
        elseif sub == "clean" then
            manager.clean()
            vim.notify("Clean completed. Untracked plugins removed.")
        elseif sub == "remove" then
            if not target then
                vim.notify("Please specify plugin id to remove.", vim.log.levels.WARN)
                return
            end
            manager.remove(target)
        elseif sub == "list" then
            local buf = vim.api.nvim_create_buf(false, true)
            local ids = {}

            for name, _ in pairs(manager.plugins or {}) do
                table.insert(ids, name)
            end

            if #ids == 0 then
                ids = { "No plugins found" }
            else
                table.sort(ids)
            end

            vim.api.nvim_buf_set_lines(buf, 0, -1, false, ids)
            vim.api.nvim_set_current_buf(buf)
        else
            vim.notify("Unknown subcommand: " .. sub, vim.log.levels.ERROR)
        end
    end, {
        nargs = "*",
        complete = function(_, line)
            local subcmds = { "load", "lock", "unlock", "update", "clean", "remove", "list" }
            local args = vim.split(line, "%s+")
            if #args == 2 then
                return vim.tbl_filter(function(item)
                    return vim.startswith(item, args[2])
                end, subcmds)
            elseif #args == 3 and vim.tbl_contains({ "load", "remove", "update" }, args[2]) then
                return vim.tbl_keys(manager.plugins)
            end
            return {}
        end,
    })
end

return M
