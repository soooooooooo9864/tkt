-- DUPER AUTO-CAPTURE V4
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")

local net = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")
local capID, capSess = nil, nil
local isSpamming = false

-- On trouve les remotes automatiquement par leur comportement
local placeRemote, pingRemote
for _, v in pairs(net:GetChildren()) do
    if v.Name == "fce51e06-a587-4ff0-9e19-869eb1859a01" then placeRemote = v end
    if v.Name == "eb9dee81-7718-4020-b6b2-219888488d13" then pingRemote = v end
end

-- Notification de départ
game.StarterGui:SetCore("SendNotification", {
    Title = "🕵️ ATTENTE CAPTURE",
    Text = "Pose l'objet que tu veux duper !",
    Duration = 10
})

-- Espion de capture (Hook)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if self == placeRemote and not isSpamming then
        capSess = args[2] -- Récupère la session actuelle
        capID = args[3]   -- Récupère l'ID de l'objet posé
        game.StarterGui:SetCore("SendNotification", {
            Title = "🎯 OBJET CAPTURÉ !",
            Text = "ID enregistré. Reprends-le et prépare le swap.",
            Duration = 5
        })
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- Fonction de Dupe (Au clic/touche écran)
uis.InputBegan:Connect(function(input, processed)
    if not processed and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        if capID and capSess then
            isSpamming = true
            for i = 1, 15 do
                local t = tick()
                pingRemote:FireServer(t, "9aba28d9-6365-4f5b-843c-f4830e87c058")
                placeRemote:FireServer(t, capSess, capID, 3)
                task.wait(0.01)
            end
            isSpamming = false
        end
    end
end)
