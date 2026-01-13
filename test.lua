-- VERSION BOUTON (ULTRA COMPATIBLE)
local ScreenGui = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Button.Parent = ScreenGui
Button.Size = UDim2.new(0, 150, 0, 50)
Button.Position = UDim2.new(0.5, -75, 0.5, -25)
Button.Text = "CLIQUE ICI POUR DUPE"
Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

local placeRemote = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE"):WaitForChild("fce51e06-a587-4ff0-9e19-869eb1859a01")
local pingRemote = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE"):WaitForChild("eb9dee81-7718-4020-b6b2-219888488d13")

local sessID = "70646659-e472-4788-a9d8-cfa70e3d378c"
local itemID = "fae15e5e-0f38-4865-9046-8595414772fb"

Button.MouseButton1Click:Connect(function()
    print("Bouton cliqué !")
    for i = 1, 10 do
        local t = tick()
        pingRemote:FireServer(t, "9aba28d9-6365-4f5b-843c-f4830e87c058")
        placeRemote:FireServer(t, sessID, itemID, 3)
        task.wait(0.05)
    end
end)
