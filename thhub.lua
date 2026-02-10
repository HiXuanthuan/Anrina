-- ================== TOGGLE BUTTON ==================
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Btn = Instance.new("ImageButton", ScreenGui)
local Corner = Instance.new("UICorner", Btn)

Btn.Size = UDim2.fromOffset(40,40)
Btn.Position = UDim2.new(0.1,0,0.2,0)
Btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
Btn.BorderSizePixel = 0
Btn.Image = "rbxassetid://83190276951914"
Btn.Draggable = true
Corner.CornerRadius = UDim.new(1,0)

-- ================== LOAD FLUENT ==================
local Fluent = loadstring(game:HttpGet(
"https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

repeat task.wait() until game:IsLoaded()

local Window = Fluent:CreateWindow({
    Title = "TH Hub",
    SubTitle = "Blox Fruits",
    TabWidth = 160,
    Size = UDim2.fromOffset(460,320),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.End
})

-- ================== ANIME BACKGROUND ==================
local AnimeBG = Instance.new("ImageLabel", game.CoreGui)
AnimeBG.Size = UDim2.new(1,0,1,0)
AnimeBG.BackgroundTransparency = 1
AnimeBG.ImageTransparency = 0.15
AnimeBG.ScaleType = Enum.ScaleType.Crop
AnimeBG.Image = "rbxassetid://15822120034" -- đổi ID nếu muốn

-- ================== TOGGLE UI ==================
local visible = true
Btn.MouseButton1Down:Connect(function()
    visible = not visible
    Window:Toggle(visible)
    AnimeBG.Visible = visible
end)

-- ================== TABS ==================
local Tabs = {
    Info = Window:AddTab({Title="Information"}),
    Bounty = Window:AddTab({Title="Auto Bounty"})
}

-- ================== PLAYER DATA ==================
local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")
local LP = Players.LocalPlayer

-- demo key time
local KeyExpire = os.time() + (2*3600 + 30*60)
local function KeyLeft()
    local r = math.max(0, KeyExpire - os.time())
    return math.floor(r/3600).." Hours "..math.floor((r%3600)/60).." Minutes"
end

local function GetBeli()
    return LP:FindFirstChild("leaderstats") and LP.leaderstats:FindFirstChild("Beli") and LP.leaderstats.Beli.Value or 0
end

local function GetFruit()
    return LP:FindFirstChild("Data") and LP.Data:FindFirstChild("DevilFruit") and LP.Data.DevilFruit.Value or "None"
end

-- typing effect
local function TypeText(t)
    local o=""
    for i=1,#t do o=t:sub(1,i) task.wait(0.02) end
    return o
end

-- ================== INFO ==================
local S = Tabs.Info:AddSection("Script Information")
S:AddParagraph({Title="Script Name", Content=TypeText("TH Hub")})
S:AddParagraph({Title="Player Name", Content=TypeText(LP.Name)})
S:AddParagraph({Title="Key Time Remaining", Content=TypeText(KeyLeft())})
S:AddParagraph({Title="APIs Used", Content=TypeText("Fluent UI, HttpGet, VirtualInputManager")})
S:AddParagraph({Title="Players in Server", Content=TypeText(tostring(#Players:GetPlayers()))})
S:AddParagraph({Title="Current Devil Fruit", Content=TypeText(GetFruit())})
S:AddParagraph({Title="Beli", Content=TypeText(tostring(GetBeli()))})

Tabs.Info:AddButton({
    Title="YouTube",
    Description="TH Channel",
    Callback=function()
        setclipboard("https://www.youtube.com/@xthteam")
    end
})

-- ================== AUTO BOUNTY (SKILLS) ==================
getgenv().AutoBounty = false
getgenv().MinBounty = 2500000
getgenv().SkillDelay = 0.6

local function Root(c) return c and c:FindFirstChild("HumanoidRootPart") end
local function Alive(p)
    return p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health>0
end
local function Bounty(p)
    return p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Bounty") and p.leaderstats.Bounty.Value or 0
end
local function Press(k)
    VIM:SendKeyEvent(true,k,false,game); task.wait(0.05)
    VIM:SendKeyEvent(false,k,false,game)
end
local function Skills()
    Press(Enum.KeyCode.Z); task.wait(getgenv().SkillDelay)
    Press(Enum.KeyCode.X); task.wait(getgenv().SkillDelay)
    Press(Enum.KeyCode.C); task.wait(getgenv().SkillDelay)
    Press(Enum.KeyCode.V)
end
local function Target()
    local me = Root(LP.Character); if not me then return end
    local best,dist=nil,math.huge
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and Alive(p) and Bounty(p)>=getgenv().MinBounty then
            local r=Root(p.Character)
            if r then
                local d=(me.Position-r.Position).Magnitude
                if d<dist then best,dist=p,d end
            end
        end
    end
    return best
end

Tabs.Bounty:AddToggle("AutoBounty",{
    Title="Auto Bounty (Skills)",
    Default=false,
    Callback=function(v) getgenv().AutoBounty=v end
})

task.spawn(function()
    while task.wait(0.3) do
        if not getgenv().AutoBounty then continue end
        local t = Target()
        if t and Root(LP.Character) and Root(t.Character) then
            Root(LP.Character).CFrame = Root(t.Character).CFrame * CFrame.new(0,0,-3)
            Skills()
        end
    end
end)

Fluent:Notify({Title="TH Hub", Content="Loaded Successfully!", Duration=4})
