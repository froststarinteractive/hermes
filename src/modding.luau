-- Hermes MODDING (v0.1.0)

--[[
    Modding is still a work-in-progress.
    After registering mods, you'll have to join hermes with the mods.

    ```luau
        local Hermes = require("./Hermes")

        Hermes.RegisterMod({
            Hi = "Hello!"
        })
        
        -- Register in the mods
        Hermes = Hermes:JoinWithMods()

        -- Output: Hello!
        print(Hermes.Hi)
    ```
]]

local utils = require("./utils")
local signal = utils.Signal

local modding = {
	_mods = {},
	Flying = false,
	StartedFlying = signal.new(),
	ProviderRegistered = signal.new(),
	ModRegistered = signal.new(),
	ComponentRegistered = signal.new(),
	ComponentInstanceCreated = signal.new(),
}

export type modding = typeof(modding)

export type Mod = {
	[string]: any,
}

-- Registering a mod (basically a table) joins it with the main Hermes table, allowing you to do basically anything you want with it.
function modding.RegisterMod(self: modding, mod: Mod)
	table.insert(self._mods, mod)
	modding.ModRegistered:Fire()
end

-- Internal use
function modding._getMods(self: modding): { Mod }
	return self._mods
end

-- Joins the Hermes table with the mods in the _mods cache. You should do this as: Hermes = Hermes:Join()
function modding.JoinWithMods(self: modding)
	local function joinMods()
		local mods = {}

		for _, mod in modding:_getMods() do
			for key, modParam in mod do
				mods[key] = modParam
				print(mods)
			end
		end

		return mods
	end

	return utils.joinTables(self, joinMods())
end

return modding
