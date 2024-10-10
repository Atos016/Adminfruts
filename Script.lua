local adminPlayers = {rip_indra = true, mygame43 = true, Zioles = true}  -- Lista com os administradores
local detectedCommands = {}  -- Lista para armazenar comandos detectados
local groupId = 4372130  -- ID do grupo onde os administradores estão

-- Criando a interface gráfica (GUI)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TitleBar = Instance.new("TextLabel")
local CommandList = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

-- Configuração da tela e dos elementos
ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "AdminCommandGui"

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Active = true
Frame.Draggable = true  -- Torna a janela móvel

TitleBar.Parent = Frame
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Text = "Comandos de Admin"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.TextSize = 18

CommandList.Parent = Frame
CommandList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CommandList.BorderSizePixel = 0
CommandList.Position = UDim2.new(0, 0, 0, 30)
CommandList.Size = UDim2.new(1, 0, 1, -60)
CommandList.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandList.TextSize = 14
CommandList.TextWrapped = true
CommandList.TextYAlignment = Enum.TextYAlignment.Top
CommandList.Text = "Comandos detectados:\n"

MinimizeButton.Parent = Frame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18

CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18

-- Função para minimizar e maximizar a janela
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    if isMinimized then
        Frame.Size = UDim2.new(0, 400, 0, 300)
        isMinimized = false
    else
        Frame.Size = UDim2.new(0, 400, 0, 30)
        isMinimized = true
    end
end)

-- Função para fechar a janela
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Função para verificar o rank do jogador no grupo e se ele é um dos três administradores
local function checkGroupRank(player)
    local rank = player:GetRankInGroup(groupId)

    if player.Name == "mygame43" then
        print(player.Name .. " é o Oni owner (Dono).")
        return "Oni owner"
    elseif adminPlayers[player.Name] then
        print(player.Name .. " é Celestial owner (Quase Dono).")
        return "Celestial owner"
    else
        print(player.Name .. " é Fruit.")
        return "Fruit"
    end
end

-- Detecta jogadores quando entram no jogo e verifica o rank
game.Players.PlayerAdded:Connect(function(player)
    checkGroupRank(player)
end)

-- Detecta comandos usados por administradores e atualiza a lista na GUI
game:GetService("Players").PlayerChatted:Connect(function(message, recipient)
    for adminName in pairs(adminPlayers) do
        if game.Players:FindFirstChild(adminName) and message:sub(1, 1) == ":" then
            local command = message:sub(2)  -- Remove o ":" do comando
            table.insert(detectedCommands, command)  -- Armazena o comando
            CommandList.Text = CommandList.Text .. "\n" .. command  -- Atualiza a GUI
            print("Comando admin detectado: " .. command)
        end
    end
end)
