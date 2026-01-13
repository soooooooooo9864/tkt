-- VERSION COMPATIBLE (SANS HOOK)
local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")

local net = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")
local placeRemote = net:WaitForChild("fce51e06-a587-4ff0-9e19-869eb1859a01")
local pingRemote = net:WaitForChild("eb9dee81-7718-4020-b6b2-219888488d13")

-- On utilise l'ID que tu as capturé dans tes logs Discord plus haut
local lastArg2 = "70646659-e472-4788-a9d8-cfa70e3d378c" 
local capturedID = "fae15e5e-0f38-4865-9046-8595414772fb" -- ID de ton objet (Arg 3 de tes logs)

game.StarterGui:SetCore("SendNotification", {
    Title = "✅ SCRIPT CHARGÉ",
    Text = "Prêt pour le swap forcé !",
    Duration = 5
})

local function startSwap()
    print("🚀 SWAP EN COURS...")
    for i = 1, 15 do
        local t = tick()
        pingRemote:FireServer(t, "9aba28d9-6365-4f5b-843c-f4830e87c058")
        placeRemote:FireServer(t, lastArg2, capturedID, 3)
        task.wait(0.01)
    end
    print("✅ FINI")
end

uis.InputBegan:Connect(function(input, processed)
    if not processed and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        startSwap()
    end
end)
