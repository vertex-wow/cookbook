-- HARNESS: Not part of the recipe. Registers /ev7 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleFrameModelPortrait = ExampleFrameModelPortrait

SLASH_EXAMPLEFRAMEMODELPORTRAIT1 = "/ev7"
SlashCmdList["EXAMPLEFRAMEMODELPORTRAIT"] = function()
    local f = ExampleFrameModelPortrait
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
