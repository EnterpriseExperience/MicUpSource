local EmotesConfiguration = Instance.new("ScreenGui")
local Emotes_Frame = Instance.new("ImageLabel")
local ZEH_Title = Instance.new("TextLabel")
local Speed_Up_Speed = Instance.new("TextBox")
local Slow_Down_Speed = Instance.new("TextBox")
local Freeze_Keybind = Instance.new("TextBox")
local Speed_Keybind = Instance.new("TextBox")
local Enabled_Status = Instance.new("TextLabel")
local Normal_Keybind = Instance.new("TextBox")
local Close = Instance.new("TextButton")
local Alternate_Title = Instance.new("TextLabel")
local Settings_Menu = Instance.new("TextButton")
local Settings_Roundify_12px = Instance.new("ImageLabel")
local Button_Text = Instance.new("TextLabel")
local TextLabel = Instance.new("TextLabel")
local Toggle_GUI = Instance.new("TextButton")
local Settings_Frame = Instance.new("ImageLabel")
local Emote_1 = Instance.new("TextBox")
local Emote_3 = Instance.new("TextBox")
local Emote_2 = Instance.new("TextBox")
local Emote_4 = Instance.new("TextBox")
local Emote_5 = Instance.new("TextBox")
local Emote_6 = Instance.new("TextBox")
local Emote_7 = Instance.new("TextBox")
local Emote_8 = Instance.new("TextBox")
local Emote_9 = Instance.new("TextBox")
local Close_2 = Instance.new("TextButton")
local EmoteID_2 = Instance.new("TextButton")
local EmoteID_9 = Instance.new("TextButton")
local EmoteID_8 = Instance.new("TextButton")
local EmoteID_7 = Instance.new("TextButton")
local EmoteID_6 = Instance.new("TextButton")
local EmoteID_5 = Instance.new("TextButton")
local EmoteID_4 = Instance.new("TextButton")
local EmoteID_3 = Instance.new("TextButton")
local EmoteID_1 = Instance.new("TextButton")
local Load_Cfg = Instance.new("TextButton")
local Save_Cfg = Instance.new("TextButton")
local Del_Cfg = Instance.new("TextButton")

EmotesConfiguration.Name = "Emotes-Configuration"
EmotesConfiguration.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
EmotesConfiguration.ResetOnSpawn = false
EmotesConfiguration.IgnoreGuiInset = true

Emotes_Frame.Name = "Emotes_Frame"
Emotes_Frame.Parent = EmotesConfiguration
Emotes_Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Emotes_Frame.BackgroundTransparency = 1.000
Emotes_Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
Emotes_Frame.Position = UDim2.new(0.240302265, 0, 0.206030145, 0)
Emotes_Frame.Size = UDim2.new(0, 368, 0, 533)
Emotes_Frame.Image = "rbxassetid://3570695787"
Emotes_Frame.ImageColor3 = Color3.fromRGB(30, 30, 30)
Emotes_Frame.ScaleType = Enum.ScaleType.Slice
Emotes_Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Emotes_Frame.SliceScale = 0.120

ZEH_Title.Name = "ZEH_Title"
ZEH_Title.Parent = Emotes_Frame
ZEH_Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ZEH_Title.BackgroundTransparency = 1.000
ZEH_Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
ZEH_Title.BorderSizePixel = 0
ZEH_Title.Size = UDim2.new(0, 330, 0, 32)
ZEH_Title.Font = Enum.Font.SourceSansBold
ZEH_Title.Text = "Made By: Zacks Easy Hub, LLC."
ZEH_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
ZEH_Title.TextScaled = true
ZEH_Title.TextSize = 14.000
ZEH_Title.TextWrapped = true

Speed_Up_Speed.Name = "Speed_Up_Speed"
Speed_Up_Speed.Parent = Emotes_Frame
Speed_Up_Speed.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Speed_Up_Speed.BorderColor3 = Color3.fromRGB(0, 0, 0)
Speed_Up_Speed.BorderSizePixel = 0
Speed_Up_Speed.Position = UDim2.new(0.0326086953, 0, 0.133735925, 0)
Speed_Up_Speed.Size = UDim2.new(0, 347, 0, 37)
Speed_Up_Speed.Font = Enum.Font.SourceSansBold
Speed_Up_Speed.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Speed_Up_Speed.PlaceholderText = "Put \"Speed Up\" speed here"
Speed_Up_Speed.Text = ""
Speed_Up_Speed.TextColor3 = Color3.fromRGB(255, 255, 255)
Speed_Up_Speed.TextScaled = true
Speed_Up_Speed.TextSize = 14.000
Speed_Up_Speed.TextWrapped = true

Slow_Down_Speed.Name = "Slow_Down_Speed"
Slow_Down_Speed.Parent = Emotes_Frame
Slow_Down_Speed.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Slow_Down_Speed.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slow_Down_Speed.BorderSizePixel = 0
Slow_Down_Speed.Position = UDim2.new(0.0326086953, 0, 0.217951164, 0)
Slow_Down_Speed.Size = UDim2.new(0, 347, 0, 37)
Slow_Down_Speed.Font = Enum.Font.SourceSansBold
Slow_Down_Speed.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Slow_Down_Speed.PlaceholderText = "Put \"Slow Down\" speed here"
Slow_Down_Speed.Text = ""
Slow_Down_Speed.TextColor3 = Color3.fromRGB(255, 255, 255)
Slow_Down_Speed.TextScaled = true
Slow_Down_Speed.TextSize = 14.000
Slow_Down_Speed.TextWrapped = true

Freeze_Keybind.Name = "Freeze_Keybind"
Freeze_Keybind.Parent = Emotes_Frame
Freeze_Keybind.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Freeze_Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
Freeze_Keybind.BorderSizePixel = 0
Freeze_Keybind.Position = UDim2.new(0.0326086953, 0, 0.303965628, 0)
Freeze_Keybind.Size = UDim2.new(0, 347, 0, 37)
Freeze_Keybind.Font = Enum.Font.SourceSansBold
Freeze_Keybind.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Freeze_Keybind.PlaceholderText = "Put \"Freeze Keybind\" here"
Freeze_Keybind.Text = ""
Freeze_Keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
Freeze_Keybind.TextScaled = true
Freeze_Keybind.TextSize = 14.000
Freeze_Keybind.TextWrapped = true

