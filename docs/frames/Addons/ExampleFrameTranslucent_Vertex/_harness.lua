-- HARNESS: Not part of the recipe. Registers /ev2 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

SLASH_EXAMPLEFRAMETRANSLUCENT1 = "/ev2"
SlashCmdList["EXAMPLEFRAMETRANSLUCENT"] = function()
    local f = ExampleFrameTranslucent
    if f:IsShown() then
        f:Hide()
    else
        f:Show()
    end
end
