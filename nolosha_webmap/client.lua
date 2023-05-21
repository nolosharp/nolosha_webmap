RegisterNetEvent("vorp-webmap:updateInfo")

AddEventHandler("vorp-webmap:updateInfo", function()
	local playerPed = PlayerPedId()
    local _, weaponHash = GetCurrentPedWeapon(playerPed, true, 0, true)

	TriggerServerEvent("vorp-webmap:updateInfo", {
		name = GetPlayerName(PlayerId()),
		coords = GetEntityCoords(playerPed),
		heading = GetEntityHeading(playerPed),
		health = GetEntityHealth(playerPed),
		mount = IsPedOnMount(playerPed),
		unarmed = weaponHash == -1569615261,
	})
end)