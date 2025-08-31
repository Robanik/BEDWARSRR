local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

-- Функция, чтобы телепортировать объект к игроку
local function teleportToPlayer(obj)
    if obj:IsA("BasePart") then
        obj.CFrame = root.CFrame + Vector3.new(0, 3, 0) -- поднимаем немного, чтобы не застряли
    end
end

-- Основной цикл, телепортирует все блоки каждый кадр
RunService.Heartbeat:Connect(function()
    for _, part in pairs(workspace:GetDescendants()) do
        teleportToPlayer(part)
    end
end)
