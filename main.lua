
--====================================================
-- BAD BOYS | DEXTER MORGAN V5.0
-- COMPACT BLOOD EDITION | ANDROID
--====================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

-- CORES
local BLACK = Color3.fromRGB(8, 5, 7)
local DARK = Color3.fromRGB(20, 12, 15)
local RED = Color3.fromRGB(175, 0, 25)
local BLOOD = Color3.fromRGB(100, 0, 15)
local WHITE = Color3.fromRGB(245, 240, 240)
local GRAY = Color3.fromRGB(145, 135, 135)

-- LIMPEZA
local old
pcall(function()
    old = CoreGui:FindFirstChild("BAD_BOYS_DEXTER_V5")
end)

if old then old:Destroy() end

-- COMANDOS
local commands = {
    {name="MAT FAL", message="/Mat [FAL]"},
    {name="MAT AK-47", message="/Mat [AK-47]"},
    {name="MAT M4A1", message="/Mat [M4A1]"},
    {name="RENDER", message="/render"},
    {name="TRACER", message="/tracer"},
    {name="BAZUCA", message="/bazuca"},
    {name="PATRULHA", message="/patrulha"},
    {name="SOCORRO", message="/socorro"}
}

-- CHAT
local function sendChat(message)
    local success, err = pcall(function()
        local channels = TextChatService:WaitForChild("TextChannels", 5)
        assert(channels, "Canais de chat indisponíveis")

        local channel = channels:FindFirstChild("RBXGeneral")

        if not channel then
            for _, v in ipairs(channels:GetChildren()) do
                if v:IsA("TextChannel") then
                    channel = v
                    break
                end
            end
        end

        assert(channel, "Canal de texto não encontrado")
        channel:SendAsync(message)
    end)

    if not success then
        warn("[DEXTER V5] Falha no envio:", err)
    end
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BAD_BOYS_DEXTER_V5"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999

local parentSuccess = pcall(function()
    gui.Parent = CoreGui
end)

if not parentSuccess or not gui.Parent then
    gui.Parent = Player:WaitForChild("PlayerGui")
end

-- FUNÇÕES VISUAIS
local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

local function stroke(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness
    s.Parent = obj
end

local function makeLabel(parent, text, size, position, color, font)
    local l = Instance.new("TextLabel")
    l.Size = size
    l.Position = position
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color
    l.Font = font or Enum.Font.GothamBold
    l.TextSize = 10
    l.Parent = parent
    return l
end

-- ARRASTAR
local function draggable(obj, handle)
    local dragging = false
    local dragInput
    local startInput
    local startPosition

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            startInput = input.Position
            startPosition = obj.Position

            if input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if not dragging then return end

        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input == dragInput then

            local delta = input.Position - startInput

            obj.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)
end

-- BOLINHA
local ball = Instance.new("TextButton")
ball.Name = "JK_BUTTON"
ball.Size = UDim2.fromOffset(43,43)
ball.Position = UDim2.new(0,12,0.42,0)
ball.BackgroundColor3 = BLACK
ball.Text = "JK"
ball.TextColor3 = WHITE
ball.TextSize = 17
ball.Font = Enum.Font.GothamBlack
ball.AutoButtonColor = false
ball.Parent = gui

corner(ball,100)
stroke(ball,RED,2)

local ballGradient = Instance.new("UIGradient")
ballGradient.Color = ColorSequence.new(BLACK, BLOOD)
ballGradient.Rotation = 45
ballGradient.Parent = ball

draggable(ball,ball)

-- PAINEL COMPACTO
local panel = Instance.new("Frame")
panel.Name = "DEXTER_PANEL"
panel.Size = UDim2.fromOffset(240,320)
panel.Position = UDim2.new(0.5,-120,0.5,-160)
panel.BackgroundColor3 = BLACK
panel.Visible = false
panel.ClipsDescendants = true
panel.Parent = gui

corner(panel,10)
stroke(panel,RED,1.5)

-- CABEÇALHO
local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,52)
header.BackgroundColor3 = DARK
header.Parent = panel

corner(header,9)

