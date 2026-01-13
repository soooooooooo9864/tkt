-- Notification pour savoir que ça a marché
game.StarterGui:SetCore("SendNotification", {
    Title = "Brainrot Dupe";
    Text = "Script de placement activé !";
    Duration = 5;
})

print("Le script est prêt !")

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- On force le placement quand tu cliques
mouse.Button1Down:Connect(function()
    -- On cherche le système de pose du jeu
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("PlaceObject", true) 
                or game:GetService("ReplicatedStorage"):FindFirstChild("PlaceItem", true)
    
    if remote then
        remote:FireServer(mouse.Hit.p)
        print("Placement forcé envoyé !")
    else
        print("Remote non trouvé, essaye de poser un objet pour le détecter")
    end
end)
