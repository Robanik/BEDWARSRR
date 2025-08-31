-- Script в ServerScriptService
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    -- Кикаем игрока сразу с сообщением об ошибке 666
    player:Kick("Ошибка 666\nKICK BY ROBANIK")
end)
