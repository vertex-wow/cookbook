-- HARNESS: Not part of the recipe. Registers /ev3 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

SLASH_EXAMPLEFRAMETOOLTIP1 = "/ev3"
SlashCmdList["EXAMPLEFRAMETOOLTIP"] = function()
    local f = ExampleFrameTooltip
    if f:IsShown() then
        f:Hide()
    else
        f:Show()
    end
end