local logo = Instance.new("TextLabel")
logo.Size = UDim2.fromOffset(36,36)
logo.Position = UDim2.fromOffset(7,8)
logo.BackgroundColor3 = BLOOD
logo.Text = "🩸"
logo.TextSize = 18
logo.Parent = header

corner(logo,7)

local title = makeLabel(
    header,
    "DEXTER MORGAN",
    UDim2.new(1,-85,0,20),
    UDim2.fromOffset(50,7),
    WHITE,
    Enum.Font.GothamBlack
)
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Left

local subtitle = makeLabel(
    header,
    "BAD BOYS | V5.0",
    UDim2.new(1,-85,0,15),
    UDim2.fromOffset(50,27),
    RED
)
subtitle.TextSize = 8
subtitle.TextXAlignment = Enum.TextXAlignment.Left

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(23,23)
close.Position = UDim2.new(1,-29,0,8)
close.BackgroundColor3 = RED
close.Text = "X"
close.TextColor3 = WHITE
close.Font = Enum.Font.GothamBlack
close.TextSize = 11
close.Parent = header
corner(close,5)

draggable(panel,header)

-- MENU LATERAL
local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(6,59)
sidebar.Size = UDim2.new(0,68,1,-65)
sidebar.BackgroundColor3 = DARK
sidebar.Parent = panel
corner(sidebar,7)

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0,5)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

-- CONTEÚDO
local content = Instance.new("ScrollingFrame")
content.Position = UDim2.fromOffset(80,59)
content.Size = UDim2.new(1,-86,1,-65)
content.BackgroundTransparency = 1
content.ScrollBarThickness = 2
content.ScrollBarImageColor3 = RED
content.CanvasSize = UDim2.new(0,0,0,0)
content.Parent = panel

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,5)
layout.Parent = content

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    content.CanvasSize = UDim2.new(
        0,0,0,layout.AbsoluteContentSize.Y + 8
    )
end)

local function clear()
    for _,v in ipairs(content:GetChildren()) do
        if v:IsA("GuiObject") and v ~= layout then
            v:Destroy()
        end
    end
end

local function section(text)
    local l = makeLabel(
        content,
        text,
        UDim2.new(1,-4,0,22),
        UDim2.new(),
        RED,
        Enum.Font.GothamBlack
    )
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
end

local function inputBox(placeholder, default)
    local t = Instance.new("TextBox")
    t.Size = UDim2.new(1,-4,0,31)
    t.BackgroundColor3 = DARK
    t.Text = default or ""
    t.PlaceholderText = placeholder
    t.PlaceholderColor3 = GRAY
    t.TextColor3 = WHITE
    t.Font = Enum.Font.Gotham
    t.TextSize = 10
    t.ClearTextOnFocus = false
    t.Parent = content
    corner(t,5)
    return t
end

local function button(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-4,0,30)
    b.BackgroundColor3 = DARK
    b.Text = text
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 9
    b.AutoButtonColor = true
    b.Parent = content

    corner(b,5)
    stroke(b,BLOOD,1)

    b.Activated:Connect(callback)
    return b
end

local function sideButton(text, order, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-6,0,34)
    b.BackgroundColor3 = Color3.fromRGB(38,20,24)
    b.Text = text
    b.TextColor3 = WHITE
    b.TextSize = 8
    b.Font = Enum.Font.GothamBold
    b.LayoutOrder = order
    b.Parent = sidebar
    corner(b,5)

    b.Activated:Connect(callback)
end

-- PÁGINAS
local showCommands
local showEditor
local showMat
local showFaction

-- LISTA DE COMANDOS
showCommands = function()
    clear()
    section("COMANDOS")

    for i,cmd in ipairs(commands) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1,-4,0,57)
        row.BackgroundColor3 = DARK
        row.Parent = content
        corner(row,5)

        local name = makeLabel(
            row,
            cmd.name,
            UDim2.new(1,-8,0,19),
            UDim2.fromOffset(5,2),
            WHITE
        )
        name.TextXAlignment = Enum.TextXAlignment.Left
        name.TextSize = 9

        local send = Instance.new("TextButton")
        send.Position = UDim2.fromOffset(5,25)
        send.Size = UDim2.new(0.48,-5,0,25)
        send.BackgroundColor3 = RED
        send.Text = "ENVIAR"
        send.TextColor3 = WHITE
        send.TextSize = 8
        send.Font = Enum.Font.GothamBold
        send.Parent = row
        corner(send,4)

        send.Activated:Connect(function()
            sendChat(cmd.message)
        end)

        local edit = Instance.new("TextButton")
        edit.Position = UDim2.new(0.52,0,0,25)
        edit.Size = UDim2.new(0.48,-5,0,25)
        edit.BackgroundColor3 = Color3.fromRGB(55,45,48)
        edit.Text = "EDITAR"
        edit.TextColor3 = WHITE
        edit.TextSize = 8
        edit.Font = Enum.Font.GothamBold
        edit.Parent = row
        corner(edit,4)

        edit.Activated:Connect(function()
            showEditor(i)
        end)
    end
