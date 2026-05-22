-- HARNESS: Not part of the recipe. Registers /ev9 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleControlMoveableFrame = ExampleControlMoveableFrame

SLASH_EXAMPLECONTROLMOVEABLEFRAME1 = "/ev9"
SlashCmdList["EXAMPLECONTROLMOVEABLEFRAME"] = function()
    local f = ExampleControlMoveableFrame
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