Speed_Keybind.Name = "Speed_Keybind"
Speed_Keybind.Parent = Emotes_Frame
Speed_Keybind.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Speed_Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
Speed_Keybind.BorderSizePixel = 0
Speed_Keybind.Position = UDim2.new(0.0326086953, 0, 0.389903128, 0)
Speed_Keybind.Size = UDim2.new(0, 347, 0, 37)
Speed_Keybind.Font = Enum.Font.SourceSansBold
Speed_Keybind.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Speed_Keybind.PlaceholderText = "Put \"Speed Up Keybind\" here"
Speed_Keybind.Text = ""
Speed_Keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
Speed_Keybind.TextScaled = true
Speed_Keybind.TextSize = 14.000
Speed_Keybind.TextWrapped = true

Enabled_Status.Name = "Enabled_Status"
Enabled_Status.Parent = Emotes_Frame
Enabled_Status.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Enabled_Status.BackgroundTransparency = 1.000
Enabled_Status.BorderColor3 = Color3.fromRGB(0, 0, 0)
Enabled_Status.BorderSizePixel = 0
Enabled_Status.Position = UDim2.new(0.0543478243, 0, 0.569667578, 0)
Enabled_Status.Size = UDim2.new(0, 330, 0, 59)
Enabled_Status.Font = Enum.Font.SourceSansBold
Enabled_Status.Text = ""
Enabled_Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Enabled_Status.TextScaled = true
Enabled_Status.TextSize = 14.000
Enabled_Status.TextWrapped = true

Normal_Keybind.Name = "Normal_Keybind"
Normal_Keybind.Parent = Emotes_Frame
Normal_Keybind.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Normal_Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
Normal_Keybind.BorderSizePixel = 0
Normal_Keybind.Position = UDim2.new(0.0326086953, 0, 0.477716774, 0)
Normal_Keybind.Size = UDim2.new(0, 347, 0, 37)
Normal_Keybind.Font = Enum.Font.SourceSansBold
Normal_Keybind.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Normal_Keybind.PlaceholderText = "Put \"Normal Speed Keybind\" here"
Normal_Keybind.Text = ""
Normal_Keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
Normal_Keybind.TextScaled = true
Normal_Keybind.TextSize = 14.000
Normal_Keybind.TextWrapped = true

Close.Name = "Close"
Close.Parent = Emotes_Frame
Close.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.896739125, 0, 0, 0)
Close.Size = UDim2.new(0, 38, 0, 32)
Close.Font = Enum.Font.SourceSansBold
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextScaled = true
Close.TextSize = 14.000
Close.TextWrapped = true

Alternate_Title.Name = "Alternate_Title"
Alternate_Title.Parent = Emotes_Frame
Alternate_Title.Active = true
Alternate_Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Alternate_Title.BackgroundTransparency = 1.000
Alternate_Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Alternate_Title.BorderSizePixel = 0
Alternate_Title.Position = UDim2.new(0.048913043, 0, 0.0625, 0)
Alternate_Title.Size = UDim2.new(0, 332, 0, 29)
Alternate_Title.Font = Enum.Font.SourceSansBold
Alternate_Title.Text = ""
Alternate_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Alternate_Title.TextScaled = true
Alternate_Title.TextSize = 14.000
Alternate_Title.TextWrapped = true

Settings_Menu.Name = "Settings_Menu"
Settings_Menu.Parent = Emotes_Frame
Settings_Menu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Settings_Menu.BackgroundTransparency = 1.000
Settings_Menu.BorderColor3 = Color3.fromRGB(0, 0, 0)
Settings_Menu.BorderSizePixel = 0
Settings_Menu.Position = UDim2.new(0.228260875, 0, 0.737335861, 0)
Settings_Menu.Size = UDim2.new(0, 200, 0, 52)
Settings_Menu.Font = Enum.Font.SourceSans
Settings_Menu.TextColor3 = Color3.fromRGB(0, 0, 0)
Settings_Menu.TextSize = 14.000

Settings_Roundify_12px.Name = "Settings_Roundify_12px"
Settings_Roundify_12px.Parent = Settings_Menu
Settings_Roundify_12px.Active = true
Settings_Roundify_12px.AnchorPoint = Vector2.new(0.5, 0.5)
Settings_Roundify_12px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Settings_Roundify_12px.BackgroundTransparency = 1.000
Settings_Roundify_12px.BorderColor3 = Color3.fromRGB(27, 42, 53)
Settings_Roundify_12px.Position = UDim2.new(0.499999821, 0, 0.515448928, 0)
Settings_Roundify_12px.Selectable = true
Settings_Roundify_12px.Size = UDim2.new(1.00000024, 0, 0.961289644, 0)
Settings_Roundify_12px.Image = "rbxassetid://3570695787"
Settings_Roundify_12px.ImageColor3 = Color3.fromRGB(0, 0, 0)
Settings_Roundify_12px.ScaleType = Enum.ScaleType.Slice
Settings_Roundify_12px.SliceCenter = Rect.new(100, 100, 100, 100)
Settings_Roundify_12px.SliceScale = 0.120

Button_Text.Name = "Button_Text"
Button_Text.Parent = Settings_Roundify_12px
Button_Text.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button_Text.BackgroundTransparency = 1.000
Button_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Button_Text.BorderSizePixel = 0
Button_Text.Position = UDim2.new(-0.113030978, 0, -0.103583932, 0)
Button_Text.Size = UDim2.new(0, 244, 0, 58)
Button_Text.Font = Enum.Font.SourceSansBold
Button_Text.Text = "Settings"
Button_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Button_Text.TextScaled = true
Button_Text.TextSize = 14.000
Button_Text.TextWrapped = true

