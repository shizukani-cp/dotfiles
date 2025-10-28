local M = {}

M.example_string = {
    "Yesterday was so bad day.",
    "My code exploded, my tea spilled, and my hope vanished.",
    "But, today is so good day.",
    "I found one missing semicolon.",
    "Life is beautiful again.",
}

local function _open_scratch_buffer_with_cursor(lines)
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(win, { 1, 0 })
    vim.api.nvim_buf_set_name(buf, '[Scratch]')
end

M.open_example = function()
    _open_scratch_buffer_with_cursor(M.example_string)
end

return M
