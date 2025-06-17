--[[
                                                                                                
                                                                                                
ZZZZZZZZZZZZZZZZZZZ                                    hhhhhhh                                  
Z:::::::::::::::::Z                                    h:::::h                                  
Z:::::::::::::::::Z                                    h:::::h                                  
Z:::ZZZZZZZZ:::::Z                                     h:::::h                                  
ZZZZZ     Z:::::Z    aaaaaaaaaaaaa  ppppp   ppppppppp   h::::h hhhhh   yyyyyyy           yyyyyyy v3.0.0
        Z:::::Z      a::::::::::::a p::::ppp:::::::::p  h::::hh:::::hhh y:::::y         y:::::y 
       Z:::::Z       aaaaaaaaa:::::ap:::::::::::::::::p h::::::::::::::hhy:::::y       y:::::y  
      Z:::::Z                 a::::app::::::ppppp::::::ph:::::::hhh::::::hy:::::y     y:::::y   
     Z:::::Z           aaaaaaa:::::a p:::::p     p:::::ph::::::h   h::::::hy:::::y   y:::::y    
    Z:::::Z          aa::::::::::::a p:::::p     p:::::ph:::::h     h:::::h y:::::y y:::::y     
   Z:::::Z          a::::aaaa::::::a p:::::p     p:::::ph:::::h     h:::::h  y:::::y:::::y      
ZZZ:::::Z     ZZZZZa::::a    a:::::a p:::::p    p::::::ph:::::h     h:::::h   y:::::::::y       
Z::::::ZZZZZZZZ:::Za::::a    a:::::a p:::::ppppp:::::::ph:::::h     h:::::h    y:::::::y        
Z:::::::::::::::::Za:::::aaaa::::::a p::::::::::::::::p h:::::h     h:::::h     y:::::y         
Z:::::::::::::::::Z a::::::::::aa:::ap::::::::::::::pp  h:::::h     h:::::h    y:::::y          
ZZZZZZZZZZZZZZZZZZZ  aaaaaaaaaa  aaaap::::::pppppppp    hhhhhhh     hhhhhhh   y:::::y           
                                     p:::::p                                 y:::::y            
                                     p:::::p                                y:::::y             
                                    p:::::::p                              y:::::y              
                                    p:::::::p                             y:::::y               
                                    p:::::::p                            yyyyyyy                
                                    ppppppppp                                                   
                                                                                                

    Zaphy is a lightweight module loader for Roblox making game development actually fun.

    v3.0.0 Is a complete rework of Zaphy.

    This is Zaphy's CORE library. Currently, it features a simple module loader.

    This is what we will have in the future:

    - Networking
    - Components
    - Wally release (probably AFTER networking. I just really like pesde right now lol)
    

    Libraries for Zaphy that will exist, but will not be included in its core:

    - Easy data handling
    - Animations

]]

local RunService = game:GetService("RunService")
local isClient = RunService:IsClient()

local loader = {
    _modules = {},
    _providers = {}
}

type loader = {
    _modules: {ModuleScript},
    _providers: {[string]: Provider},

    Add: (loader) -> (),
    Zap: (loader) -> (),
    GetProvider: (loader) -> ()
}

export type Provider = {
    Name: string,

    Init: (Provider) -> ()?,
    Start: (Provider) -> ()?,

    Heartbeat: (Provider) -> ()?,

    [any]: any
}

export type ProviderServer = Provider & {
    Server: loader
}

export type ProviderClient = Provider & {
    Client: loader,

    PreRender: (ProviderClient) -> ()?,
    PreSimulation: (ProviderClient) -> ()?
}

-- Add a table of ModuleScripts to the Zaphy module cache to be loaded when :Zap is called.
function loader.Add(self: loader, modules: {ModuleScript})
    for _, module in modules do
        table.insert(self._modules, module)
    end
end

-- Starts Zaphy and all the modules in its cache.
function loader.Zap(self: loader)
    --[[
        This is where we added all the modules in the cache to the providers cache
            and call the "Init" function on all of them.
    ]]
    for _, module in (self._modules :: {ModuleScript}) do
        local prov = require(module)

        if isClient then
            prov.Client = self
        else
            prov.Server = self
        end

        self._providers[prov.Name] = prov

        if prov.Init then
            prov:Init()
        end
    end

    --[[
        This is where we call all the provider's "Start" function,
            and connect the lifecycle methods as well.
    ]]
    for _, prov in (self._providers :: {[string]: Provider}) do
        if prov.Start then
            prov:Start()
        end

        if prov.Heartbeat then
            RunService.Heartbeat:Connect(function()
                prov:Heartbeat()
            end)
        end

        if isClient then
            if prov.PreRender then
                RunService.PreRender:Connect(function()
                    prov:PreRender()
                end)
            end

            if prov.PreSimulation then
                RunService.PreSimulation:Connect(function()
                    prov:PreSimulation()
                end)
            end
        end
    end
end

-- Get a provider from Zaphy's provider cache. Returns nil if it was not found.
function loader.GetProvider(self: loader, name: string): Provider?
    return self._providers[name]
end

return loader