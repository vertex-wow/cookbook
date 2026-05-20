-- HARNESS: Not part of the recipe. Registers /ev2 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

SLASH_EXAMPLEFRAMETRANSPARENT1 = "/ev2"
SlashCmdList["EXAMPLEFRAMETRANSPARENT"] = function()
    local f = ExampleFrameTransparent
    if f:IsShown() then
        f:Hide()
    else
        f:Show()
    end
end
