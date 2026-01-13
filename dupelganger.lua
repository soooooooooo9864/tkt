-- BRAINROT DUPER V3 (AVEC NOTIFS DEBUG)
local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")

-- Chemins
local net = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")
local placeRemote = net:WaitForChild("fce51e06-a587-4ff0-9e19-869eb1859a01")
local pingRemote = net:WaitForChild("eb9dee81-7718-4020-b6b2-219888488d13")

local capID = ""
local sess = "70646659-e472-4788-a9d8-cfa70e3d378c"
local isSpamming = false

-- Fonction pour envoyer les notifications de debug
local function notify(title, text)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

notify("🔥 STATUS", "Script chargé ! Pose ton objet CHER.")

-- Système de Capture (HOOK)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if self == placeRemote and not isSpamming then
        capID = args[3]
        sess = args[2]
        notify("🎯 ID CAPTURÉ", "Objet prêt pour le swap ! Reprends-le.")
        print("DEBUG: ID = " .. tostring(capID))
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- Système de Dupe (SWAP)
uis.InputBegan:Connect(function(i, p)
    if not p and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) then
        if capID == "" then
            notify("⚠️ ERREUR", "Pose ton objet cher d'abord !")
        else
            isSpamming = true
            notify("🚀 SWAP EN COURS", "Bombardement de la dalle...")
            
            for count = 1, 15 do
                local t = tick()
                pingRemote:FireServer(t, "9aba28d9-6365-4f5b-843c-f4830e87c058")
                placeRemote:FireServer(t, sess, capID, 3)
                task.wait(0.01)
            end
            
            isSpamming = false
            notify("✅ FINI", "Swap terminé. Vérifie l'inventaire !")
        end
    end
end)
