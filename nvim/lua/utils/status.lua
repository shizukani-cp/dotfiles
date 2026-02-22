---@alias status.Component fun(): string?
---@alias status.Config { components: { left: (status.Component|string)[], right: (status.Component|string)[] } }

local M = {}

---@type status.Config
M.config = {
    components = { left = {}, right = {} },
}

function M.setup(user_config)
    M.config = vim.tbl_deep_extend("force", M.config, user_config or {})
end

---@param item status.Component|string
---@return string
local function safe_call(item)
    if type(item) == "string" then
        return item
    end
    if type(item) ~= "function" then
        return ""
    end

    local ok, res = pcall(item)
    if not ok then
        return "[Error]"
    end

    return type(res) == "string" and res or ""
end

---@param list (status.Component|string)[]
local function build_section(list)
    local res = {}
    for _, item in ipairs(list) do
        local val = safe_call(item)
        if val ~= "" then
            table.insert(res, val)
        end
    end
    return table.concat(res, " ")
end

function M.render()
    local left = build_section(M.config.components.left)
    local right = build_section(M.config.components.right)

    return left .. "%=" .. right .. " "
end

return M
