-- VERSION FINALE : BRAINROT DUPER ULTRA-SWAP (BYPASS GUID)
local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local net = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")

-- Chemins détectés via tes logs Discord
local placeRemote = net:WaitForChild("fce51e06-a587-4ff0-9e19-869eb1859a01")
local pingRemote = net:WaitForChild("eb9dee81-7718-4020-b6b2-219888488d13")

-- Variables de stockage
local lastArg2 = "70646659-e472-4788-a9d8-cfa70e3d378c" -- Ton ID de session/base
local lastArg3 = "" -- Sera capturé dynamiquement

game.StarterGui:SetCore("SendNotification", {
    Title = "🔥 SWAPPER PRÊT";
    Text = "Pose un objet CHER une fois pour capturer l'ID !";
    Duration = 10;
})

-- 1. On "écoute" pour capturer l'ID de ton objet cher quand tu le poses la première fois
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if self == placeRemote then
        lastArg3 = args[3] -- On capture l'ID de l'objet (Arg 3)
        print("🎯 ID Objet capturé : " .. tostring(lastArg3))
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- 2. Fonction de SPAM pour le SWAP
local function startDupeSwap()
    if lastArg3 == "" then
        warn("⚠️ Tu dois poser ton objet cher au moins une fois avant !")
        return
    end

    print("🚀 LANCEMENT DU SWAP FORCÉ...")
    
    -- On envoie 20 requêtes ultra-rapides pour écraser la place vide
    for i = 1, 20 do
        local timestamp = tick()
        -- On envoie le Ping et la Pose en même temps pour simuler un vrai joueur
        pingRemote:FireServer(timestamp, "9aba28d9-6365-4f5b-843c-f4830e87c058")
        placeRemote:FireServer(timestamp, lastArg2, lastArg3, 3) 
        task.wait(0.005)
    end
    print("✅ Tentative terminée.")
end

-- 3. Déclencheur (Appuie sur l'écran au moment où l'ami vole l'objet nul)
uis.InputBegan:Connect(function(input, processed)
    if not processed and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        -- On vérifie si on est en train de "cliquer" pour swapper
        startDupeSwap()
    end
end)
