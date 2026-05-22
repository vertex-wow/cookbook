-- HARNESS: Not part of the recipe. Registers /ev3 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleFrameTooltip = ExampleFrameTooltip

SLASH_EXAMPLEFRAMETOOLTIP1 = "/ev3"
SlashCmdList["EXAMPLEFRAMETOOLTIP"] = function()
    local f = ExampleFrameTooltip
    if f:IsShown() then
        f:Hide()
    else
        f:Show()
    end
end

SLASH_VERTEXEXAMPLESOFF1 = "/evoff"
SlashCmdList["VERTEXEXAMPLESOFF"] = function()
    for _, f in pairs(VertexExamples) do
        f:Hide()
    end
end
