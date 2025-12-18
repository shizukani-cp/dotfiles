local M = {}

function M.yank_uuid()
    local function hex(n)
        return string.format("%02x", math.random(0, 255))
    end

    local uuid = table.concat({
        hex() .. hex() .. hex() .. hex(),                                      -- 8桁
        hex() .. hex(),                                                        -- 4桁
        string.format("%02x%02x", math.random(64, 79), math.random(0, 255)),   -- 4桁（v4固定）
        string.format("%02x%02x", math.random(128, 191), math.random(0, 255)), -- 4桁（variant）
        hex() .. hex() .. hex() .. hex() .. hex() .. hex(),                    -- 12桁
    }, "-")

    vim.fn.setreg('"', uuid)
end

return M
