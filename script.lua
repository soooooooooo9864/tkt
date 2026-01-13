--[[ 
  SCRIPT DE PLACEMENT FORCÉ (SWAP)
  Ce code s'exécutera quand tu feras ton loadstring dans Delta
--]]

print("Script de Dupe Chargé !")

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local rs = game:GetService("ReplicatedStorage")

-- On cherche le Remote du jeu (on teste les noms les plus courants)
local placeRemote = rs:FindFirstChild("PlaceItem", true) or rs:FindFirstChild("DropBrainrot", true) or rs:FindFirstChild("PlaceObject", true)

if not placeRemote then
    warn("ERREUR : Le Remote de pose n'a pas été trouvé. Le jeu est peut-être protégé.")
end

-- Fonction pour forcer le placement quand tu cliques
mouse.Button1Down:Connect(function()
    if placeRemote then
        -- On envoie la position de ta souris au serveur
        -- Même si l'emplacement est "volé", le script force l'envoi du message
        placeRemote:FireServer(mouse.Hit.p)
        print("Placement forcé envoyé à : " .. tostring(mouse.Hit.p))
    end
end)
