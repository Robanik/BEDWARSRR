local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local BoxColor = Color3.fromRGB(0, 255, 0)

-- Создание Drawing объекта
local function createDrawing(type, props)
    local obj = Drawing.new(type)
    for i, v in pairs(props) do
        obj[i] = v
    end
    return obj
end

-- ESP для игрока
local function createESP(player)
    local box = createDrawing("Square", {
        Thickness = 1.5,
        Color = BoxColor,
        Filled = false,
        Visible = false
    })

    local tracer = createDrawing("Line", {
        Thickness = 1.5,
        Color = BoxColor,
        Visible = false
    })

    local nameText = createDrawing("Text", {
        Size = 14,
        Center = true,
        Outline = true,
        Color = Color3.fromRGB(0, 255, 0),
        Visible = false
    })

    local hpText = createDrawing("Text", {
        Size = 13,
        Center = true,
        Outline = true,
        Color = Color3.fromRGB(255, 0, 0),
        Visible = false
    })

    RunService.RenderStepped:Connect(function()
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                -- Позиции головы и ног
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local headPos, headVisible = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legPos, legVisible = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))

                    if headVisible or legVisible then
                        local boxHeight = math.abs(headPos.Y - legPos.Y)
                        local boxWidth = boxHeight / 2
                        local boxX = headPos.X - boxWidth / 2
                        local boxY = headPos.Y

                        -- Бокс
                        box.Visible = true
                        box.Size = Vector2.new(boxWidth, boxHeight)
                        box.Position = Vector2.new(boxX, boxY)
                        box.Color = BoxColor

                        -- Ник
                        nameText.Visible = true
                        nameText.Text = player.Name
                        nameText.Position = Vector2.new(headPos.X, headPos.Y - 15)

                        -- HP
                        hpText.Visible = true
                        hpText.Text = string.format("HP: %d", math.floor(humanoid.Health))
                        hpText.Position = Vector2.new(headPos.X, legPos.Y + 5)

                        -- Линия (tracer)
                        tracer.Visible = true
                        tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y) -- низ экрана
                        tracer.To = Vector2.new(root.Position.X, root.Position.Y)
                        tracer.To = Vector2.new((headPos.X + (headPos.X + boxWidth)) / 2, legPos.Y) -- центр бокса
                        tracer.Color = BoxColor
                    else
                        box.Visible = false
                        tracer.Visible = false
                        nameText.Visible = false
                        hpText.Visible = false
                    end
                end
            else
                box.Visible = false
                tracer.Visible = false
                nameText.Visible = false
                hpText.Visible = false
            end
        else
            box.Visible = false
            tracer.Visible = false
            nameText.Visible = false
            hpText.Visible = false
        end
    end)
end

-- Подключаем ESP ко всем игрокам
for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        createESP(plr)
    end
end

Players.PlayerAdded:Connect(function(plr)
    if plr ~= LocalPlayer then
        createESP(plr)
    end
end)
