local bedsFolder = game:GetService("Workspace"):WaitForChild("bed")

local function addESP(bed)
    if not bed:FindFirstChild("Highlight") then
        local esp = Instance.new("Highlight")
        esp.Parent = bed
        esp.FillColor = Color3.fromRGB(255, 0, 0)
        esp.OutlineColor = Color3.fromRGB(255, 255, 255)
        esp.FillTransparency = 0.5
    end

    if not bed:FindFirstChild("BedLabel") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "BedLabel"
        billboard.Size = UDim2.new(0, 100, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.Adornee = bed:IsA("Model") and bed.PrimaryPart or bed
        billboard.Parent = bed

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "BED"
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.TextStrokeTransparency = 0
        textLabel.TextScaled = true
        textLabel.Parent = billboard
    end

    -- Отслеживаем исчезновение кровати
    bed.AncestryChanged:Connect(function(_, parent)
        if not parent then
            if bed:FindFirstChild("Highlight") then
                bed.Highlight:Destroy()
            end
            if bed:FindFirstChild("BedLabel") then
                bed.BedLabel:Destroy()
            end
        end
    end)
end

-- Добавляем ESP для уже существующих кроватей
for _, bed in ipairs(bedsFolder:GetChildren()) do
    if bed:IsA("Model") or bed:IsA("Part") then
        addESP(bed)
    end
end

-- Подписываемся на появление новых кроватей
bedsFolder.ChildAdded:Connect(function(bed)
    task.wait(0.1)
    if bed:IsA("Model") or bed:IsA("Part") then
        addESP(bed)
    end
end)