TextLabel.Parent = Emotes_Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.0570652187, 0, 0.875355422, 0)
TextLabel.Size = UDim2.new(0, 329, 0, 38)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "Access Keybind Settings, Change Emote ID's, etc"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

Toggle_GUI.Name = "Toggle_GUI"
Toggle_GUI.Parent = EmotesConfiguration
Toggle_GUI.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Toggle_GUI.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_GUI.BorderSizePixel = 0
Toggle_GUI.Position = UDim2.new(0, 0, 0.616834164, 0)
Toggle_GUI.Size = UDim2.new(0, 200, 0, 50)
Toggle_GUI.Font = Enum.Font.SourceSansBold
Toggle_GUI.Text = "Open Emotes Config"
Toggle_GUI.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle_GUI.TextScaled = true
Toggle_GUI.TextSize = 14.000
Toggle_GUI.TextWrapped = true

Settings_Frame.Name = "Settings_Frame"
Settings_Frame.Parent = EmotesConfiguration
Settings_Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Settings_Frame.BackgroundTransparency = 1.000
Settings_Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
Settings_Frame.Position = UDim2.new(0.486146092, 0, 0.316582918, 0)
Settings_Frame.Size = UDim2.new(0, 642, 0, 356)
Settings_Frame.Image = "rbxassetid://3570695787"
Settings_Frame.ImageColor3 = Color3.fromRGB(30, 30, 30)
Settings_Frame.ScaleType = Enum.ScaleType.Slice
Settings_Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Settings_Frame.SliceScale = 0.120

Emote_1.Name = "Emote_1"
Emote_1.Parent = Settings_Frame
Emote_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Emote_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
Emote_1.BorderSizePixel = 0
Emote_1.Position = UDim2.new(0.0804347843, 0, 0.0224719103, 0)
Emote_1.Size = UDim2.new(0, 157, 0, 31)
Emote_1.ClearTextOnFocus = false
Emote_1.Font = Enum.Font.SourceSansBold
Emote_1.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Emote_1.PlaceholderText = "Emote ID"
Emote_1.Text = ""
Emote_1.TextColor3 = Color3.fromRGB(255, 255, 255)
Emote_1.TextScaled = true
Emote_1.TextSize = 14.000
Emote_1.TextWrapped = true

Emote_3.Name = "Emote_3"
Emote_3.Parent = Settings_Frame
Emote_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Emote_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Emote_3.BorderSizePixel = 0
Emote_3.Position = UDim2.new(0.0804347843, 0, 0.233146071, 0)
Emote_3.Size = UDim2.new(0, 157, 0, 31)
Emote_3.ClearTextOnFocus = false
Emote_3.Font = Enum.Font.SourceSansBold
Emote_3.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Emote_3.PlaceholderText = "Emote ID"
Emote_3.Text = ""
Emote_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Emote_3.TextScaled = true
Emote_3.TextSize = 14.000
Emote_3.TextWrapped = true

Emote_2.Name = "Emote_2"
Emote_2.Parent = Settings_Frame
Emote_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Emote_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Emote_2.BorderSizePixel = 0
Emote_2.Position = UDim2.new(0.0804347843, 0, 0.129213482, 0)
Emote_2.Size = UDim2.new(0, 157, 0, 31)
Emote_2.ClearTextOnFocus = false
Emote_2.Font = Enum.Font.SourceSansBold
Emote_2.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Emote_2.PlaceholderText = "Emote ID"
Emote_2.Text = ""
Emote_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Emote_2.TextScaled = true
Emote_2.TextSize = 14.000
Emote_2.TextWrapped = true

Emote_4.Name = "Emote_4"
Emote_4.Parent = Settings_Frame
Emote_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Emote_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Emote_4.BorderSizePixel = 0
Emote_4.Position = UDim2.new(0.0804347843, 0, 0.337078661, 0)
Emote_4.Size = UDim2.new(0, 157, 0, 31)
Emote_4.ClearTextOnFocus = false
Emote_4.Font = Enum.Font.SourceSansBold
Emote_4.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Emote_4.PlaceholderText = "Emote ID"
Emote_4.Text = ""
Emote_4.TextColor3 = Color3.fromRGB(255, 255, 255)
Emote_4.TextScaled = true
Emote_4.TextSize = 14.000
Emote_4.TextWrapped = true

Emote_5.Name = "Emote_5"
Emote_5.Parent = Settings_Frame
Emote_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Emote_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
Emote_5.BorderSizePixel = 0
Emote_5.Position = UDim2.new(0.0804347843, 0, 0.44101125, 0)
Emote_5.Size = UDim2.new(0, 157, 0, 31)
Emote_5.ClearTextOnFocus = false
Emote_5.Font = Enum.Font.SourceSansBold
Emote_5.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Emote_5.PlaceholderText = "Emote ID"
Emote_5.Text = ""
Emote_5.TextColor3 = Color3.fromRGB(255, 255, 255)
Emote_5.TextScaled = true
Emote_5.TextSize = 14.000
Emote_5.TextWrapped = true

Emote_6.Name = "Emote_6"
Emote_6.Parent = Settings_Frame
Emote_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Emote_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
Emote_6.BorderSizePixel = 0
Emote_6.Position = UDim2.new(0.0804347843, 0, 0.547752798, 0)
Emote_6.Size = UDim2.new(0, 157, 0, 31)
Emote_6.ClearTextOnFocus = false
Emote_6.Font = Enum.Font.SourceSansBold
Emote_6.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Emote_6.PlaceholderText = "Emote ID"
Emote_6.Text = ""
Emote_6.TextColor3 = Color3.fromRGB(255, 255, 255)
Emote_6.TextScaled = true
Emote_6.TextSize = 14.000
Emote_6.TextWrapped = true

