-- Hermes COMPONENT (v0.1.0)

--[[ 
	Simple component library.

	Usage:
	```luau
		local Component = Hermes.Component

		local TestComponent = Component.new("TestTag")

		type TestComponent = typeof(TestComponent)

		function TestComponent.Construct(self: TestComponent)
			self.TestThing = "Hello!"
		end

		function TestComponent.Start(self: TestComponent)
			-- Output: Hello!
			print(self.TestThing)
		end

		function TestComponent.Destroy(self: TestComponent, instance: Instance)
			print(`Part was destroyed or "{self.Tag}" tag was removed from it.`)
		end

		function TestComponent.Heartbeat(self: TestComponent, deltaTime: number)
			print(dt)
		end

		return Component.Start(TestComponent)

	```
]]
--

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local modding = require("./modding")

local component = {}
component.__index = component

export type component = typeof(component)

export type Component = {
	__index: Component,
	__tostring: () -> string,

	Tag: string,

	Instance: Instance,

	Construct: (Component) -> ()?,
	Start: (Component) -> ()?,
	Destroy: (Component, Instance) -> ()?,

	Heartbeat: (Component, number) -> ()?,

	_construct: (Component, Instance) -> (),
}

function component.new(tag: string)
	local comp = {}
	comp.__index = comp
	comp.__tostring = function()
		return `Component_{tag}`
	end

	comp.Tag = tag

	setmetatable(comp, component)
	modding.ComponentRegistered:Fire(comp)

	return comp
end

-- Calls a component's "Construct" function, if it exists, also sets the "component.Instance" property.
function component._construct(self: component, instance: Instance)
	local comp = setmetatable({}, self)

	comp.Instance = instance
	if comp.Construct then
		comp.Construct(comp)
	end

	return comp
end

-- Calls a component's "Start" function, if it exists
local function startComponent(comp: Component)
	if comp.Start then
		comp.Start(comp)
	end
end

-- Calls a component's "Destroy" function, if it exist
local function destroyComponent(comp: Component, instance: Instance)
	if comp.Destroy then
		comp.Destroy(comp, instance)
	end
end

-- Calls a component's "Heartbeat" function every heartbeat, if it exist
local function heartbeatComponent(comp: Component)
	if comp.Heartbeat then
		RunService.Heartbeat:Connect(function(dt: number)
			comp.Heartbeat(comp, dt)
		end)
	end
end

function component.Fly(self: Component)
	local instanceComponents = {}

	local function createComponent(instance: Instance)
		local comp = self:_construct(instance)
		instanceComponents[instance] = comp

		startComponent(comp)

		heartbeatComponent(comp)

		modding.ComponentInstanceCreated:Fire(comp, instance)

		return comp
	end

	CollectionService:GetInstanceAddedSignal(self.Tag):Connect(function(instance)
		createComponent(instance)
	end)

	CollectionService:GetInstanceRemovedSignal(self.Tag):Connect(function(instance)
		if instanceComponents[instance] then
			destroyComponent(instanceComponents[instance], instance)
		end
	end)

	for _, instance in CollectionService:GetTagged(self.Tag) do
		createComponent(instance)
	end

	return self
end

return component :: component
