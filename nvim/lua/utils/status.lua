---@alias status.Component fun(): string?
---@alias status.Config { components: { left: (status.Component|string)[], right: (status.Component|string)[] } }

local M = {}

M.mode_map = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",
    c = "COMMAND",
    R = "REPLACE",
    t = "TERMINAL",
}

---@type status.Config
M.config = {
    components = { left = {}, right = {} },
    mode_hl = function()
        local raw_mode = vim.api.nvim_get_mode().mode
        local first_char = string.sub(raw_mode, 1, 1)
        return M.mode_map[first_char] or raw_mode
    end,
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
    local mode_name = M.config.mode_hl()

    local hl_group = "Status" .. mode_name:gsub("-", "")

    local hl = "%#" .. hl_group .. "#"
    local label = mode_name

    local left = build_section(M.config.components.left)
    local right = build_section(M.config.components.right)

    return hl .. " " .. label .. " " .. "%#StatusMain# " .. left .. "%=" .. right .. " "
end

return M
