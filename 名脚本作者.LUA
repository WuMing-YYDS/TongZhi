local REVEAL_HINT_STACK = false
local ANTI_ENV_LOG_MESSAGE =
[[
    无名666
]]
if not getmetatable or not setmetatable or not type or not select or type(select(2, pcall(getmetatable, setmetatable({}, {__index = function(self, ...) while true do end end})))['__index']) ~= 'function' or not pcall or not debug or not rawget or not rawset or not pcall(rawset,{}," "," ") or not select or not getfenv or select(1, pcall(getfenv, 69)) == true or not select(2, pcall(rawget, debug, "info")) or #(((select(2, pcall(rawget, debug, "info")))(getfenv, "n")))<=1 or #(((select(2, pcall(rawget, debug, "info")))(print, "n")))<=1 or not (select(2, pcall(rawget, debug, "info")))(print, "s") == "[C]" or not (select(2, pcall(rawget, debug, "info")))(require, "s") == "[C]" or (select(2, pcall(rawget, debug, "info")))((function()end), "s") == "[C]" then
  return REVEAL_HINT_STACK and tostring(ANTI_ENV_LOG_MESSAGE) or nil
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

-- 这里填所有要显示标签的玩家名字，随便加
local TARGET_PLAYERS = {
    "z121410",
    "wuming688",
    "MameAAAW",
    "Rose_WuMing",
    "Rose_WuMing0,
    "WuMingYYDS1",
    "WuMingYYDS0",
    "WuMingYYDS",
}

local function destroyOldTags()
    for _,gui in ipairs(CoreGui:GetChildren()) do
        if gui.Name == "YeAdminTag" then
            gui:Destroy()
        end
    end
    for _,gui in ipairs(PlayerGui:GetChildren()) do
        if gui.Name == "YeAdminTag" then
            gui:Destroy()
        end
    end
end

local function createBillboardGui(character)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "YeAdminTag"
    billboard.Size = UDim2.new(0, 135, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 2.8, 0)
    billboard.AlwaysOnTop = true

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = billboard
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    mainFrame.BackgroundTransparency = 0.4
    mainFrame.Size = UDim2.new(1, 0, 1, 0)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = mainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Name = "RainbowStroke"
    stroke.Parent = mainFrame
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(255, 0, 0)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.LineJoinMode = Enum.LineJoinMode.Round

    local layout = Instance.new("UIListLayout")
    layout.Parent = mainFrame
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, 6)

    local crown = Instance.new("ImageLabel")
    crown.Name = "CrownIcon"
    crown.Parent = mainFrame
    crown.BackgroundTransparency = 1
    crown.Size = UDim2.new(0, 18, 0, 18)
    crown.Image = "rbxassetid://3926305904"
    crown.ImageRectOffset = Vector2.new(124, 84)
    crown.ImageRectSize = Vector2.new(36, 36)

    local crownGradient = Instance.new("UIGradient")
    crownGradient.Parent = crown

    local label = Instance.new("TextLabel")
    label.Name = "AdminLabel"
    label.Parent = mainFrame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0, 85, 0, 30)
    label.Font = Enum.Font.GothamBold
    label.Text = "名脚本作者"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 15
    label.TextWrapped = true

    local labelGradient = Instance.new("UIGradient")
    labelGradient.Parent = label

    local rainbowColors = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.15, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.45, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.9, Color3.fromRGB(139, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    labelGradient.Color = rainbowColors
    crownGradient.Color = rainbowColors

    local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local labelTween = TweenService:Create(labelGradient, tweenInfo, {Rotation = 360})
    local crownTween = TweenService:Create(crownGradient, tweenInfo, {Rotation = 360})
    labelTween:Play()
    crownTween:Play()

    task.spawn(function()
        local hue = 0.241
        local offsetY = 2.577
        while true do
            task.wait()
            hue = hue + 0.00007
            offsetY = offsetY - 0.00023
            stroke.Color = Color3.fromHSV(hue, 1, 1)
            billboard.StudsOffset = Vector3.new(0, offsetY, 0)
        end
    end)

    return billboard
end

-- 批量给所有目标玩家绑定标签
local function initPlayerTag(targetName)
    local targetPlayer = Players:FindFirstChild(targetName)
    if not targetPlayer then return end

    -- 玩家已加载角色时创建
    if targetPlayer.Character then
        local head = targetPlayer.Character:WaitForChild("Head", 5)
        local billboard = createBillboardGui(targetPlayer.Character)
        billboard.Adornee = head
        billboard.Parent = CoreGui
    end

    -- 重生自动重建标签
    targetPlayer.CharacterAdded:Connect(function(character)
        task.wait(0.1)
        destroyOldTags()
        local head = character:WaitForChild("Head", 5)
        local billboard = createBillboardGui(character)
        billboard.Adornee = head
        billboard.Parent = CoreGui
    end)
end

-- 循环遍历名单全部初始化
for _,name in ipairs(TARGET_PLAYERS) do
    task.spawn(function()
        initPlayerTag(name)
    end)
end

local fenv = getfenv()
fenv.Tween = function(obj, tweenInfo, properties)
    TweenService:Create(obj, TweenInfo.new(tweenInfo[1], Enum.EasingStyle[tweenInfo[2]], Enum.EasingDirection[tweenInfo[3]]), properties):Play()
    return true
end
fenv.Ripple = function() end
fenv.switchTab = function() end
fenv.drag = function() end

return {
    flags = {},
    new = function() end,
}
