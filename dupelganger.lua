-- VERSION FINALE CORRIGÉE : BRAINROT DUPER
local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")

-- Dossier des Remotes détectés
local netFolder = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")
local placeRemote = netFolder:WaitForChild("fce51e06-a587-4ff0-9e19-869eb1859a01")
local pingRemote = netFolder:WaitForChild("eb9dee81-7718-4020-b6b2-219888488d13")

-- Variables de capture
local lastArg2 = "70646659-e472-4788-a9d8-cfa70e3d378c" 
local capturedID = "" 
local isSpamming = false

-- 1. Notification de démarrage
game.StarterGui:SetCore("SendNotification", {
    Title = "🔥 SWAPPER PRÊT",
    Text = "Pose ton objet CHER une fois !",
    Duration = 8
})

-- 2. Hook pour capturer l'ID
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if self == placeRemote and not isSpamming then
        capturedID = args[3]
        lastArg2 = args[2]
        game.StarterGui:SetCore("SendNotification", {
            Title = "🎯 ID CAPTURÉ",
            Text = "Prêt pour le swap !",
            Duration = 5
        })
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- 3. Fonction de Spam
local function startSwap()
    if capturedID == "" then return end
    isSpamming = true
    for i = 1, 15 do
        local timestamp = tick()
        pingRemote:FireServer(timestamp, "9aba28d9-6365-4f5b-843c-f4830e87c058")
        placeRemote:FireServer(timestamp, lastArg2, capturedID, 3)
        task.wait(0.01)
    end
    isSpamming = false
end

-- 4. Déclencheur
uis.InputBegan:Connect(function(input, processed)
    if not processed and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        startSwap()
    end
end)
