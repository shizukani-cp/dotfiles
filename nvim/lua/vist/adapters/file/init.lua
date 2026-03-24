---@alias Vist.Adapters.File.Action.Kind "create" | "delete" | "rename"

local M = { protocol = "vist-file://", cache = {}, pending_path = nil }

local function dirname_from_bufname(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:find(M.protocol, 1, true) == 1 then
        return bufname:sub(#M.protocol + 1)
    end
    return nil
end

local function get_cwd()
    if M.pending_path then
        return M.pending_path
    end
    local from_bufname = dirname_from_bufname(0)
    if from_bufname then
        return from_bufname
    end
    local bufname = vim.api.nvim_buf_get_name(0)
    local buftype = vim.bo.buftype
    if buftype == "" and bufname ~= "" then
        return vim.fn.fnamemodify(bufname, ":p:h")
    end
    return vim.fn.getcwd()
end

function M.bufname()
    return M.protocol .. get_cwd()
end

function M.list()
    local cwd = get_cwd()
    if not cwd then
        return
    end
    local files = vim.fn.readdir(cwd)
    local items = {}
    M.cache = {}

    for i, name in ipairs(files) do
        local full_path = vim.fs.joinpath(cwd, name)
        local display_name = name
        if vim.fn.isdirectory(full_path) == 1 then
            display_name = name .. "/"
        end
        local item = { id = i, display = display_name }
        table.insert(items, item)
        M.cache[i] = name
    end
    return items
end

function M.parse(state)
    ---@type Vist.Action<Vist.Adapters.File.Action.Kind>
    local actions = {}
    local current_ids = {}

    for _, item in ipairs(state) do
        if item.id then
            current_ids[item.id] = true
            local old_name = M.cache[item.id]
            if old_name and old_name ~= item.text then
                table.insert(actions, {
                    kind = "rename",
                    data = { old = old_name, new = item.text },
                })
            end
        else
            if item.text ~= "" then
                table.insert(actions, { kind = "create", data = { name = item.text } })
            end
        end
    end

    for id, name in pairs(M.cache) do
        if not current_ids[id] then
            table.insert(actions, { kind = "delete", data = { name = name } })
        end
    end

    return actions
end

function M.do_action(action)
    local cwd = get_cwd()
    if action.kind == "rename" then
        local old_path = vim.fs.joinpath(cwd, action.data.old)
        local new_path = vim.fs.joinpath(cwd, action.data.new)
        os.rename(old_path, new_path)
    elseif action.kind == "delete" then
        local path = vim.fs.joinpath(cwd, action.data.name)
        os.remove(path)
    elseif action.kind == "create" then
        local path = vim.fs.joinpath(cwd, action.data.name)
        if action.data.name:sub(-1) == "/" then
            vim.fn.mkdir(path, "p")
        else
            local f = io.open(path, "w")
            if f then
                f:close()
            end
        end
    end
end

function M.open_item(_, text)
    local clean_name = text:gsub("/$", "")
    local new_path = vim.fs.joinpath(dirname_from_bufname(0), clean_name)

    if vim.fn.isdirectory(new_path) == 1 then
        M.pending_path = new_path
        require("vist.core").open(M)
        M.pending_path = nil
    else
        vim.cmd("edit " .. vim.fn.fnameescape(new_path))
    end
end

function M.on_open(bufnr)
    vim.keymap.set("n", "-", function()
        local current = dirname_from_bufname(bufnr):gsub("/$", "")
        local parent = vim.fn.fnamemodify(current, ":p:h:h")

        if current == parent or current == "/" then
            return
        end

        M.pending_path = parent
        require("vist.core").open(M)
        M.pending_path = nil
    end, { buffer = bufnr, silent = true, noremap = true })
end

return M --[[@as Vist.Adapter]]
