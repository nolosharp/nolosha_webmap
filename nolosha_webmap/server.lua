local players = {}
local playersNeighbor = {}

RegisterNetEvent("vorp-webmap:updateInfo")

local VorpCore  = nil

local globalResponse = {}
globalResponse.interval = Config.updateInterval

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local function prunePlayers()
	for player, info in pairs(players) do
		if not GetPlayerEndpoint(player) then
			players[player] = nil
		end
	end
end

AddEventHandler("playerDropped", function(reason)
	players[source] = nil
end)

AddEventHandler("vorp-webmap:updateInfo", function(playerInfo)
	players[source] = playerInfo
    local user = nil
    if VorpCore ~= nil then
        user = VorpCore.getUser(source)
        if user ~= nil then
    		local Character = user.getUsedCharacter
			players[source]["firstname"] = Character.firstname
			players[source]["lastname"] = Character.lastname
			players[source]["job"] = Character.job
			players[source]["money"] = Character.money
			players[source]["gold"] = Character.gold
			players[source]["source"] = source
			if Character.firstname ~= nil then
				players[source]["logged"] = true
			end
        end
    end
    local discordIdentity = GetPlayerIdentifierByType(source, 'discord')
    local discordId = discordIdentity and discordIdentity:sub(9) or ""

	players[source]["discord"] = discordId
end)

Citizen.CreateThread(function()
	print('Vorp-webmap Started')
	while true do
		prunePlayers()
		TriggerClientEvent("vorp-webmap:updateInfo", -1)
		Citizen.Wait(Config.updateInterval)
	end
end)

SetHttpHandler(function (req, res)
    if req.path == '/list.json' then
	    local headers = {}
	    headers["Content-Type"] = "application/json"
	    headers["Access-Control-Allow-Origin"] = Config.AccessControlAllowOrigin
		res.writeHead(200, headers)
		globalResponse.players = players
		res.send(json.encode(globalResponse))
    end
end)
