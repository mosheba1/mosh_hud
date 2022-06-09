local maxPlayers = GetConvar("sv_maxclients", "128")
local player_fps = 0
local fps_calc = 0


local newping = 0

RegisterNetEvent("HandlePing")
AddEventHandler("HandlePing", function(ping)
    -- TriggerServerEvent("GetPlayerPing")
    newping = ping
end)

Citizen.CreateThread(function()
    Citizen.Wait(8000)
    TriggerServerEvent("GetPlayerPing")
end)



RegisterNUICallback('mosh_hud:HandInfo', function(data, cb)
    cb({
        player = GetPlayerName(PlayerId()),
        player_fps = player_fps,
        playerpingofc = newping,
        ID = GetPlayerServerId(PlayerId()),
        discord = Config.discord_inv,
        website_link = Config.website_link,
        active_players = #GetActivePlayers().."/"..maxPlayers,

        -- ICONS --
        ID_ICON = Config.Icons.ID_ICON,
        PLAYERS_ICON = Config.Icons.PLAYERS_ICON,
        LOBBY_ICON = Config.Icons.LOBBY_ICON,
        FPS_ICON = Config.Icons.FPS_ICON,
        DISCORD_ICON = Config.Icons.DISCORD_ICON,
        WEBSITE_ICON = Config.Icons.WEBSITE_ICON

    })
end)

CreateThread(function()
    while true do
        fps_calc = fps_calc + 1
        Wait(0)
    end
end)

CreateThread(function() -- calc
    while true do
        player_fps = fps_calc
        fps_calc = 0

        Wait(1000)
    end
end)

RegisterNUICallback('ready', function(data, cb)
    cb("ok")
end)



RegisterCommand("testp", function(source)
    TriggerServerEvent("GetPlayerPing")
    return newping
end)

TriggerEvent('chat:addSuggestion', '/moshhud', 'hide or show', {
    { name="hide or show", help="hides / shows the top hud" },
})


RegisterCommand("moshhud", function(source, args)
    if args[1] == "hide" then
        TriggerEvent("hidevehhud", source)
    SendNUIMessage({
        action = "hide_hud"
    })
    elseif  args[1] == "show" then
        TriggerEvent("showevehhud", source)
        SendNUIMessage({
            action = "show_hud"
        })
    end
end)


RegisterCommand("test", function(source)
    TriggerServerEvent("GetPlayerPing", source)
    print(newping)
end)