Emote_7.Name = "Emote_7"
Emote_7.Parent = Settings_Frame
Emote_7.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Emote_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
Emote_7.BorderSizePixel = 0
Emote_7.Position = UDim2.new(0.0804347843, 0, 0.660112381, 0)
Emote_7.Size = UDim2.new(0, 157, 0, 31)
Emote_7.ClearTextOnFocus = false
Emote_7.Font = Enum.Font.SourceSansBold
Emote_7.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Emote_7.PlaceholderText = "Emote ID"
Emote_7.Text = ""
Emote_7.TextColor3 = Color3.fromRGB(255, 255, 255)
Emote_7.TextScaled = true
Emote_7.TextSize = 14.000
Emote_7.TextWrapped = true

Emote_8.Name = "Emote_8"
Emote_8.Parent = Settings_Frame
Emote_8.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Emote_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
Emote_8.BorderSizePixel = 0
Emote_8.Position = UDim2.new(0.0804347843, 0, 0.772471905, 0)
Emote_8.Size = UDim2.new(0, 157, 0, 31)
Emote_8.ClearTextOnFocus = false
Emote_8.Font = Enum.Font.SourceSansBold
Emote_8.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Emote_8.PlaceholderText = "Emote ID"
Emote_8.Text = ""
Emote_8.TextColor3 = Color3.fromRGB(255, 255, 255)
Emote_8.TextScaled = true
Emote_8.TextSize = 14.000
Emote_8.TextWrapped = true

Emote_9.Name = "Emote_9"
Emote_9.Parent = Settings_Frame
Emote_9.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Emote_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
Emote_9.BorderSizePixel = 0
Emote_9.Position = UDim2.new(0.0804347843, 0, 0.8820225, 0)
Emote_9.Size = UDim2.new(0, 157, 0, 31)
Emote_9.ClearTextOnFocus = false
Emote_9.Font = Enum.Font.SourceSansBold
Emote_9.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Emote_9.PlaceholderText = "Emote ID"
Emote_9.Text = ""
Emote_9.TextColor3 = Color3.fromRGB(255, 255, 255)
Emote_9.TextScaled = true
Emote_9.TextSize = 14.000
Emote_9.TextWrapped = true

Close_2.Name = "Close"
Close_2.Parent = Settings_Frame
Close_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Close_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Close_2.BorderSizePixel = 0
Close_2.Position = UDim2.new(0.939668715, 0, 0, 0)
Close_2.Size = UDim2.new(0, 38, 0, 32)
Close_2.Font = Enum.Font.SourceSansBold
Close_2.Text = "X"
Close_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Close_2.TextScaled = true
Close_2.TextSize = 14.000
Close_2.TextWrapped = true

EmoteID_2.Name = "EmoteID_2"
EmoteID_2.Parent = Settings_Frame
EmoteID_2.BackgroundColor3 = Color3.fromRGB(26, 255, 0)
EmoteID_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_2.BorderSizePixel = 0
EmoteID_2.Position = UDim2.new(0.388175607, 0, 0.129213482, 0)
EmoteID_2.Size = UDim2.new(0, 174, 0, 31)
EmoteID_2.Font = Enum.Font.SourceSansBold
EmoteID_2.Text = "Update Emote \"2\" ID"
EmoteID_2.TextColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_2.TextScaled = true
EmoteID_2.TextSize = 14.000
EmoteID_2.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
EmoteID_2.TextWrapped = true

EmoteID_9.Name = "EmoteID_9"
EmoteID_9.Parent = Settings_Frame
EmoteID_9.BackgroundColor3 = Color3.fromRGB(26, 255, 0)
EmoteID_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_9.BorderSizePixel = 0
EmoteID_9.Position = UDim2.new(0.388175607, 0, 0.8820225, 0)
EmoteID_9.Size = UDim2.new(0, 174, 0, 31)
EmoteID_9.Font = Enum.Font.SourceSansBold
EmoteID_9.Text = "Update Emote \"9\" ID"
EmoteID_9.TextColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_9.TextScaled = true
EmoteID_9.TextSize = 14.000
EmoteID_9.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
EmoteID_9.TextWrapped = true

EmoteID_8.Name = "EmoteID_8"
EmoteID_8.Parent = Settings_Frame
EmoteID_8.BackgroundColor3 = Color3.fromRGB(26, 255, 0)
EmoteID_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_8.BorderSizePixel = 0
EmoteID_8.Position = UDim2.new(0.388175607, 0, 0.772471905, 0)
EmoteID_8.Size = UDim2.new(0, 174, 0, 31)
EmoteID_8.Font = Enum.Font.SourceSansBold
EmoteID_8.Text = "Update Emote \"8\" ID"
EmoteID_8.TextColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_8.TextScaled = true
EmoteID_8.TextSize = 14.000
EmoteID_8.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
EmoteID_8.TextWrapped = true

EmoteID_7.Name = "EmoteID_7"
EmoteID_7.Parent = Settings_Frame
EmoteID_7.BackgroundColor3 = Color3.fromRGB(26, 255, 0)
EmoteID_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_7.BorderSizePixel = 0
EmoteID_7.Position = UDim2.new(0.388175607, 0, 0.660112381, 0)
EmoteID_7.Size = UDim2.new(0, 174, 0, 31)
EmoteID_7.Font = Enum.Font.SourceSansBold
EmoteID_7.Text = "Update Emote \"7\" ID"
EmoteID_7.TextColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_7.TextScaled = true
EmoteID_7.TextSize = 14.000
EmoteID_7.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
EmoteID_7.TextWrapped = true

EmoteID_6.Name = "EmoteID_6"
EmoteID_6.Parent = Settings_Frame
EmoteID_6.BackgroundColor3 = Color3.fromRGB(26, 255, 0)
EmoteID_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_6.BorderSizePixel = 0
EmoteID_6.Position = UDim2.new(0.388175607, 0, 0.547752798, 0)
EmoteID_6.Size = UDim2.new(0, 174, 0, 31)
EmoteID_6.Font = Enum.Font.SourceSansBold
EmoteID_6.Text = "Update Emote \"6\" ID"
EmoteID_6.TextColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_6.TextScaled = true
EmoteID_6.TextSize = 14.000
EmoteID_6.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
EmoteID_6.TextWrapped = true

