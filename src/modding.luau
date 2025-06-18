-- Hermes MODDING (added in v3.0.0)

--[[
    Modding is still a work-in-progress and I'll be
    adding more utility functions to make your life easier
    later on.

    Modding allows you to modify Hermes however you'd like.

    After registering mods, you'll have to re-require Hermes.

    ```luau
        local Hermes = require("./Hermes")

        Hermes.RegisterMod({
            Hi = "Hello!"
        })
        
        -- Require it again to register in the mods
        Hermes = require("./Hermes")

        -- Output: Hello!
        print(Hermes.Hi)
    ```
]]

local utils = require("./utils")

local modding = {
    _mods = {}
}

export type modding = typeof(modding)

export type Mod = {
    [string]: any
}

-- Registering a mod (basically a table) joins it with the main Hermes table, allowing you to do basically anything you want with it.
function modding.RegisterMod(self: modding, mod: Mod)
    table.insert(self._mods, mod)
end

-- Internal use
function modding._getMods(self: modding): {Mod}
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