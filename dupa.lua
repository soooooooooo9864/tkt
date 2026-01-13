-- VERSION SPÉCIAL DALLES (ID FIXE)
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")

-- Les Remotes et IDs que tu as fournis
local net = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")
local placeRemote = net["fce51e06-a587-4ff0-9e19-869eb1859a01"]
local pingRemote = net["eb9dee81-7718-4020-b6b2-219888488d13"]

local sessID = "70646659-e472-4788-a9d8-cfa70e3d378c"
local itemID = "fae15e5e-0f38-4865-9046-8595414772fb" -- Ton Brainrot Cher

-- Affichage discret en haut
local ui = Instance.new("ScreenGui", game.CoreGui)
local txt = Instance.new("TextLabel", ui)
txt.Size = UDim2.new(1, 0, 0, 30)
txt.Text = "PRÊT : CLIQUE SUR LA DALLE POUR SWAP"
txt.BackgroundColor3 = Color3.fromRGB(0,0,0)
txt.TextColor3 = Color3.fromRGB(255,255,255)

local function doSwap()
    for i = 1, 15 do
        local t = tick()
        pingRemote:FireServer(t, "9aba28d9-6365-4f5b-843c-f4830e87c058")
        -- On force la pose sur la dalle (Arg 3 = 3 signifie souvent la dalle)
        placeRemote:FireServer(t, sessID, itemID, 3)
        task.wait(0.01)
    end
end

-- Se déclenche quand tu cliques sur l'écran (donc sur la dalle)
uis.InputBegan:Connect(function(input, processed)
    if not processed and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        doSwap()
    end
end)