end

-- EDITOR
showEditor = function(index)
    clear()
    section(index and "EDITAR COMANDO" or "NOVO COMANDO")

    local current = index and commands[index]

    local name = inputBox("Nome do botão",current and current.name)
    local message = inputBox("Mensagem do chat",current and current.message)

    button("SALVAR",function()
        if name.Text:gsub("%s","") == ""
        or message.Text:gsub("%s","") == "" then
            warn("[DEXTER] Preencha os campos!")
            return
        end

        local item = {
            name = name.Text:sub(1,35),
            message = message.Text:sub(1,150)
        }

        if index then
            commands[index] = item
        else
            table.insert(commands,item)
        end

        showCommands()
    end)

    if index then
        button("EXCLUIR",function()
            table.remove(commands,index)
            showCommands()
        end)
    end

    button("VOLTAR",showCommands)
end

-- CRIADOR MAT
showMat = function()
    clear()
    section("CRIADOR DE MAT")

    local weapon = inputBox("Nome da arma","FAL")

    button("CRIAR MAT",function()
        local value = weapon.Text:gsub("[%c%[%]]",""):sub(1,35)

        if value:gsub("%s","") == "" then return end

        table.insert(commands,{
            name = "MAT "..value,
            message = "/Mat ["..value.."]"
        })

        showCommands()
    end)

    button("VOLTAR",showCommands)
end

-- IDENTIDADE
showFaction = function()
    clear()
    section("BAD BOYS")

    button("🐻 IDENTIDADE URSO",function()
        sendChat("BAD BOYS - URSO")
    end)

    button("BANDEIRA VERMELHA",function()
        sendChat("BAD BOYS - BANDEIRA VERMELHA")
    end)

    button("SAUDAÇÃO",function()
        sendChat("BAD BOYS - RESPEITO E LEALDADE")
    end)

    button("VOLTAR",showCommands)
end

-- MENU
sideButton("CMD",1,showCommands)
sideButton("EDITOR",2,function()
    showEditor(nil)
end)
sideButton("MAT",3,showMat)
sideButton("FAC",4,showFaction)

-- RODAPÉ
local footer = makeLabel(
    panel,
    "DEXTER MORGAN • BLOOD EDITION",
    UDim2.new(1,0,0,12),
    UDim2.new(0,0,1,-12),
    GRAY
)
footer.TextSize = 7

-- ABRIR E FECHAR
local opened = false
local animating = false

local function togglePanel()
    if animating then return end

    opened = not opened
    animating = true

    if opened then
        panel.Visible = true
        panel.Size = UDim2.fromOffset(240,0)

        local tween = TweenService:Create(
            panel,
            TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
            {Size = UDim2.fromOffset(240,320)}
        )

        tween:Play()
        tween.Completed:Connect(function()
            animating = false
        end)
    else
        local tween = TweenService:Create(
            panel,
            TweenInfo.new(0.18,Enum.EasingStyle.Quad),
            {Size = UDim2.fromOffset(240,0)}
        )

        tween:Play()
        tween.Completed:Connect(function()
            panel.Visible = false
            animating = false
        end)
    end
end

ball.Activated:Connect(togglePanel)

close.Activated:Connect(function()
    if opened then
        togglePanel()
    end
end)

-- INICIALIZAÇÃO
showCommands()

print("================================")
print("BAD BOYS | DEXTER MORGAN V5.0")
print("COMPACT BLOOD EDITION")
print("PAINEL CARREGADO!")
print("================================")
