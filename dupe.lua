print("Vérification du chargement...")

local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")

-- Chemins
local net = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")
local placeRemote = net:WaitForChild("fce51e06-a587-4ff0-9e19-869eb1859a01")
local pingRemote = net:WaitForChild("eb9dee81-7718-4020-b6b2-219888488d13")

local capID = ""
local capSess = ""
local isSpamming = false

-- Notif de départ
game.StarterGui:SetCore("SendNotification", {
    Title = "🕵️ SYSTÈME ACTIF",
    Text = "Pose un objet pour capturer son ID !",
    Duration = 5
})

-- Système de Capture (Hook Namecall)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if self == placeRemote and not isSpamming then
        capSess = args[2]
        capID = args[3]
        game.StarterGui:SetCore("SendNotification", {
            Title = "🎯 ID CAPTURÉ",
            Text = "ID: " .. tostring(capID),
            Duration = 5
        })
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- Système de Spam (Swap)
uis.InputBegan:Connect(function(input, processed)
    if not processed and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        if capID ~= "" and capSess ~= "" then
            isSpamming = true
            for i = 1, 12 do
                local t = tick()
                pingRemote:FireServer(t, "9aba28d9-6365-4f5b-843c-f4830e87c058")
                placeRemote:FireServer(t, capSess, capID, 3)
                task.wait(0.01)
            end
            isSpamming = false
        end
    end
end)
