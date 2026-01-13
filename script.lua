-- SCRIPT DE DUPE POUR STEAL A BRAINROT
print("Initialisation du script...")

-- 1. Notification pour confirmer que Delta a bien chargé le fichier
game.StarterGui:SetCore("SendNotification", {
    Title = "Brainrot Swapper";
    Text = "Script chargé ! Cliquez pour forcer la pose.";
    Duration = 5;
})

-- 2. Configuration du clic magique
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.Button1Down:Connect(function()
    -- On cherche dynamiquement l'événement de pose du jeu
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("PlaceObject", true) 
                or game:GetService("ReplicatedStorage"):FindFirstChild("PlaceItem", true)
                or game:GetService("ReplicatedStorage"):FindFirstChild("ClaimSlot", true)

    if remote then
        -- Force l'envoi de la position de ta souris au serveur
        remote:FireServer(mouse.Hit.p)
        print("Envoi du signal de pose forcé vers : " .. tostring(mouse.Hit.p))
    else
        warn("Remote non trouvé ! Le jeu a peut-être changé de nom d'événement.")
    end
end)
