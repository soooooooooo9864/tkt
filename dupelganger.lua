-- BRAINROT DUPER V3 (ANTI-BLOCK BYPASS)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")

game.StarterGui:SetCore("SendNotification", {
    Title = "🚀 ARNINGDOUDI V3";
    Text = "Bypass de distance activé !";
    Duration = 5;
})

-- On cherche le Remote de Pose ET le Remote de Claim (prendre la place)
local function getRemotes()
    local p = rs:FindFirstChild("PlaceObject", true) or rs:FindFirstChild("PlaceItem", true)
    local c = rs:FindFirstChild("ClaimSlot", true) or rs:FindFirstChild("ClaimPlate", true)
    return p, c
end

local placeRemote, claimRemote = getRemotes()

local function forceSwap()
    local targetPos = mouse.Hit.p
    local oldPos = player.Character.HumanoidRootPart.CFrame

    if placeRemote then
        -- 1. TP discrètement sur la cible pour bypass la distance
        player.Character.HumanoidRootPart.CFrame = mouse.Hit * CFrame.new(0, 3, 0)
        task.wait(0.05) -- Petit délai pour que le serveur valide ta position

        -- 2. On spamme le Claim et le Placement en même temps
        for i = 1, 10 do
            if claimRemote then claimRemote:FireServer(targetPos) end
            placeRemote:FireServer(targetPos)
            task.wait(0.02)
        end

        -- 3. On te remet à ta place d'origine
        player.Character.HumanoidRootPart.CFrame = oldPos
        print("✅ Tentative de bypass terminée")
    else
        print("❌ Remote de pose introuvable")
    end
end

uis.InputBegan:Connect(function(input, processed)
    if not processed and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        forceSwap()
    end
end)
