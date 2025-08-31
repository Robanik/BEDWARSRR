local Players = game:GetService("Players")

local function kickPlayer(player)
    -- Кикаем игрока с сообщением, имитирующим ошибку 666
    player:Kick("Ошибка 666! BY ROBANIK LOLOLOLOL")
end

local player = Players.LocalPlayer -- Для LocalScript
kickPlayer(player)
