-- HARNESS: Not part of the recipe. Registers /ev5 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleFrameTitleFrame = ExampleFrameTitleFrame

SLASH_EXAMPLEFRAMETITLEFRAME1 = "/ev5"
SlashCmdList["EXAMPLEFRAMETITLEFRAME"] = function()
    local f = ExampleFrameTitleFrame
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
