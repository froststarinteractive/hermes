-- Hermes NETWORKING (v0.1.2)

local RunService = game:GetService("RunService")
local isClient = RunService:IsClient()

local networking = {}

export type networking = typeof(networking)

type RemoteType = "RemoteEvent" | "RemoteFunction"

-- Client: Waits for remote with name to be added
-- Server: Creates the remote with specified name, or returns it if it exists
local function getRemote(name: string, type: RemoteType): RemoteEvent | RemoteFunction
	if script:FindFirstChild(name) then
		return script:FindFirstChild(name)
	end

	if isClient then
		task.spawn(function()
			local remote = script:WaitForChild(name)
			return remote
		end)
	end

	if type == "RemoteEvent" then
		local remote = Instance.new("RemoteEvent")
		remote.Name = name

		remote.Parent = script

		return remote
	else
		local remote = Instance.new("RemoteFunction")
		remote.Name = name

		remote.Parent = script

		return remote
	end
end

--[[ FIRING REMOTES ]]

--[[
    Asks the server/client a question, and returns and answer

    name -> name of the remote
    playerOrAny -> if on server, you have to specify the player you want to fire the remote to. if on client, pass in anything.
    ... -> anything except a function due to Roblox's restrictions.
]]
function networking.Ask(_self: networking, name: string, playerOrAny: Player | any, ...: any): any?
	local remote = getRemote(name, "RemoteFunction") :: RemoteFunction

	if isClient then
		return remote:InvokeServer(playerOrAny, ...)
	else
		if typeof(playerOrAny) == "Player" then
			return remote:InvokeClient(playerOrAny, ...)
		else
			warn(
				`[S] [Hermes] Wrong parameter "playerOrAny" on networking:Ask. Expected player, got {typeof(playerOrAny)}`
			)
		end
	end
	return
end

--[[
    Tells the server/client to do something

    name -> name of the remote
    playerOrAny -> if on server, you have to specify the player you want to fire the remote to, if not a player, fires all clients.
    ... -> anything except a function due to Roblox's restrictions.
]]
function networking.Tell(_self: networking, name: string, playerOrAny: Player | any, ...: any)
	local remote = getRemote(name, "RemoteEvent") :: RemoteEvent

	if isClient then
		remote:FireServer(playerOrAny, ...)
	else
		if typeof(playerOrAny) == "Player" then
			remote:FireClient(playerOrAny, ...)
		else
			remote:FireAllClients(playerOrAny, ...)
		end
	end
end

--[[ LISTENING TO REMOTES ]]

-- Listens to when the client/server tells the server/client to do something. Returns an RBXScriptConnection
function networking.ListenToTell(
	_self: networking,
	name: string,
	callback: (Player | any, any) -> ()
): RBXScriptConnection
	local remote = getRemote(name, "RemoteEvent") :: RemoteEvent

	if isClient then
		return remote.OnClientEvent:Connect(callback)
	else
		return remote.OnServerEvent:Connect(callback)
	end
end

--[[ WAITING FOR REMOTES ]]

function networking.Wait(_self: networking, name: string)
	local remote = getRemote(name, "RemoteEvent") :: RemoteEvent

	if isClient then
		remote.OnClientEvent:Wait()
	else
		remote.OnServerEvent:Wait()
	end
end

return networking
