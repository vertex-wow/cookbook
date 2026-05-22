-- HARNESS: Not part of the recipe. Registers /ev10 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleControlResizableFrame = ExampleControlResizableFrame

-- QoL (harness only): makes the frame draggable and adds a close button so you
-- can tile demos side-by-side and dismiss them without the slash command.
-- Neither is part of the recipe — remove these lines along with the harness.
ExampleControlResizableFrame:SetMovable(true)
ExampleControlResizableFrame:RegisterForDrag("LeftButton")
ExampleControlResizableFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
ExampleControlResizableFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
CreateFrame("Button", nil, ExampleControlResizableFrame, "UIPanelCloseButtonDefaultAnchors")

SLASH_EXAMPLECONTROLRESIZABLEFRAME1 = "/ev10"
SlashCmdList["EXAMPLECONTROLRESIZABLEFRAME"] = function()
    local f = ExampleControlResizableFrame
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
