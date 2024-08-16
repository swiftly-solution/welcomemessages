local messages = {}

AddEventHandler("OnPluginStart", function(event)
    for i=1,config:FetchArraySize("welcomemessages.messages") do
        local message = config:Fetch("welcomemessages.messages["..(i-1).."]")
        table.insert(messages, message)
    end
	return EventResult.Continue
end)

AddEventHandler("OnPlayerTeam", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then return end

    local oldteam = event:GetInt("oldteam")
    if oldteam == Team.None then 
        for i=1,#messages do
            local msg = messages[i]
            if not player:CBasePlayerController():IsValid() then return end
            msg = msg:gsub("{PLAYERNAME}", player:CBasePlayerController().PlayerName):gsub("{PLAYERS}", tostring(playermanager:GetPlayerCount())):gsub("{MAXPLAYERS}", tostring(server:GetMaxPlayers())):gsub("{MAP}", server:GetMap())

            player:SendMsg(MessageType.Chat, string.format("%s %s", config:Fetch("welcomemessages.prefix"), msg))
        end
    end
   	return EventResult.Continue
end)

function GetPluginAuthor()
    return "Swiftly Solutins"
end

function GetPluginVersion()
    return "1.0.0"
end

function GetPluginName()
    return "Welcome Messages"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/welcomemessages"
end