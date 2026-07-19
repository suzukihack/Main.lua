-- ==================================================
-- 🚀 NOCTERIS AIM & ESP • MARCAÇÃO VERMELHA + LINHAS
-- ✅ VERMELHO DESTACADO • LINHA DE VOCÊ ATÉ O ALVO
-- ✅ SETA DE DIREÇÃO • MIRA MAIS PRECISA • ATRÁS DE PAREDE
-- ==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ⚙️ CONFIGURAÇÕES
local Config = {
    ESP = false,
    Aimbot = false,
    LongShot = false,
    CorESP = Color3.fromRGB(255, 50, 50), -- 🔴 VERMELHO DESTACADO
    CorLinha = Color3.fromRGB(255, 80, 80),
    CorLinhaDistante = Color3.fromRGB(255, 150, 0),
    DistanciaMax = 800,
    SuavidadeMira = 6, -- ✅ MAIS RÁPIDA E PRECISA
    MiraNaCabeca = true -- ✅ MIRA NA CABEÇA
}

local Marcadores = {}
local UI, Janela, Area = nil, nil, nil

-- ==================================================
-- 🎨 INTERFACE • ARRASTÁVEL + MINIMIZÁVEL
-- ==================================================
local function CriarInterface()
    UI = Instance.new("ScreenGui")
    UI.Name = "Nocteris_Painel"
    UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    UI.DisplayOrder = 999
    UI.ResetOnSpawn = false
    UI.Parent = PlayerGui

    -- JANELA PRINCIPAL
    Janela = Instance.new("Frame")
    Janela.Size = UDim2.new(0, 420, 0, 400)
    Janela.Position = UDim2.new(0.35, 0, 0.15, 0)
    Janela.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
    Janela.BorderColor3 = Color3.fromRGB(45, 48, 60)
    Janela.BorderSizePixel = 1
    Janela.Active = true
    Janela.Draggable = true
    Janela.Parent = UI
    Instance.new("UICorner", Janela).CornerRadius = UDim.new(0, 12)

    -- CABEÇALHO
    local Cabecalho = Instance.new("Frame")
    Cabecalho.Size = UDim2.new(1, 0, 0, 50)
    Cabecalho.BackgroundColor3 = Color3.fromRGB(26, 29, 38)
    Cabecalho.Parent = Janela
    Instance.new("UICorner", Cabecalho).CornerRadius = UDim.new(0, 12)

    local BtnAba = Instance.new("TextButton")
    BtnAba.Size = UDim2.new(0, 90, 0, 34)
    BtnAba.Position = UDim2.new(0.04, 0, 0, 8)
    BtnAba.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
    BtnAba.Text = "⚙ Main"
    BtnAba.TextColor3 = Color3.new(1, 1, 1)
    BtnAba.Font = Enum.Font.GothamBold
    BtnAba.TextSize = 15
    BtnAba.AutoLocalize = false
    BtnAba.Parent = Cabecalho
    Instance.new("UICorner", BtnAba).CornerRadius = UDim.new(0, 8)

    local Titulo = Instance.new("TextLabel")
    Titulo.Size = UDim2.new(1, -140, 1, 0)
    Titulo.Position = UDim2.new(0, 105, 0, 0)
    Titulo.BackgroundTransparency = 1
    Titulo.Text = "✨ NOCTERIS AIM & ESP ✨"
    Titulo.TextColor3 = Color3.fromRGB(240, 240, 240)
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextSize = 17
    Titulo.TextXAlignment = Enum.TextXAlignment.Left
    Titulo.Parent = Cabecalho

    local BtnMin = Instance.new("TextButton")
    BtnMin.Size = UDim2.new(0, 32, 0, 32)
    BtnMin.Position = UDim2.new(1, -75, 0, 9)
    BtnMin.BackgroundColor3 = Color3.fromRGB(40, 44, 58)
    BtnMin.Text = "−"
    BtnMin.TextColor3 = Color3.fromRGB(220, 220, 220)
    BtnMin.Font = Enum.Font.GothamBold
    BtnMin.TextSize = 20
    BtnMin.AutoLocalize = false
    BtnMin.Parent = Cabecalho
    Instance.new("UICorner", BtnMin).CornerRadius = UDim.new(0, 8)

    local BtnFechar = Instance.new("TextButton")
    BtnFechar.Size = UDim2.new(0, 32, 0, 32)
    BtnFechar.Position = UDim2.new(1, -38, 0, 9)
    BtnFechar.BackgroundColor3 = Color3.fromRGB(58, 40, 45)
    BtnFechar.Text = "✕"
    BtnFechar.TextColor3 = Color3.fromRGB(255, 150, 150)
    BtnFechar.Font = Enum.Font.GothamBold
    BtnFechar.TextSize = 18
    BtnFechar.AutoLocalize = false
    BtnFechar.Parent = Cabecalho
    Instance.new("UICorner", BtnFechar).CornerRadius = UDim.new(0, 8)

    Area = Instance.new("Frame")
    Area.Size = UDim2.new(0.92, 0, 0, 300)
    Area.Position = UDim2.new(0.04, 0, 0, 58)
    Area.BackgroundTransparency = 1
    Area.Parent = Janela

    local function CriarAlavanca(Nome, Posicao, ChaveConfig)
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, 0, 0, 46)
        Container.Position = Posicao
        Container.BackgroundColor3 = Color3.fromRGB(28, 31, 40)
        Container.BorderColor3 = Color3.fromRGB(50, 54, 70)
        Container.BorderSizePixel = 1
        Container.Parent = Area
        Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)

        local Texto = Instance.new("TextLabel")
        Texto.Size = UDim2.new(0.7, 0, 1, 0)
        Texto.Position = UDim2.new(0.05, 0, 0, 0)
        Texto.BackgroundTransparency = 1
        Texto.Text = Nome
        Texto.TextColor3 = Color3.fromRGB(225, 225, 235)
        Texto.Font = Enum.Font.GothamSemibold
        Texto.TextSize = 15
        Texto.TextXAlignment = Enum.TextXAlignment.Left
        Texto.Parent = Container

        local Fundo = Instance.new("TextButton")
        Fundo.Size = UDim2.new(0, 50, 0, 26)
        Fundo.Position = UDim2.new(0.93, -50, 0.5, -13)
        Fundo.BackgroundColor3 = Color3.fromRGB(52, 56, 70)
        Fundo.Text = ""
        Fundo.AutoLocalize = false
        Fundo.Parent = Container
        Instance.new("UICorner", Fundo).CornerRadius = UDim.new(0, 13)

        local Bolinha = Instance.new("Frame")
        Bolinha.Size = UDim2.new(0, 20, 0, 20)
        Bolinha.Position = UDim2.new(0, 5, 0.5, -10)
        Bolinha.BackgroundColor3 = Color3.new(1, 1, 1)
        Bolinha.Parent = Fundo
        Instance.new("UICorner", Bolinha).CornerRadius = UDim.new(0, 10)

        Fundo.MouseButton1Click:Connect(function()
            Config[ChaveConfig] = not Config[ChaveConfig]
            if Config[ChaveConfig] then
                Fundo.BackgroundColor3 = Config.CorESP
                Bolinha.Position = UDim2.new(1, -25, 0.5, -10)
            else
                Fundo.BackgroundColor3 = Color3.fromRGB(52, 56, 70)
                Bolinha.Position = UDim2.new(0, 5, 0.5, -10)
            end
        end)
    end

    CriarAlavanca("🔴 Marcar Inimigos", UDim2.new(0, 0, 0, 8), "ESP")
    CriarAlavanca("🎯 Mira na Cabeça (Precisa)", UDim2.new(0, 0, 0, 62), "Aimbot")
    CriarAlavanca("⚡ Longo Alcance", UDim2.new(0, 0, 0, 116), "LongShot")

    local Minimizado = false
    BtnMin.MouseButton1Click:Connect(function()
        Minimizado = not Minimizado
        TweenService:Create(Janela, TweenInfo.new(0.3), {
            Size = Minimizado and UDim2.new(0, 420, 0, 50) or UDim2.new(0, 420, 0, 400)
        }):Play()
        Area.Visible = not Minimizado
    end)

    BtnFechar.MouseButton1Click:Connect(function() UI:Destroy() end)
