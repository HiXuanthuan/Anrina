--[[ 
    🔥 Xthuan.dev Hub 🔥
    Auto Farm → Full Level → Auto Item/Raid/Fruit
    GUI: Redz UI V2 (nhỏ gọn)
]]

loadstring(game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua"))()

-- Tạo Window
local Window = MakeWindow({
    Hub = { Title = "Xthuan.dev Hub", Animation = "Youtube: Arin dev" },
    Key = { KeySystem = false }
})

-- Minimize
MinimizeButton({
    Image = "http://www.roblox.com/asset/?id=83190276951914",
    Size = {50, 50}, Color = Color3.fromRGB(15,15,15),
    Corner = true, Stroke = false
})

-------------------------------------------------
-- ⚔️ Tab Farm
-------------------------------------------------
local TabFarm = MakeTab({Name = "⚔️ Auto Farm"})

local AutoFarm = false
AddToggle(TabFarm, {
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        AutoFarm = Value
        while AutoFarm do
            task.wait()
            local Settings = {
                JoinTeam = "Pirates";
                Translator = true;
                AutoQuest = true;
                AutoFarm = true;
            }
            loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))(Settings)
        end
    end
})

-------------------------------------------------
-- 👹 Tab Boss/Item
-------------------------------------------------
local TabBoss = MakeTab({Name = "👹 Boss / Item"})

AddButton(TabBoss, {
    Name = "Auto Farm Saber",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou", true)
        -- farm boss Saber (Shanks)
    end
})

AddButton(TabBoss, {
    Name = "Auto Farm Pole",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelEnel", true)
    end
})

-------------------------------------------------
-- 📈 Tab Stats
-------------------------------------------------
local TabStats = MakeTab({Name = "📈 Auto Stats"})

AddButton(TabStats, {
    Name = "Auto Melee + Defense",
    Callback = function()
        while task.wait(1) do
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 3)
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 2)
        end
    end
})

-------------------------------------------------
-- 🍏 Tab Devil Fruit
-------------------------------------------------
local TabFruit = MakeTab({Name = "🍏 Devil Fruit"})

AddToggle(TabFruit, {
    Name = "Auto Random Fruit",
    Default = false,
    Callback = function(Value)
        while Value do
            task.wait(30)
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
        end
    end
})

AddButton(TabFruit, {
    Name = "Store Fruit",
    Callback = function()
        local fruit = game.Players.LocalPlayer.Data.DevilFruit.Value
        if fruit ~= "" then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", fruit)
        end
    end
})

-------------------------------------------------
-- 🔥 Tab Raid
-------------------------------------------------
local TabRaid = MakeTab({Name = "🔥 Raid"})

AddButton(TabRaid, {
    Name = "Start Raid",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Start")
    end
})

-------------------------------------------------
-- ⚙️ Tab Misc
-------------------------------------------------
local TabMisc = MakeTab({Name = "⚙️ Misc"})

AddButton(TabMisc, {Name = "FPS Boost", Callback = function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic end
    end
end})

AddButton(TabMisc, {Name = "Anti AFK", Callback = function()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(),workspace.CurrentCamera.CFrame)
        task.wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(),workspace.CurrentCamera.CFrame)
    end)
end})

-------------------------------------------------
-- 📊 Tab Info
-------------------------------------------------
local TabInfo = MakeTab({Name = "📊 Info"})
local plr = game.Players.LocalPlayer

AddLabel(TabInfo, "Level: "..plr.Data.Level.Value)
AddLabel(TabInfo, "Beli: "..plr.Data.Beli.Value)
AddLabel(TabInfo, "Fragments: "..plr.Data.Fragments.Value)
AddLabel(TabInfo, "Fruit: "..plr.Data.DevilFruit.Value)

spawn(function()
    while task.wait(2) do
        UpdateLabel(TabInfo, 1, "Level: "..plr.Data.Level.Value)
        UpdateLabel(TabInfo, 2, "Beli: "..plr.Data.Beli.Value)
        UpdateLabel(TabInfo, 3, "Fragments: "..plr.Data.Fragments.Value)
        UpdateLabel(TabInfo, 4, "Fruit: "..plr.Data.DevilFruit.Value)
    end
end)
