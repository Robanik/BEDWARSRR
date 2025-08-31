-- LocalScript в StarterPlayerScripts
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Перехват метода :Kick()
local oldKick = Player.Kick
Player.Kick = function(...) 
    print("Попытка кика заблокирована!") 
end

-- Перехват метода :KickWithReason() и других через метатаблицу
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "KickWithReason" then
        print("Попытка кика через сервер заблокирована!")
        return
    end
    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

print("Антикик включен! Кик через сервер заблокирован.")
