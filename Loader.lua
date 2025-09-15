localocalocalocal player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- SETTINGS
local autoStrength = true
local autoSacrifice = true
local autoAscend = true
local autoCollectOrbs = true
local autoAnswerMath = true

-- WAIT FOR CHARACTER
repeat wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

-- AUTO STRENGTH
spawn(function()
    while autoStrength do
        if ReplicatedStorage:FindFirstChild("AddStrength") then
            ReplicatedStorage.AddStrength:FireServer()
        end
        wait(0.1)
    end
end)

-- AUTO SACRIFICE
spawn(function()
    while autoSacrifice do
        if ReplicatedStorage:FindFirstChild("Sacrifice") then
            ReplicatedStorage.Sacrifice:FireServer()
        end
        wait(1)
    end
end)

-- AUTO ASCEND
spawn(function()
    while autoAscend do
        if ReplicatedStorage:FindFirstChild("Ascend") then
            ReplicatedStorage.Ascend:FireServer()
        end
        wait(1)
    end
end)

-- AUTO COLLECT ORBS
spawn(function()
    while autoCollectOrbs do
        for _, orb in pairs(Workspace.Orbs:GetChildren()) do
            if orb:IsA("Part") then
                player.Character.HumanoidRootPart.CFrame = orb.CFrame
                wait(0.1)
            end
        end
        wait(1)
    end
end)

-- AUTO ANSWER MATH
spawn(function()
    if autoAnswerMath then
        game:GetService("Players").PlayerAdded:Connect(function(plr)
            plr.Chatted:Connect(function(msg)
                if msg:match("Solve:") then
                    local answer = load("return " .. msg:match("Solve: (.+)"))()
                    if ReplicatedStorage:FindFirstChild("AnswerMath") then
                        ReplicatedStorage.AnswerMath:FireServer(answer)
                    end
                end
            end)
        end)
    end
end)