EmoteID_5.Name = "EmoteID_5"
EmoteID_5.Parent = Settings_Frame
EmoteID_5.BackgroundColor3 = Color3.fromRGB(26, 255, 0)
EmoteID_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_5.BorderSizePixel = 0
EmoteID_5.Position = UDim2.new(0.388175607, 0, 0.438202262, 0)
EmoteID_5.Size = UDim2.new(0, 174, 0, 31)
EmoteID_5.Font = Enum.Font.SourceSansBold
EmoteID_5.Text = "Update Emote \"5\" ID"
EmoteID_5.TextColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_5.TextScaled = true
EmoteID_5.TextSize = 14.000
EmoteID_5.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
EmoteID_5.TextWrapped = true

EmoteID_4.Name = "EmoteID_4"
EmoteID_4.Parent = Settings_Frame
EmoteID_4.BackgroundColor3 = Color3.fromRGB(26, 255, 0)
EmoteID_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_4.BorderSizePixel = 0
EmoteID_4.Position = UDim2.new(0.388175607, 0, 0.334269673, 0)
EmoteID_4.Size = UDim2.new(0, 174, 0, 31)
EmoteID_4.Font = Enum.Font.SourceSansBold
EmoteID_4.Text = "Update Emote \"4\" ID"
EmoteID_4.TextColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_4.TextScaled = true
EmoteID_4.TextSize = 14.000
EmoteID_4.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
EmoteID_4.TextWrapped = true

EmoteID_3.Name = "EmoteID_3"
EmoteID_3.Parent = Settings_Frame
EmoteID_3.BackgroundColor3 = Color3.fromRGB(26, 255, 0)
EmoteID_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_3.BorderSizePixel = 0
EmoteID_3.Position = UDim2.new(0.388175607, 0, 0.233146071, 0)
EmoteID_3.Size = UDim2.new(0, 174, 0, 31)
EmoteID_3.Font = Enum.Font.SourceSansBold
EmoteID_3.Text = "Update Emote \"3\" ID"
EmoteID_3.TextColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_3.TextScaled = true
EmoteID_3.TextSize = 14.000
EmoteID_3.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
EmoteID_3.TextWrapped = true

EmoteID_1.Name = "EmoteID_1"
EmoteID_1.Parent = Settings_Frame
EmoteID_1.BackgroundColor3 = Color3.fromRGB(26, 255, 0)
EmoteID_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_1.BorderSizePixel = 0
EmoteID_1.Position = UDim2.new(0.388175607, 0, 0.0224719103, 0)
EmoteID_1.Size = UDim2.new(0, 174, 0, 31)
EmoteID_1.Font = Enum.Font.SourceSansBold
EmoteID_1.Text = "Update Emote \"1\" ID"
EmoteID_1.TextColor3 = Color3.fromRGB(0, 0, 0)
EmoteID_1.TextScaled = true
EmoteID_1.TextSize = 14.000
EmoteID_1.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
EmoteID_1.TextWrapped = true

Load_Cfg.Name = "Load_Cfg"
Load_Cfg.Parent = Settings_Frame
Load_Cfg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Load_Cfg.BorderColor3 = Color3.fromRGB(0, 0, 0)
Load_Cfg.BorderSizePixel = 0
Load_Cfg.Position = UDim2.new(0.722741425, 0, 0.205528006, 0)
Load_Cfg.Size = UDim2.new(0, 146, 0, 36)
Load_Cfg.Font = Enum.Font.SourceSansBold
Load_Cfg.Text = "Load Config"
Load_Cfg.TextColor3 = Color3.fromRGB(255, 255, 0)
Load_Cfg.TextScaled = true
Load_Cfg.TextSize = 14.000
Load_Cfg.TextWrapped = true

Save_Cfg.Name = "Save_Cfg"
Save_Cfg.Parent = Settings_Frame
Save_Cfg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Save_Cfg.BorderColor3 = Color3.fromRGB(0, 0, 0)
Save_Cfg.BorderSizePixel = 0
Save_Cfg.Position = UDim2.new(0.722741425, 0, 0.433056086, 0)
Save_Cfg.Size = UDim2.new(0, 146, 0, 36)
Save_Cfg.Font = Enum.Font.SourceSansBold
Save_Cfg.Text = "Save Config"
Save_Cfg.TextColor3 = Color3.fromRGB(0, 255, 0)
Save_Cfg.TextScaled = true
Save_Cfg.TextSize = 14.000
Save_Cfg.TextWrapped = true

Del_Cfg.Name = "Del_Cfg"
Del_Cfg.Parent = Settings_Frame
Del_Cfg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Del_Cfg.BorderColor3 = Color3.fromRGB(0, 0, 0)
Del_Cfg.BorderSizePixel = 0
Del_Cfg.Position = UDim2.new(0.722741425, 0, 0.669011176, 0)
Del_Cfg.Size = UDim2.new(0, 146, 0, 36)
Del_Cfg.Font = Enum.Font.SourceSansBold
Del_Cfg.Text = "Delete Config"
Del_Cfg.TextColor3 = Color3.fromRGB(255, 0, 0)
Del_Cfg.TextScaled = true
Del_Cfg.TextSize = 14.000
Del_Cfg.TextWrapped = true

local function DOAHXLG_fake_script() 
	local script = Instance.new('LocalScript', Speed_Up_Speed)

	local textBox = script.Parent
	
	textBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			if tonumber(textBox.Text) then
				local inputted_num = tonumber(textBox.Text)
				
				getgenv().speedUpSpeed = inputted_num
			end
		end
	end)
end
coroutine.wrap(DOAHXLG_fake_script)()
local function VLPBLII_fake_script() 
	local script = Instance.new('LocalScript', Slow_Down_Speed)

	local textBox = script.Parent
	
	textBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			if tonumber(textBox.Text) then
				local inputted_num = tonumber(textBox.Text)
	
				getgenv().slowDownSpeed = inputted_num
			end
		end
	end)
