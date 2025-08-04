local fn = vim.fn
local cmd = vim.cmd
local notify = vim.notify

local M = {}

local install_base_path = fn.stdpath('data') .. '/site/pack/manager/opt'

M.plugins = {}
local loaded_plugins = {}
local is_locked = false
local load_queue = {}

local function do_load(id)
    if loaded_plugins[id] then return end
    local plugin = M.plugins[id]
    cmd('packadd ' .. plugin.spec.id)
    if type(plugin.spec.config) == 'function' then
        plugin.spec.config()
    end
    loaded_plugins[id] = true
end

function M.add(spec)
    if not spec.id or not spec.url then
        error("Plugin must have 'id' and 'url'. spec: " .. vim.inspect(spec))
    end
    if M.plugins[spec.id] then return end
    local install_path = fn.stdpath('data') .. '/site/pack/manager/opt/' .. spec.id
    local is_installed = fn.isdirectory(install_path) == 1
    M.plugins[spec.id] = {
        spec = spec,
        status = is_installed and 'installed' or 'new',
        on_installed_callbacks = {},
    }
    if not is_installed then
        local plugin = M.plugins[spec.id]
        plugin.status = 'installing'
        fn.jobstart('git clone --depth 1 ' .. spec.url .. ' ' .. install_path, {
            on_exit = function(_, code)
                vim.schedule(function()
                    if code == 0 then
                        plugin.status = 'installed'
                        cmd('packloadall!')
                        for _, callback in ipairs(plugin.on_installed_callbacks) do
                            callback()
                        end
                        plugin.on_installed_callbacks = {}
                    else
                        plugin.status = 'failed'
                        notify("'" .. spec.id .. "' installation failed.", vim.log.levels.ERROR)
                    end
                end)
            end,
        })
    end
end

function M.load(id)
    if loaded_plugins[id] then return end
    local plugin = M.plugins[id]
    if not plugin then
        error("plugin '" .. id .. "' not found, please make sure you did add().")
    end

    if is_locked then
        table.insert(load_queue, id)
        return
    end

    if plugin.spec.dependencies then
        for _, dep_id in ipairs(plugin.spec.dependencies) do
            M.load(dep_id)
        end
    end
    if plugin.status == 'installed' then
        do_load(id)
    elseif plugin.status == 'installing' then
        table.insert(plugin.on_installed_callbacks, function() do_load(id) end)
    else
        notify("Could not load '"..id.."' The status is not correct: " .. plugin.status, vim.log.levels.ERROR)
    end
end

function M.lock()
    is_locked = true
end

function M.unlock()
    is_locked = false
    local queue = load_queue
    load_queue = {}
    for _, id in ipairs(queue) do
        M.load(id)
    end
end

local function process_update_queue(queue)
    if #queue == 0 then
        return
    end
    local id = table.remove(queue, 1)
    local plugin = M.plugins[id]
    local install_path = install_base_path .. '/' .. id
    if plugin.status ~= 'installed' then
        process_update_queue(queue)
        return
    end
    fn.jobstart({ 'git', '-C', install_path, 'pull' }, {
        on_exit = function(_, code)
            vim.schedule(function()
                if code ~= 0 then
                    notify("'" .. id .. "' update failed.", vim.log.levels.ERROR)
                end
                process_update_queue(queue)
            end)
        end,
    })
end

-- @param target_id (string | nil) ID of the plugin you want to update, or all of them if nil.
function M.update(target_id)
    local queue = {}

    if target_id then
        if M.plugins[target_id] then
            table.insert(queue, target_id)
        else
            return
        end
    else
        for id, _ in pairs(M.plugins) do
            table.insert(queue, id)
        end

        if #queue == 0 then
            return
        end
    end

    process_update_queue(queue)
end

function M.list()
    local ids = {}
    for id, _ in pairs(M.plugins) do
        table.insert(ids, id)
    end

    table.sort(ids)

    return ids
end

function M.clean()
    local installed_dirs = fn.globpath(install_base_path, '*', true, true)
    local removed_plugins = {}

    if #installed_dirs == 0 then
        return
    end

    for _, path in ipairs(installed_dirs) do
        if fn.isdirectory(path) == 1 then
            local id = fn.fnamemodify(path, ':t')

            if not M.plugins[id] then
                local ok, err = pcall(fn.delete, path, 'rf')
                if ok then
                    table.insert(removed_plugins, id)
                else
                    notify("Failed to remove '" .. id .. "': " .. err, vim.log.levels.ERROR)
                end
            end
        end
    end
end
return M
