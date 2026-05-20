-- HARNESS: Not part of the recipe. Registers /ev1 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

SLASH_EXAMPLEFRAMEBARE1 = "/ev1"
SlashCmdList["EXAMPLEFRAMEBARE"] = function()
    local f = ExampleFrameBare
    if f:IsShown() then
        f:Hide()
    else
        f:Show()
    end
end
