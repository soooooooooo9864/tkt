-- Script pour forcer le placement sur l'emplacement volé
local Remote = game:GetService("ReplicatedStorage"):FindFirstChild("PlaceBrainrot", true) -- À vérifier avec SimpleSpy

if Remote then
    -- On crée une fonction qui s'active quand tu cliques
    game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not processed then
            -- On envoie la position de ta souris au serveur
            local pos = game.Players.LocalPlayer:GetMouse().Hit.p
            Remote:FireServer(pos) 
            print("Tentative de placement forcée envoyée !")
        end
    end)
else
    warn("Le jeu a changé le nom du Remote ! Utilise un Spy.")
end
