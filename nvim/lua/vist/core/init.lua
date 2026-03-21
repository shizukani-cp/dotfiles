---@class Vist.Item
---@field id number
---@field display? string
---@field data? any

---@class Vist.Action<T>
---@field kind `T`
---@field data? any

---@class Vist.Adapter
---@field list fun(): Vist.Item[]
---@field parse? fun(lines: string[]): Vist.Action<any>[]
---@field do_action? fun(action: Vist.Action<any>)

local M = {}

---@param adapter Vist.Adapter
function M.open(adapter)
    local items = adapter.list()
    local lines = {}
    for _, item in ipairs(items) do
        local text = item.display or tostring(item.id) or ""
        table.insert(lines, text)
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_current_buf(buf)
    vim.bo[buf].modified = false
    vim.bo[buf].buftype = "acwrite"
    vim.bo[buf].bufhidden = "hide"

    local ns_id = vim.api.nvim_create_namespace("vist")
    for i, item in ipairs(items) do
        local row = i - 1
        vim.api.nvim_buf_set_extmark(buf, ns_id, row, 0, {
            id = item.id,
        })
    end
end

return M