end
coroutine.wrap(VLPBLII_fake_script)()
local function SKIYRB_fake_script() 
	local script = Instance.new('LocalScript', Freeze_Keybind)

	local textBox = script.Parent
	
	textBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local inputText = string.upper(textBox.Text)
			local newKeyEnum = Enum.KeyCode[inputText]
	
			if newKeyEnum then
				local function getKeyForAction(action)
					for key, value in pairs(getgenv().keybindActions) do
						if value == action then
							return key
						end
					end
					return nil
				end
	
				local freezeKey = getKeyForAction("Freeze")
				if freezeKey then
					getgenv().keybindActions[newKeyEnum] = getgenv().keybindActions[freezeKey]
					getgenv().keybindActions[freezeKey] = nil
					textBox.Text = ""
				else
					return getgenv().notify("Failed!", "Keybind 'Freeze' was not found, or does not exist", 7)
				end
			else
				textBox.Text = ""
				return getgenv().notify("Failed!", "Invalid Keybind entered: "..tostring(inputText), 7)
			end
		end
	end)
end
coroutine.wrap(SKIYRB_fake_script)()
local function GLBPIYO_fake_script() 
	local script = Instance.new('LocalScript', Speed_Keybind)

	local textBox = script.Parent
	
	textBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local inputText = string.upper(textBox.Text)
			local newKeyEnum = Enum.KeyCode[inputText]
	
			if newKeyEnum then
				local function getKeyForAction(action)
					for key, value in pairs(getgenv().keybindActions) do
						if value == action then
							return key
						end
					end
					return nil
				end
	
				local freezeKey = getKeyForAction("SpeedUp")
				if freezeKey then
					getgenv().keybindActions[newKeyEnum] = getgenv().keybindActions[freezeKey]
					getgenv().keybindActions[freezeKey] = nil
					textBox.Text = ""
				else
					return getgenv().notify("Failed!", "Keybind 'Freeze' was not found, or does not exist", 7)
				end
			else
				textBox.Text = ""
				return getgenv().notify("Failed!", "Invalid Keybind entered: "..tostring(inputText), 7)
			end
		end
	end)
end
coroutine.wrap(GLBPIYO_fake_script)()
local function YOVBD_fake_script() 
	local script = Instance.new('LocalScript', Enabled_Status)

	getgenv().watch_dog_status = true
	while getgenv().watch_dog_status == true do
		wait(0.5)
		if getgenv().scriptEnabled or getgenv().scriptEnabled == true then
			script.Parent.TextColor3 = Color3.fromRGB(34, 255, 0)
			script.Parent.Text = "Status: Enabled ✅"
		elseif getgenv().scriptEnabled == false then
			script.Parent.TextColor3 = Color3.fromRGB(255, 0, 0)
			script.Parent.Text = "Status: Disabled ❌"
		else
			script.Parent.TextColor3 = Color3.fromRGB(255, 170, 0)
			script.Parent.Text = "Status: Unknown ❓"
		end
	end
end
coroutine.wrap(YOVBD_fake_script)()
local function ZOBVLZ_fake_script() 
	local script = Instance.new('LocalScript', Normal_Keybind)

	local textBox = script.Parent
	
	textBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local inputText = string.upper(textBox.Text)
			local newKeyEnum = Enum.KeyCode[inputText]
	
			if newKeyEnum then
				local function getKeyForAction(action)
					for key, value in pairs(getgenv().keybindActions) do
						if value == action then
							return key
						end
					end
					return nil
				end
	
				local freezeKey = getKeyForAction("NormalSpeed")
				if freezeKey then
					getgenv().keybindActions[newKeyEnum] = getgenv().keybindActions[freezeKey]
					getgenv().keybindActions[freezeKey] = nil
					textBox.Text = ""
				else
					return getgenv().notify("Failed!", "Keybind 'Freeze' was not found, or does not exist", 7)
				end
			else
				textBox.Text = ""
				return getgenv().notify("Failed!", "Invalid Keybind entered: "..tostring(inputText), 7)
			end
		end
	end)
end
coroutine.wrap(ZOBVLZ_fake_script)()
local function WUGOP_fake_script() 
	local script = Instance.new('LocalScript', Close)

	script.Parent.MouseButton1Click:Connect(function()
		local settings_GUI = script.Parent.Parent.Parent:FindFirstChild("Settings_Frame")
		script.Parent.Parent.Visible = false
		wait(0.2)
		if settings_GUI.Visible or settings_GUI.Visible == true then
			settings_GUI.Visible = false
		end
	end)
end
coroutine.wrap(WUGOP_fake_script)()
local function JROQEP_fake_script() 
	local script = Instance.new('LocalScript', Emotes_Frame)

	local UIS = game:GetService('UserInputService')
	local frame = script.Parent
	local dragToggle = nil
	local dragSpeed = 0.25
	local dragStart = nil
	local startPos = nil
	
	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
	end
	
	frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	
	UIS.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end)
end
coroutine.wrap(JROQEP_fake_script)()
local function RJIF_fake_script() 
	local script = Instance.new('LocalScript', Emotes_Frame)

	local Main_Frame = script.Parent
	local Button = script.Parent.Parent:FindFirstChild("Toggle_GUI")
	
	Main_Frame:GetPropertyChangedSignal("Visible"):Connect(function()
		if Main_Frame.Visible or Main_Frame.Visible == true then
			Button.Text = "Close Emotes Config"
		elseif not Main_Frame.Visible or Main_Frame.Visible == false then
			Button.Text = "Open Emotes Config"
		else
			Button.Text = "Unknown"
		end
	end)
