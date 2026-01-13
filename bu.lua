-- DUPER FINAL (CORRIGÉ)
print("Chargement du script...")

local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local net = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")

local placeRemote = net:WaitForChild("fce51e06-a587-4ff0-9e19-869eb1859a01")
local pingRemote = net:WaitForChild("eb9dee81-7718-4020-b6b2-219888488d13")

local capID = ""
local capSess = ""
local isSpamming = false

local function notify(t, m)
    game.StarterGui:SetCore("SendNotification", {
        Title = t,
        Text = m,
        Duration = 3
    })
end

-- Initialisation
notify("⭐ SYSTEM READY", "Pose ton Brainrot !")

-- Hook de Capture
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if self == placeRemote and not isSpamming then
        capSess = args[2]
        capID = args[3]
        notify("🎯 ID CAPTURÉ", "Objet prêt pour le swap.")
    end
    return old(self, ...)
end) -- La parenthèse manquante était ici
setreadonly(mt, true)

-- Fonction de Dupe
uis.InputBegan:Connect(function(i, p)
    if not p and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) then
        if capID ~= "" then
            isSpamming = true
            notify("🚀 SWAP...", "Envoi forcé sur dalle")
            for _ = 1, 15 do
                local t = tick()
                pingRemote:FireServer(t, "9aba28d9-6365-4f5b-843c-f4830e87c058")
                placeRemote:FireServer(t, capSess, capID, 3)
                task.wait(0.01)
            end
            isSpamming = false
            notify("✅ FINI", "Vérifie l'inventaire !")
        else
            notify("⚠️ ERREUR", "Pose l'objet cher d'abord.")
        end
    end
end)
