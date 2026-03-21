---@alias Vist.Adapters.File.Action.Kind "create" | "delete" | "rename"

local function list()
    return {
        { id = 1, display = "test.txt" },
    }
end

local function parse(lines)
    local _ = lines
    return {
        { kind = "create" },
    }
end

local function do_action(action)
    local _ = action
end

---@type Vist.Adapter
local M = {
    list = list,
    parse = parse,
    do_action = do_action,
}

return M
