---@alias Vist.Adapters.File.Action.Kind "create" | "delete" | "rename"

local protocol = "vist-file://"

local function bufname()
    return protocol .. vim.fn.expand("%:p:h")
end

local function list()
    return {
        { id = 1, display = "test.txt" },
    }
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
}

return M