end

-- ==================================================
-- 🔍 MARCAÇÃO VERMELHA + LINHA DE VOCÊ ATÉ O ALVO
-- ==================================================
local function CriarMarcador(Jogador)
    local Marcador = {}

    -- NOME + DISTÂNCIA
    local Nome = Instance.new("TextLabel")
    Nome.BackgroundTransparency = 1
    Nome.Text = Jogador.Name
    Nome.TextColor3 = Config.CorESP
    Nome.Font = Enum.Font.GothamBold
    Nome.TextSize = 16
    Nome.TextStrokeTransparency = 0
    Nome.TextStrokeColor3 = Color3.new(0, 0, 0)
    Nome.Size = UDim2.new(0, 220, 0, 28)
    Nome.Parent = UI

    -- CAIXA GROSSA VERMELHA
    local Caixa = Instance.new("Frame")
    Caixa.Size = UDim2.new(0, 60, 0, 85)
    Caixa.BackgroundTransparency = 0.6
    Caixa.BackgroundColor3 = Config.CorESP
    Caixa.BorderColor3 = Color3.new(1, 1, 1)
    Caixa.BorderSizePixel = 4 -- ✅ MAIS GROSSA
    Caixa.Parent = UI
    Instance.new("UICorner", Caixa).CornerRadius = UDim.new(0, 6)

    -- BRILHO VERMELHO
    local Brilho = Instance.new("Frame")
    Brilho.Size = UDim2.new(1, 0, 1, 0)
    Brilho.BackgroundColor3 = Config.CorESP
    Brilho.BackgroundTransparency = 0.8
    Brilho.Parent = Caixa
    Instance.new("UICorner", Brilho).CornerRadius = UDim.new(0, 6)

    -- BARRA DE VIDA
    local Vida = Instance.new("Frame")
    Vida.Size = UDim2.new(0, 8, 0, 85)
    Vida.Position = UDim2.new(1, 3, 0, 0)
    Vida.BackgroundColor3 = Color3.fromRGB(40, 200, 60)
    Vida.BackgroundTransparency = 0.1
    Vida.BorderSizePixel = 1
    Vida.BorderColor3 = Color3.new(1, 1, 1)
    Vida.Parent = Caixa

    -- ✅ LINHA: DO CENTRO DA TELA (VOCÊ) ATÉ O ALVO
    local Linha = Instance.new("Frame")
    Linha.Size = UDim2.new(0, 2, 0, 2)
    Linha.BackgroundColor3 = Config.CorLinha
    Linha.BorderSizePixel = 0
    Linha.Parent = UI

    -- ✅ SETA DE DIREÇÃO
    local Seta = Instance.new("TextLabel")
    Seta.BackgroundTransparency = 1
    Seta.Text = "➡️"
    Seta.TextColor3 = Config.CorESP
    Seta.Font = Enum.Font.GothamBold
    Seta.TextSize = 24
    Seta.TextStrokeTransparency = 0
    Seta.TextStrokeColor3 = Color3.new(0, 0, 0)
    Seta.Size = UDim2.new(0, 30, 0, 30)
    Seta.Parent = UI

    Marcador.Nome = Nome
    Marcador.Caixa = Caixa
    Marcador.Vida = Vida
    Marcador.Linha = Linha
    Marcador.Seta = Seta
    Marcador.Brilho = Brilho
    Marcadores[Jogador] = Marcador
