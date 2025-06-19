-- Hermes MODULE LOADER (v0.1.0)

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
]]
--

local RunService = game:GetService("RunService")
local isClient = RunService:IsClient()

local modding = require("./modding")

local loader = {
	_modules = {},
	_providers = {},

	Component = require("./component"),
	Modding = modding,
}

export type loader = typeof(loader)

export type Provider = {
	Name: string,

	Hermes: loader,

	Init: (Provider) -> ()?,
	Start: (Provider) -> ()?,

	Heartbeat: (Provider) -> ()?,

	[any]: any,
}

export type ProviderServer = Provider & {}

export type ProviderClient = Provider & {
	PreRender: (ProviderClient) -> ()?,
	PreSimulation: (ProviderClient) -> ()?,
}

-- Register a table of ModuleScripts to the Hermes module cache to be loaded when :Zap is called.
function loader.Register(self: loader, modules: { ModuleScript })
	for _, module in modules do
		if not table.find(self._modules, module) then
			modding.ProviderRegistered:Fire()
			table.insert(self._modules, module)
		else
			warn("Attempt to add module already in the cache.")
		end
	end
end

-- Requires a table of ModuleScripts
function loader.RequireModules(self: loader, modules: { ModuleScript })
	for _, module in modules do
		require(module)
	end
end

-- Starts Hermes and all the modules in its cache.
function loader.Fly(self: loader)
	--[[
        This is where we added all the modules in the cache to the providers cache
            and call the "Init" function on all of them.
    ]]
	for _, module in self._modules :: { ModuleScript } do
		local prov = require(module)

		if self._providers[prov.Name] then
			warn("There is already a provider with the same name! Provider names MUST be unique.")
			return
		end

		prov.Hermes = self

		self._providers[prov.Name] = prov

		if prov.Init then
			prov:Init()
		end
	end

	--[[
        This is where we call all the provider's "Start" function,
            and connect the lifecycle methods as well.
    ]]
	for _, prov in self._providers :: { [string]: Provider } do
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

	modding.StartedFlying:Fire()
	modding.Flying = true
end

-- Get a provider from Hermes's provider cache. Returns nil if it was not found.
function loader.Use(self: loader, name: string): Provider?
	return self._providers[name]
end

-- Alias for loader:Use
function loader.UseProvider(self: loader, name: string): Provider?
	return self:Use(name)
end

return loader
