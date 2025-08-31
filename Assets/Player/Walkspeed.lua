local player = game.Players.LocalPlayer
local speed = 30

-- Обновление скорости
while true do
    wait(0.001)  -- минимальная задержка, примерно 1 мс
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end
