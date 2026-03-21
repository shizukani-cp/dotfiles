---@alias Vist.Adapters.File.Action.Kind "create" | "delete" | "rename"

local M = { protocol = "vist-file://", cache = {} }

function M.bufname()
    return M.protocol .. vim.fn.expand("%:p:h")
end

function M.list()
    local cwd = vim.fn.getcwd()
    local files = vim.fn.readdir(cwd)
    local items = {}
    M.cache = {}

    for i, name in ipairs(files) do
        local item = { id = i, display = name }
        table.insert(items, item)
        M.cache[i] = name
    end
    return items
end

function M.parse(state)
    local actions = {}
    local current_ids = {}

    for _, item in ipairs(state) do
        if item.id then
            current_ids[item.id] = true
            local old_name = M.cache[item.id]
            if old_name and old_name ~= item.text then
                table.insert(actions, {
                    kind = "rename",
                    data = { old = old_name, new = item.text },
                })
            end
        else
            if item.text ~= "" then
                table.insert(actions, { kind = "create", data = { name = item.text } })
            end
        end
    end

    for id, name in pairs(M.cache) do
        if not current_ids[id] then
            table.insert(actions, { kind = "delete", data = { name = name } })
        end
    end

    return actions
end

function M.do_action(action)
    local cwd = vim.fn.getcwd()
    if action.kind == "rename" then
        local old_path = vim.fs.joinpath(cwd, action.data.old)
        local new_path = vim.fs.joinpath(cwd, action.data.new)
        os.rename(old_path, new_path)
    elseif action.kind == "delete" then
        local path = vim.fs.joinpath(cwd, action.data.name)
        os.remove(path)
    elseif action.kind == "create" then
        local path = vim.fs.joinpath(cwd, action.data.name)
        local f = io.open(path, "w")
        if f then
            f:close()
        end
    end
end

return M --[[@as Vist.Adapter]]
