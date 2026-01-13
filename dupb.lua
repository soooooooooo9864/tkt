-- DUPER FINAL - DALLES & NOTIFS
print("Lancement du script...")

local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local net = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")

-- Les Remotes exactes de tes logs
local placeRemote = net:WaitForChild("fce51e06-a587-4ff0-9e19-869eb1859a01")
local pingRemote = net:WaitForChild("eb9dee81-7718-4020-b6b2-219888488d13")

local capID = ""
local capSess = ""
local isSpamming = false

-- Fonction Notification Debug
local function notify(title, msg)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = msg,
        Duration = 3
    })
end

notify("✅ SCRIPT ACTIF", "Pose un Brainrot pour capturer l'ID")

-- Système de Capture (HOOK)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if self == placeRemote and not isSpamming then
        capSess = args[2]
        capID = args[3]
        notify("🎯 ID CAPTURÉ", "ID: " .. tostring(capID):sub(1,8))
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- Système de Dupe (Swap)
uis.InputBegan:Connect(function(input, processed)
    if not processed and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        if capID ~= "" then
            isSpamming = true
            notify("🚀 SWAP...", "Envoi des paquets à la dalle")
            
            for i = 1, 15 do
                local t = tick()
                pingRemote:FireServer(t, "9aba28d9-6365-4f5b-843c-f4830e87c058")
                placeRemote:FireServer(t, capSess, capID, 3) -- Le "3" cible la dalle
                task.wait(0.01)
            end
            isSpamming = false
        else
            notify("⚠️ ERREUR", "Pose l'objet d'abord !")
        end
    end
end)
