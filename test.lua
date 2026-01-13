-- VERSION FINALE ET CORRIGÉE (ULTRA-COMPATIBLE)
local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")

-- Accès direct aux Remotes (sans WaitForChild pour éviter les blocages)
local NetRE = rs.Packages.Net.RE
local placeRemote = NetRE["fce51e06-a587-4ff0-9e19-869eb1859a01"]
local pingRemote = NetRE["eb9dee81-7718-4020-b6b2-219888488d13"]

-- Tes IDs de session et d'objet (Vérifiés)
local mySession = "70646659-e472-4788-a9d8-cfa70e3d378c"
local itemToDupe = "fae15e5e-0f38-4865-9046-8595414772fb"

-- Notification de succès au lancement
game.StarterGui:SetCore("SendNotification", {
    Title = "⭐ SYSTÈME PRÊT",
    Text = "Appuie sur le bouton pour duper !",
    Duration = 5
})

-- Création d'un bouton simple à l'écran (Plus fiable que le clic au sol)
local sg = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 200, 0, 60)
btn.Position = UDim2.new(0.5, -100, 0.8, 0) -- En bas au milieu
btn.Text = "FORCE SWAP (CLIQUE ICI)"
btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 20

-- Fonction de duplication (Le Spam)
btn.MouseButton1Click:Connect(function()
    btn.Text = "SPAMMING..."
    btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    
    for i = 1, 15 do
        local t = tick()
        -- Envoi des paquets au serveur
        pingRemote:FireServer(t, "9aba28d9-6365-4f5b-843c-f4830e87c058")
        placeRemote:FireServer(t, mySession, itemToDupe, 3)
        task.wait(0.02)
    end
    
    btn.Text = "FORCE SWAP (CLIQUE ICI)"
    btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
end)
