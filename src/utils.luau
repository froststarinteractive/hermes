-- Hermes UTILS (added in v3.0.0)

--[[
    Mostly internal utilities for Hermes.
]]

local utils = {}

export type utils = typeof(utils)

function utils.joinTables(...)
	local result = {}
    for i = 1, select("#", ...) do
        local source = select(i, ...)
		for key, value in source do
			result[key] = value
		end
	end
	return result
end

return utils