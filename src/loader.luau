-- Hermes MODULE LOADER (v3.0.0)

--[[
    LOADER EXECUTION MODEL

    loader:Add
        Add all the modules to the cache

    loader:Zap
        Loop through all the modules in the _modules cache
            Require it
            Add the .Server/.Client to it
            Add it to the _providers cache
            Call :Init on it

        Loop through all the providers in the _providers cache
            Call :Start on it
            Connect to lifecycle methods
]]--

local RunService = game:GetService("RunService")
local isClient = RunService:IsClient()

local loader = {
    _modules = {},
    _providers = {}
}

export type loader = typeof(loader)

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

-- Add a table of ModuleScripts to the Hermes module cache to be loaded when :Zap is called.
function loader.Add(self: loader, modules: {ModuleScript})
    for _, module in modules do
        if not table.find(self._modules, module) then
            table.insert(self._modules, module)
        else
            warn("Attempt to add module already in the cache.")
        end
    end
end

-- Starts Hermes and all the modules in its cache.
function loader.Zap(self: loader)
    --[[
        This is where we added all the modules in the cache to the providers cache
            and call the "Init" function on all of them.
    ]]
    for _, module in (self._modules :: {ModuleScript}) do
        local prov = require(module)

        if self._providers[prov.Name] then
            warn("There is already a provider with the same name! Provider names MUST be unique.")
            return
        end

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

-- Get a provider from Hermes's provider cache. Returns nil if it was not found.
function loader.GetProvider(self: loader, name: string): Provider?
    return self._providers[name]
end

return loader