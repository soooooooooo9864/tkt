-- VERSION ROBUSTE : BRAINROT DUPER V2
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local rs = game:GetService("ReplicatedStorage")

-- 1. Notification de démarrage
game.StarterGui:SetCore("SendNotification", {
    Title = "🔥 BRAINROT DUPER V2";
    Text = "Mode Swapper Activé - Prêt pour la Dupe";
    Duration = 5;
})

-- 2. Fonction de détection automatique (Recherche tous les Remotes de pose)
local function findPlacementRemote()
    local names = {"Place", "Deposit", "Claim", "Drop", "Build", "Set"}
    for _, obj in pairs(rs:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            for _, keyword in pairs(names) do
                if obj.Name:find(keyword) then
                    return obj
                end
            end
        end
    end
    return nil
end

local remote = findPlacementRemote()

-- 3. Le système de Force-Swap
local swapping = false

-- On utilise la touche "E" ou le clic pour lancer le swap rapide
mouse.Button1Down:Connect(function()
    if not remote then 
        remote = findPlacementRemote() -- Nouvelle tentative si pas trouvé
    end

    if remote then
        swapping = true
        print("🚀 Lancement du Rapid-Swap sur : " .. remote.Name)
        
        -- On envoie 10 requêtes très vite pour "forcer" le passage
        for i = 1, 10 do
            if not swapping then break end
            remote:FireServer(mouse.Hit.p) 
            task.wait(0.01) -- Délai ultra court
        end
        
        swapping = false
        print("✅ Cycle de swap terminé.")
    else
        warn("❌ Impossible de trouver le système de pose du jeu.")
    end
end)

-- 4. Petit bonus : Anti-AFK (pour ne pas être déconnecté pendant la dupe)
local virtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
end)
