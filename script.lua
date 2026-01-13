-- VERSION ROBUSTE MOBILE : BRAINROT DUPER V2 (DELTA)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")

-- 1. Notification de démarrage (Adaptée mobile)
game.StarterGui:SetCore("SendNotification", {
    Title = "🔥 BRAINROT DUPER V2";
    Text = "Mode Mobile Activé - Touchez pour Swapper";
    Duration = 5;
})

-- 2. Fonction de détection automatique (Recherche tous les Remotes de pose)
local function findPlacementRemote()
    local names = {"Place", "Deposit", "Claim", "Drop", "Build", "Set", "Put"}
    for _, obj in pairs(rs:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            for _, keyword in pairs(names) do
                if string.find(obj.Name:lower(), keyword:lower()) then
                    return obj
                end
            end
        end
    end
    return nil
end

local remote = findPlacementRemote()

-- 3. Le système de Force-Swap optimisé pour le Toucher
local function executeSwap()
    if not remote then 
        remote = findPlacementRemote() 
    end

    if remote then
        print("🚀 Rapid-Swap lancé sur : " .. remote.Name)
        
        -- On envoie 15 requêtes (mieux pour la latence mobile)
        for i = 1, 15 do
            -- On utilise le CFrame de la souris ou la position devant le perso
            local targetPos = mouse.Hit.p
            remote:FireServer(targetPos) 
            task.wait(0.01) -- Délai pour ne pas faire crash Delta
        end
        print("✅ Cycle terminé.")
    else
        warn("❌ Remote non trouvé ! Essayez de poser un objet manuellement une fois.")
    end
end

-- Détection universelle : Clic souris ET Toucher mobile
uis.InputBegan:Connect(function(input, processed)
    if processed then return end -- Évite de s'activer si on touche un bouton du menu
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        executeSwap()
    end
end)

-- 4. Anti-AFK Mobile
player.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

print("Script prêt pour Delta Mobile !")