end
coroutine.wrap(RJIF_fake_script)()
local function OJUDNOL_fake_script() 
	local script = Instance.new('LocalScript', Alternate_Title)

	local label = script.Parent
	local TweenService = game:GetService("TweenService")
	
	getgenv().textTable = {
		"Changes Configuration For Emotes",
		"Configure Your Keybinds",
		"Adjust Animation Speeds",
		"Freeze and Reverse Emotes",
		"Zacks Easy Hub - Emotes."
	}
	
	getgenv().watcher_changer = true
	
	local function typingEffect(label, text, typingSpeed)
		for i = 1, #text do
			if not getgenv().watcher_changer or getgenv().watcher_changer == false then
				getgenv().watcher_changer = false
				break
			end
			label.Text = string.sub(text, 1, i)
			wait(typingSpeed)
		end
	end
	
	local function tweenTransparency(label, targetTransparency, duration)
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
		local tween = TweenService:Create(label, tweenInfo, {TextTransparency = targetTransparency})
		tween:Play()
		tween.Completed:Wait()
	end
	
	while getgenv().watcher_changer do
		for _, text in ipairs(getgenv().textTable) do
			if not getgenv().watcher_changer or getgenv().watcher_changer == false then
				getgenv().watcher_changer = false
				break
			end
			tweenTransparency(label, 1, 0.5)
			wait(0.2)
			typingEffect(label, text, 0.1)
			wait(0.1)
			tweenTransparency(label, 0, 0.5)
			wait(1.5)
		end
	end
end
coroutine.wrap(OJUDNOL_fake_script)()
local function QSOGUZO_fake_script() 
	local script = Instance.new('LocalScript', Settings_Menu)

	script.Parent.MouseButton1Click:Connect(function()
		local Frame_Vis = script.Parent.Parent.Parent:FindFirstChild("Settings_Frame")
		
		Frame_Vis.Visible = not Frame_Vis.Visible
	end)
end
coroutine.wrap(QSOGUZO_fake_script)()
local function HCQYDY_fake_script() 
	local script = Instance.new('LocalScript', Toggle_GUI)

	script.Parent.MouseButton1Click:Connect(function()
		local Frame = script.Parent.Parent:FindFirstChild("Emotes_Frame")
		local Settings_Frame = script.Parent.Parent:FindFirstChild("Settings_Frame")
		
		Frame.Visible = not Frame.Visible
		wait()
		if Settings_Frame.Visible or Settings_Frame.Visible == true then
			Settings_Frame.Visible = false
		end
	end)
end
coroutine.wrap(HCQYDY_fake_script)()
local function TZJEYD_fake_script() 
	local script = Instance.new('LocalScript', Close_2)

	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Visible = false
	end)
end
coroutine.wrap(TZJEYD_fake_script)()
local function AGMPVKP_fake_script() 
	local script = Instance.new('LocalScript', EmoteID_2)

	local TextBox = script.Parent.Parent:FindFirstChild("Emote_2")
	local selectedKeyCode = Enum.KeyCode.Two
	
	local function processInput(inputText)
		local emoteID = tonumber(inputText)
		if emoteID then
			getgenv().keybindActions[selectedKeyCode] = emoteID
		else
			getgenv().notify("Failed!", "Please enter a valid number emote ID.", 7)
		end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		processInput(TextBox.Text)
		TextBox.Text = ""
	end)
end
coroutine.wrap(AGMPVKP_fake_script)()
local function RRGT_fake_script() 
	local script = Instance.new('LocalScript', EmoteID_9)

	local TextBox = script.Parent.Parent:FindFirstChild("Emote_9")
	local selectedKeyCode = Enum.KeyCode.Nine
	
	local function processInput(inputText)
		local emoteID = tonumber(inputText)
		if emoteID then
			getgenv().keybindActions[selectedKeyCode] = emoteID
		else
			getgenv().notify("Failed!", "Please enter a valid number emote ID.", 7)
		end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		processInput(TextBox.Text)
		TextBox.Text = ""
	end)
end
coroutine.wrap(RRGT_fake_script)()
local function QPMMUDN_fake_script() 
	local script = Instance.new('LocalScript', EmoteID_8)

	local TextBox = script.Parent.Parent:FindFirstChild("Emote_8")
	local selectedKeyCode = Enum.KeyCode.Eight
	
	local function processInput(inputText)
		local emoteID = tonumber(inputText)
		if emoteID then
			getgenv().keybindActions[selectedKeyCode] = emoteID
		else
			getgenv().notify("Failed!", "Please enter a valid number emote ID.", 7)
		end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		processInput(TextBox.Text)
		TextBox.Text = ""
	end)
end
coroutine.wrap(QPMMUDN_fake_script)()
local function ZYIK_fake_script() 
	local script = Instance.new('LocalScript', EmoteID_7)

	local TextBox = script.Parent.Parent:FindFirstChild("Emote_7")
	local selectedKeyCode = Enum.KeyCode.Seven
	
	local function processInput(inputText)
		local emoteID = tonumber(inputText)
		if emoteID then
			getgenv().keybindActions[selectedKeyCode] = emoteID
		else
			getgenv().notify("Failed!", "Please enter a valid number emote ID.", 7)
		end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		processInput(TextBox.Text)
		TextBox.Text = ""
	end)
end
coroutine.wrap(ZYIK_fake_script)()
local function LZQGC_fake_script() 
	local script = Instance.new('LocalScript', EmoteID_6)

	local TextBox = script.Parent.Parent:FindFirstChild("Emote_6")
	local selectedKeyCode = Enum.KeyCode.Six
	
	local function processInput(inputText)
		local emoteID = tonumber(inputText)
		if emoteID then
			getgenv().keybindActions[selectedKeyCode] = emoteID
		else
			getgenv().notify("Failed!", "Please enter a valid number emote ID.", 7)
		end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		processInput(TextBox.Text)
		TextBox.Text = ""
	end)
end
coroutine.wrap(LZQGC_fake_script)()
local function PGSDSL_fake_script() 
	local script = Instance.new('LocalScript', EmoteID_5)

	local TextBox = script.Parent.Parent:FindFirstChild("Emote_5")
	local selectedKeyCode = Enum.KeyCode.Five
	
	local function processInput(inputText)
		local emoteID = tonumber(inputText)
		if emoteID then
			getgenv().keybindActions[selectedKeyCode] = emoteID
		else
			getgenv().notify("Failed!", "Please enter a valid number emote ID.", 7)
		end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		processInput(TextBox.Text)
		TextBox.Text = ""
	end)