end

local function RemoverMarcador(Jogador)
    if Marcadores[Jogador] then
        Marcadores[Jogador].Nome:Destroy()
        Marcadores[Jogador].Caixa:Destroy()
        Marcadores[Jogador].Linha:Destroy()
        Marcadores[Jogador].Seta:Destroy()
        Marcadores[Jogador] = nil
    end
end

-- ==================================================
-- ♻️ LOOP PRINCIPAL
-- ==================================================
RunService.RenderStepped:Connect(function()
    if not UI then return end
    local Camera = Workspace.CurrentCamera
    local CentroX = Camera.ViewportSize.X / 2
    local CentroY = Camera.ViewportSize.Y / 2
    local Me = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not Me then return end

    for Jogador in pairs(Marcadores) do
        if not Jogador:IsDescendantOf(Players) or Jogador == LocalPlayer then
            RemoverMarcador(Jogador)
        end
    end

    if Config.ESP then
        for _, Jogador in pairs(Players:GetPlayers()) do
            if Jogador ~= LocalPlayer and Jogador.Character then
                local HRP = Jogador.Character:FindFirstChild("HumanoidRootPart")
                local Hum = Jogador.Character:FindFirstChild("Humanoid")
                local Cabeca = Jogador.Character:FindFirstChild("Head")
                if not HRP or not Hum or Hum.Health <= 0 then
                    RemoverMarcador(Jogador)
                    continue
                end
                if not Marcadores[Jogador] then CriarMarcador(Jogador) end

                local Distancia = (Me.Position - HRP.Position).Magnitude
                if Distancia <= Config.DistanciaMax then
                    local AlturaAlvo = Cabeca and Cabeca.Position + Vector3.new(0, 0.5, 0) or HRP.Position + Vector3.new(0, 3.2, 0)
                    local Tela, Visivel = Camera:WorldToViewportPoint(AlturaAlvo)
                    local Marc = Marcadores[Jogador]

                    if Visivel then
                        -- ✅ CAIXA VERMELHA DESTACADA
                        Marc.Nome.Position = UDim2.new(0, Tela.X - 110, 0, Tela.Y - 75)
                        Marc.Nome.Text = "🔴 " .. Jogador.Name .. " [" .. math.floor(Distancia) .. "m]"
                        Marc.Caixa.Position = UDim2.new(0, Tela.X - 30, 0, Tela.Y - 45)
                        Marc.Vida.Size = UDim2.new(0, 8, 0, 85 * (Hum.Health / Hum.MaxHealth))
                        Marc.Vida.Position = UDim2.new(1, 3, 0, 85 * (1 - Hum.Health / Hum.MaxHealth))

                        -- ✅ LINHA DO CENTRO DA TELA (VOCÊ) ATÉ O ALVO
                        local TamLinha = math.sqrt((Tela.X - CentroX)^2 + (Tela.Y - CentroY)^2)
                        local AnguloLinha = math.deg(math.atan2(Tela.Y - CentroY, Tela.X - CentroX))
                        Marc.Linha.Size = UDim2.new(0, TamLinha, 0, 3)
                        Marc.Linha.Position = UDim2.new(0, CentroX, 0, CentroY)
                        Marc.Linha.Rotation = AnguloLinha
                        Marc.Linha.BackgroundColor3 = Distancia > 200 and Config.CorLinhaDistante or Config.CorLinha

                        -- ✅ SETA AO LADO DO NOME
                        Marc.Seta.Position = UDim2.new(0, Tela.X - 135, 0, Tela.Y - 78)
                        Marc.Seta.Rotation = AnguloLinha

                        Marc.Nome.Visible = true
                        Marc.Caixa.Visible = true
                        Marc.Linha.Visible = true
                        Marc.Seta.Visible = true
                    else
                        -- 🔴 ATRÁS DE PAREDE → SETA + LINHA DIRECIONAL
                        local Direcao = (HRP.Position - Me.Position).Unit
                        local Angulo = math.atan2(Direcao.X, Direcao.Z) - math.atan2(Camera.CFrame.LookVector.X, Camera.CFrame.LookVector.Z)
                        local Dist = math.min(Distancia / 3, 250)
                        local SetaX = CentroX + math.sin(Angulo) * Dist
                        local SetaY = CentroY - 80

                        Marc.Nome.Position = UDim2.new(0, SetaX - 110, 0, SetaY - 40)
                        Marc.Nome.Text = "➡️ " .. Jogador.Name .. " [" .. math.floor(Distancia) .. "m]"
                        Marc.Caixa.Visible = false

                        -- ✅ LINHA DO CENTRO ATÉ A SETA
                        local TamLinha = math.sqrt((SetaX - CentroX)^2 + (SetaY - CentroY)^2)
                        local AnguloLinha = math.deg(math.atan2(SetaY - CentroY, SetaX - CentroX))
                        Marc.Linha.Size = UDim2.new(0, TamLinha, 0, 3)
                        Marc.Linha.Position = UDim2.new(0, CentroX, 0, CentroY)
                        Marc.Linha.Rotation = AnguloLinha
                        Marc.Linha.BackgroundColor3 = Config.CorLinhaDistante

                        -- ✅ SETA GIRADA NA DIREÇÃO
                        Marc.Seta.Position = UDim2.new(0, SetaX - 15, 0, SetaY - 35)
                        Marc.Seta.Rotation = AnguloLinha
                        Marc.Seta.Text = "➡️"

                        Marc.Nome.Visible = true
                        Marc.Linha.Visible = true
                        Marc.Seta.Visible = true
                    end
                else
                    local Marc = Marcadores[Jogador]
                    if Marc then
                        Marc.Nome.Visible = false
                        Marc.Caixa.Visible = false
                        Marc.Linha.Visible = false
                        Marc.Seta.Visible = false
                    end
                end
            end
        end
    else
        for _, v in pairs(Marcadores) do
            v.Nome.Visible = false
            v.Caixa.Visible = false
            v.Linha.Visible = false
            v.Seta.Visible = false
        end
    end

    -- 🎯 AIMBOT MELHORADO • MIRA NA CABEÇA + MAIS PRECISA
    if Config.Aimbot then
        local Alvo, MelhorDist = nil, math.huge
        local CentroX, CentroY = Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2

        for _, Jogador in pairs(Players:GetPlayers()) do
            if Jogador ~= LocalPlayer and Jogador.Character then
                local HRP = Jogador.Character:FindFirstChild("HumanoidRootPart")
                local Cabeca = Jogador.Character:FindFirstChild("Head")
                local Hum = Jogador.Character:FindFirstChild("Humanoid")
                if HRP and Cabeca and Hum and Hum.Health > 0 then
                    local AlvoPos = Config.MiraNaCabeca and Cabeca.Position or HRP.Position + Vector3.new(0, 1.7, 0)
                    local Tela, Visivel = Camera:WorldToViewportPoint(AlvoPos)
                    if Visivel then
                        local Dist = math.sqrt((Tela.X - CentroX)^2 + (Tela.Y - CentroY)^2)
                        if Dist < MelhorDist and Dist < 200 then
                            MelhorDist = Dist
                            Alvo = AlvoPos
                        end
                    end
                end
            end
        end

        if Alvo then
            Camera.CFrame = Camera.CFrame:Lerp(
                CFrame.new(Camera.CFrame.Position, Alvo),
                1 / Config.SuavidadeMira
            )
        end
    end

    -- ⚡ ACERTAR DE LONGE
    if Config.LongShot and not Config.Aimbot then
        for _, Jogador in pairs(Players:GetPlayers()) do
            if Jogador ~= LocalPlayer and Jogador.Character then
                local HRP = Jogador.Character:FindFirstChild("HumanoidRootPart")
                local Cabeca = Jogador.Character:FindFirstChild("Head")
                local Hum = Jogador.Character:FindFirstChild("Humanoid")
                if HRP and Hum and Hum.Health > 0 then
                    local Dist = (Me.Position - HRP.Position).Magnitude
                    if Dist > 50 and Dist <= Config.DistanciaMax then
                        local _, Visivel = Camera:WorldToViewportPoint(HRP.Position)
                        if Visivel then
                            local AlvoPos = Cabeca and Cabeca.Position or HRP.Position + Vector3.new(0, 1.6, 0)
                            Camera.CFrame = CFrame.new(Camera.CFrame.Position, AlvoPos)
                        end
                    end
                end
            end
        end
    end
end)

-- 🚀 INICIAR
CriarInterface()
print("[NOCTERIS] ✅ VERMELHO DESTACADO • LINHAS • SETAS • MIRA PRECISA!")

