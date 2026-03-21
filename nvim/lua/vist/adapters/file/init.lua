---@alias Vist.Adapters.File.Action.Kind "create" | "delete" | "rename"

local data = { protocol = "vist-file://", cache = {} }

local function bufname()
    return data.protocol .. vim.fn.expand("%:p:h")
end

local function list()
    local cwd = vim.fn.getcwd()
    local files = vim.fn.readdir(cwd)
    local items = {}
    data.cache = {}

    for i, name in ipairs(files) do
        local item = { id = i, display = name }
        table.insert(items, item)
        data.cache[i] = name
    end
    return items
end

local function parse(diff)
    vim.print(diff)
    return {
        { kind = "create" },
    }
end

local function do_action(action)
    local _ = action
end

---@type Vist.Adapter
local M = {
    bufname = bufname,
    list = list,
    parse = parse,
    do_action = do_action,
    data = data,
}

return M
