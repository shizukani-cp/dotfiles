---@alias Vist.Adapters.File.Action.Kind "create" | "delete" | "rename"

local M = { protocol = "vist-file://", cache = {}, current_path = vim.fn.getcwd() }

local function get_cwd(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local path = bufname:match("^" .. M.protocol .. "(.*)")

    return (path and path ~= "") and path or vim.fn.getcwd()
end

function M.bufname()
    return M.protocol .. M.current_path
end

function M.list()
    local cwd = M.current_path
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
    local cwd = get_cwd(0)
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
    local new_path = vim.fs.joinpath(M.current_path, clean_name)

    if vim.fn.isdirectory(new_path) == 1 then
        M.current_path = new_path
        require("vist.core").open(M)
    else
        vim.cmd("edit " .. vim.fn.fnameescape(new_path))
    end
end

return M --[[@as Vist.Adapter]]
