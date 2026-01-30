local M = {}

local function _open_scratch_buffer_with_cursor(lines)
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(win, { 1, 0 })
    vim.api.nvim_buf_set_name(buf, "[Scratch]")
end

M.open_example = function()
    _open_scratch_buffer_with_cursor(require("data.example_file"))
end

return M
