-- LocalScript в StarterPlayerScripts
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Перехват метода :Ban() (если используется кастомная реализация)
if Player.Ban then
    local oldBan = Player.Ban
    Player.Ban = function(...) end
end

-- Перехват любых бан-методов через метатаблицу
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Ban" or method == "BanWithReason" then
        return
    end
    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

-- Автоматическое восстановление игрока без вывода сообщений
local function restorePlayer()
    if not Player.Parent then
        Player.Parent = Players
    end
end

-- Проверяем каждые 0.5 секунды
while true do
    restorePlayer()
    wait(0.5)
end
