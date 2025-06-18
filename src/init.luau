--[[
                                                                                                
                                                                                                
██╗  ██╗███████╗██████╗ ███╗   ███╗███████╗███████╗ v0.1.0
██║  ██║██╔════╝██╔══██╗████╗ ████║██╔════╝██╔════╝
███████║█████╗  ██████╔╝██╔████╔██║█████╗  ███████╗
██╔══██║██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══╝  ╚════██║
██║  ██║███████╗██║  ██║██║ ╚═╝ ██║███████╗███████║
╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝
                                                   
                                                                                                

    Hermes is a lightweight module loader for Roblox making game development actually fun.

    This is Hermes's CORE library. Currently, it features a simple module loader.

    This is what we will have in the future:

    - Networking
    - Components
    - Wally release (probably AFTER networking. I just really like pesde right now lol)
    

    Libraries for Hermes that will exist, but will not be included in its core:

    - Easy data handling
    - Animations

]]

local loader = require("@self/loader")
local modding = require("@self/modding")
local networking = require("@self/networking")
local utils = require("@self/utils")

export type Hermes = loader.loader & modding.modding & networking.networking

return utils.joinTables(loader, modding, networking) :: Hermes