local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/apple_more.lua"))()
local window = library:init("Apple UI Test", true, Enum.KeyCode.RightShift, true)

window:Divider("Core Elements")

local sectionA = window:Section("Basic Elements")

sectionA:Divider("Inputs & Controls")

sectionA:Button("Click me!", function()
    print("Button clicked.")
end)

sectionA:Label("This is a label element.")

sectionA:Switch("Toggle me!", false, function(state)
    print("Switch is now:", state)
end)

sectionA:TextField("Enter text here!", "Type something...", function(text)
    print("Text submitted:", text)
end)

sectionA:Slider("Volume", 0, 100, 50, function(value)
    print("Slider value:", value)
end)

sectionA:Dropdown("Choose an option", {"Option A", "Option B", "Option C", "Option D"}, "Option A", function(selected)
    print("Dropdown selected:", selected)
end)

sectionA:ColorPicker("Pick a color", Color3.fromRGB(21, 103, 251), function(color)
    print("Color picked:", color)
end)

window:Divider("Notifications")

local sectionB = window:Section("Notifications")

sectionB:Divider("Notification Types")

sectionB:Button("Temporary Notification", function()
    window:TempNotify("Heads up!", "This notification disappears on its own.", "rbxassetid://12608259004")
end)

sectionB:Button("Single Button Notification", function()
    window:Notify("Notice", "This is a single button notification.", "Got it", "rbxassetid://12608259004", function()
        print("Notification 1 confirmed.")
    end)
end)

sectionB:Button("Two Button Notification", function()
    window:Notify2("Choose", "This notification has two options.", "Accept", "Decline", "rbxassetid://12608259004", function()
        print("Accepted.")
    end, function()
        print("Declined.")
    end)
end)

window:Divider("Miscellaneous")

local sectionC = window:Section("Misc")

sectionC:Divider("Extra")

sectionC:Label("Green button = the green dot, top-left of the window.")

sectionC:Button("Print all done!", function()
    print("All elements tested successfully.")
end)

window:GreenButton(function()
    print("Green button clicked!")
end)

sectionA:Select()
