local M = {}

local function _open_scratch_buffer_with_cursor(lines)
    local sc_buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, sc_buf)
    local ex_buf = vim.api.nvim_create_buf(false, true)
    vim.cmd([[vsplit]])
    local win2 = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win2, ex_buf)
    vim.api.nvim_buf_set_lines(ex_buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_name(ex_buf, "[Scratch]")
    vim.api.nvim_win_set_cursor(win, { 1, 0 })
end

M.open_example = function()
    _open_scratch_buffer_with_cursor(require("data.example_file"))
end

return M
