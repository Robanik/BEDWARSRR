local player = game.Players.LocalPlayer
local jumpPower = 55

while true do
    wait(0.001)  -- обновление максимально часто
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = jumpPower
    end
end
