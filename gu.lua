-- [[ DUPER UNIVERSAL ROBUSTE V6 ]]
repeat task.wait() until game:IsLoaded()

local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local sgui = game:GetService("StarterGui")

-- Variables de stockage
local capID, capSess = nil, nil
local isSpamming = false

-- Fonction de notification fiable
local function notify(title, msg, color)
    sgui:SetCore("SendNotification", {
        Title = title,
        Text = msg,
        Duration = 4
    })
end

-- Recherche automatique des Remotes (pour éviter les erreurs d'ID)
local netPath = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")
local placeRemote = netPath:WaitForChild("fce51e06-a587-4ff0-9e19-869eb1859a01")
local pingRemote = netPath:WaitForChild("eb9dee81-7718-4020-b6b2-219888488d13")

notify("✅ SYSTÈME PRÊT", "Pose ton objet cher sur une dalle.")

-- [[ SYSTÈME DE CAPTURE AUTOMATIQUE ]]
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    
    -- Si on détecte une pose d'objet et qu'on n'est pas déjà en train de duper
    if self == placeRemote and not isSpamming then
        capSess = args[2]
        capID = args[3]
        notify("🎯 ID CAPTURÉ", "Objet enregistré. Reprends-le !")
    end
    
    return old(self, ...)
end)
setreadonly(mt, true)

-- [[ SYSTÈME DE DUPLICATION (ACTION) ]]
uis.InputBegan:Connect(function(input, processed)
    -- Se déclenche sur un clic ou une touche écran (non bloqué par l'UI)
    if not processed and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        
        if capID and capSess then
            isSpamming = true
            notify("⚡ DUPLICATION...", "Bombardement de la dalle en cours")
            
            -- Cycle de duplication ultra-rapide
            for i = 1, 18 do
                local t = tick()
                pingRemote:FireServer(t, "9aba28d9-6365-4f5b-843c-f4830e87c058")
                placeRemote:FireServer(t, capSess, capID, 3) -- Le 3 cible la dalle
                
                -- Pause micro pour éviter le Kick de Roblox
                if i % 6 == 0 then task.wait(0.01) end
            end
            
            isSpamming = false
            notify("⭐ TERMINÉ", "Vérifie si l'objet est doublé.")
        else
            -- Si l'utilisateur clique sans avoir capturé d'objet
            print("En attente de capture d'objet...")
        end
    end
end)
