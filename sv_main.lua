RegisterNetEvent("GetPlayerPing")
AddEventHandler("GetPlayerPing", function()
    local player = source
    local ping = GetPlayerPing(player)
    TriggerClientEvent("HandlePing", player, ping)
end)