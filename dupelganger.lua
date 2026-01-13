-- TEST SIMPLIFIÉ
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local net = rs:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE")

local placeRemote = net:WaitForChild("fce51e06-a587-4ff0-9e19-869eb1859a01")
local pingRemote = net:WaitForChild("eb9dee81-7718-4020-b6b2-219888488d13")

local capID = ""
local sess = "70646659-e472-4788-a9d8-cfa70e3d378c"

game.StarterGui:SetCore("SendNotification", {Title = "PRET", Text = "Pose l'objet cher !"})

-- Capture simple
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if self == placeRemote and capID == "" then
        capID = args[3]
        sess = args[2]
        print("ID CAPTURE : "..tostring(capID))
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- Spam simple
uis.InputBegan:Connect(function(i, p)
    if not p and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) then
        if capID ~= "" then
            for count = 1, 10 do
                pingRemote:FireServer(tick(), "9aba28d9-6365-4f5b-843c-f4830e87c058")
                placeRemote:FireServer(tick(), sess, capID, 3)
                task.wait()
            end
        end
    end
end)