end
coroutine.wrap(PGSDSL_fake_script)()
local function VIALO_fake_script() 
	local script = Instance.new('LocalScript', EmoteID_4)

	local TextBox = script.Parent.Parent:FindFirstChild("Emote_4")
	local selectedKeyCode = Enum.KeyCode.Four
	
	local function processInput(inputText)
		local emoteID = tonumber(inputText)
		if emoteID then
			getgenv().keybindActions[selectedKeyCode] = emoteID
		else
			getgenv().notify("Failed!", "Please enter a valid number emote ID.", 7)
		end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		processInput(TextBox.Text)
		TextBox.Text = ""
	end)
end
coroutine.wrap(VIALO_fake_script)()
local function FSZEYQH_fake_script() 
	local script = Instance.new('LocalScript', EmoteID_3)

	local TextBox = script.Parent.Parent:FindFirstChild("Emote_3")
	local selectedKeyCode = Enum.KeyCode.Three
	
	local function processInput(inputText)
		local emoteID = tonumber(inputText)
		if emoteID then
			getgenv().keybindActions[selectedKeyCode] = emoteID
		else
			getgenv().notify("Failed!", "Please enter a valid number emote ID.", 7)
		end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		processInput(TextBox.Text)
		TextBox.Text = ""
	end)
end
coroutine.wrap(FSZEYQH_fake_script)()
local function TIPLWKP_fake_script() 
	local script = Instance.new('LocalScript', EmoteID_1)

	local TextBox = script.Parent.Parent:FindFirstChild("Emote_1")
	local selectedKeyCode = Enum.KeyCode.One
	
	local function processInput(inputText)
		local emoteID = tonumber(inputText)
		if emoteID then
			getgenv().keybindActions[selectedKeyCode] = emoteID
		else
			getgenv().notify("Failed!", "Please enter a valid number emote ID.", 7)
		end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		processInput(TextBox.Text)
		TextBox.Text = ""
	end)
end
coroutine.wrap(TIPLWKP_fake_script)()
local function UCINRE_fake_script() 
	local script = Instance.new('LocalScript', Settings_Frame)

	local UIS = game:GetService('UserInputService')
	local frame = script.Parent
	local dragToggle = nil
	local dragSpeed = 0.25
	local dragStart = nil
	local startPos = nil
	
	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
	end
	
	frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	
	UIS.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end)
end
coroutine.wrap(UCINRE_fake_script)()
local function WKALQI_fake_script() 
	local script = Instance.new('LocalScript', Load_Cfg)

	script.Parent.MouseButton1Click:Connect(function()
		if not writefile or readfile then return end
		
		local function Load_Config()
			local TextBoxParent = script.Parent.Parent
			local ConfigFileName = "EmoteConfig.json"
			local HttpService = game:GetService("HttpService")
			
			if not isfile(ConfigFileName) then
				warn("Configuration file not found!")
				return
			end
	
			local json = readfile(ConfigFileName)
			local config = HttpService:JSONDecode(json)
	
			for _, entry in ipairs(config) do
				local keyCode = Enum.KeyCode[entry.Key]
				if keyCode then
					getgenv().keybindActions[keyCode] = entry.EmoteID
				end
			end
			
			getgenv().notify("Success!", "Loaded Configuration File!", 7)
		end
	
		local function populateTextBoxes()
			local TextBoxParent = script.Parent.Parent
			for keyCode, emoteID in pairs(getgenv().keybindActions) do
				local textBox = TextBoxParent:FindFirstChild(tostring(keyCode.Name))
				if textBox and textBox:IsA("TextBox") then
					textBox.Text = tostring(emoteID)
				end
			end
		end
	
		local function updateKeybindsFromTextBoxes()
			for _, textBox in ipairs(script.Parent.Parent:GetChildren()) do
				if textBox:IsA("TextBox") then
					local keyCode = Enum.KeyCode[textBox.Name]
					if keyCode and tonumber(textBox.Text) then
						getgenv().keybindActions[keyCode] = tonumber(textBox.Text)
					end
				end
			end
		end
		
		Load_Config()
	end)
end
coroutine.wrap(WKALQI_fake_script)()
local function JRMAQZ_fake_script() 
	local script = Instance.new('LocalScript', Save_Cfg)

	script.Parent.MouseButton1Click:Connect(function()
		if not writefile or readfile then return end
		local HttpService = game:GetService("HttpService")
		local ConfigFileName = "EmoteConfig.json"
	
		getgenv().keybindActions = getgenv().keybindActions or {}
	
		local function Save_Config()
			local config = {}
			for keyCode, emoteID in pairs(getgenv().keybindActions) do
				table.insert(config, { Key = tostring(keyCode), EmoteID = emoteID })
			end
	
			local json = HttpService:JSONEncode(config)
			writefile(ConfigFileName, json)
			
			getgenv().notify("Success!", "Saved Configuration File!", 7)
		end
		
		Save_Config()
	end)
end
coroutine.wrap(JRMAQZ_fake_script)()
local function OZWQWOC_fake_script() 
	local script = Instance.new('LocalScript', Del_Cfg)

	script.Parent.MouseButton1Click:Connect(function()
		local function Delete_Config()
			local TextBoxParent = script.Parent.Parent
			local ConfigFileName = "EmoteConfig.json"
			local HttpService = game:GetService("HttpService")
	
			if not isfile(ConfigFileName) then
				getgenv().notify("Failed!", "Configuration file not found!", 7)
				return
			end
	
			local json = readfile(ConfigFileName)
			local config = HttpService:JSONDecode(json)
			
			delfile(ConfigFileName)
			wait(0.1)
			getgenv().notify("Success!", "Deleted Configuration File!", 7)
		end
		
		Delete_Config()
	end)
end
coroutine.wrap(OZWQWOC_fake_script)()
