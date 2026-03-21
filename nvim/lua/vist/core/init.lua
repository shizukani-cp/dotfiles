---@class Vist.Item
---@field id number
---@field display? string
---@field data? any

---@class Vist.Action<T>
---@field kind `T`
---@field data? any

---@class Vist.State
---@field id? number
---@field line string

---@class Vist.Adapter
---@field bufname fun(): string
---@field list fun(): Vist.Item[]
---@field parse? fun(state: Vist.State[]): Vist.Action<any>[]
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
    vim.api.nvim_buf_set_name(buf, adapter.bufname())
    vim.bo[buf].modified = false
    vim.bo[buf].buftype = "acwrite"
    vim.bo[buf].bufhidden = "hide"

    local ns_id = vim.api.nvim_create_namespace("vist")
    for i, item in ipairs(items) do
        local row = i - 1
        vim.api.nvim_buf_set_extmark(buf, ns_id, row, 0, {
            id = item.id,
            invalidate = true,
        })
    end

    vim.api.nvim_create_autocmd("BufWriteCmd", {
        buffer = buf,
        callback = function()
            local ns = vim.api.nvim_create_namespace("vist")
            local current_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            local state = {}

            for i, line in ipairs(current_lines) do
                local marks = vim.api.nvim_buf_get_extmarks(0, ns, { i - 1, 0 }, { i - 1, -1 }, {})
                local id = nil
                if #marks > 0 then
                    id = marks[#marks][1]
                end
                table.insert(state, { id = id, text = line })
            end

            local actions = adapter.parse(state)
            for _, action in ipairs(actions) do
                adapter.do_action(action)
            end
            vim.bo[buf].modified = false
        end,
    })
end

return M
