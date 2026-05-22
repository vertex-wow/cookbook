-- HARNESS: Not part of the recipe. Registers /ev9 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleControlMoveableFrame = ExampleControlMoveableFrame

-- QoL (harness only): adds a close button so you can dismiss without the slash command.
-- The recipe itself provides drag-to-move, so only the close button is added here.
-- Not part of the recipe — remove this line along with the harness.
CreateFrame("Button", nil, ExampleControlMoveableFrame, "UIPanelCloseButtonDefaultAnchors")

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
