local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

-- Создаём много блоков
local BLOCK_COUNT = 2000  -- можно увеличить для сильного лагa
for i = 1, BLOCK_COUNT do
    local part = Instance.new("Part")
    part.Size = Vector3.new(2, 2, 2)
    part.Position = Vector3.new(math.random(-100, 100), math.random(5, 50), math.random(-100, 100))
    part.Anchored = false
    part.CanCollide = true
    part.Parent = Workspace
end

-- Функция притягивания блоков к игроку
local function pullToPlayer(part)
    part.CFrame = root.CFrame + Vector3.new(math.random(-1,1),3,math.random(-1,1))
end

-- Основной цикл
RunService.Heartbeat:Connect(function()
    for _, part in pairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            pullToPlayer(part)
        end
    end
end)
