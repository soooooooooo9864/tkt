-- SPY TO WEBHOOK (BRAINROT EDITION) - OPTIMISÉ DELTA MOBILE
local WEBHOOK_URL = "https://discordapp.com/api/webhooks/1460716186915574016/vsdlstv5UkKltEBPNyFB9aXG8rzRlVMLh-RMbx-1QqYUJ7tUfBYJRkePopAAZUFZ7Mkd"
local HttpService = game:GetService("HttpService")

-- Fonction d'envoi vers Discord (compatible Delta)
local function sendToDiscord(title, data)
    local payload = HttpService:JSONEncode({
        embeds = {{
            title = title,
            description = "```lua\n" .. data .. "\n```",
            color = 3066993, -- Vert émeraude
            footer = {text = "Delta Mobile Spy - Brainrot Dupe"}
        }}
    })
    
    local requestFunc = syn and syn.request or http_request or request or (http and http.request)
    if requestFunc then
        requestFunc({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = payload
        })
    else
        warn("Delta ne semble pas supporter les requêtes HTTP.")
    end
end

-- Notification de démarrage en jeu
game.StarterGui:SetCore("SendNotification", {
    Title = "🕵️ Spy Activé",
    Text = "Pose ou vole un objet, les infos arrivent sur Discord !",
    Duration = 5
})

-- Interception des événements réseau (Remotes)
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    -- On intercepte les messages envoyés au serveur
    if method == "FireServer" or method == "InvokeServer" then
        -- On ignore les événements trop fréquents pour ne pas spammer Discord
        local ignored = {"CharacterChatted", "UpdatePlayer", "Ping"}
        local isIgnored = false
        for _, name in pairs(ignored) do
            if self.Name == name then isIgnored = true break end
        end

        if not isIgnored then
            local argData = ""
            for i, v in pairs(args) do
                argData = argData .. "Arg " .. i .. " : " .. tostring(v) .. " (" .. type(v) .. ")\n"
            end
            
            sendToDiscord("Remote détecté : " .. self.Name, 
                "Nom complet : " .. self:GetFullName() .. "\n\nArguments :\n" .. argData)
        end
    end
    
    return oldNamecall(self, ...)
end)

setreadonly(mt, true)
print("Spy Webhook opérationnel !")
