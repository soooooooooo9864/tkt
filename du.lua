-- DUPER DALLES + NOTIFS DEBUG
print("Initialisation...")

local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local net = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")

-- Remotes exactes
local placeRemote = net:WaitForChild("fce51e06-a587-4ff0-9e19-869eb1859a01")
local pingRemote = net:WaitForChild("eb9dee81-7718-4020-b6b2-219888488d13")

local capID = ""
local capSess = ""
local isSpamming = false

-- Fonction de notification simple
local function debugNotif(t, m)
    game.StarterGui:SetCore("SendNotification", {
        Title = t,
        Text = m,
        Duration = 3
    })
end

debugNotif("✅ DUPER CHARGÉ", "Pose ton Brainrot cher !")

-- Capture de l'ID
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if self == placeRemote and not isSpamming then
        capSess = args[2]
        capID = args[3]
        debugNotif("🎯 CAPTURE RÉUSSIE", "ID enregistré : " .. tostring(capID):sub(1,8))
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- Action de Dupe (Au clic/touche)
uis.InputBegan:Connect(function(input, processed)
    if not processed and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        if capID ~= "" then
            isSpamming = true
            debugNotif("🚀 SWAP EN COURS", "Bombardement de la dalle...")
            
            for i = 1, 15 do
                local t = tick()
                pingRemote:FireServer(t, "9aba28d9-6365-4f5b-843c-f4830e87c058")
                placeRemote:FireServer(t, capSess, capID, 3) -- Pose forcée
                task.wait(0.01)
            end
            isSpamming = false
            debugNotif("✅ FINI", "Vérifie la dalle !")
        else
            debugNotif("⚠️ ERREUR", "ID non capturé ! Pose l'objet.")
        end
    end
end)
