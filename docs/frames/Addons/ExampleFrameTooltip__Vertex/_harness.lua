-- HARNESS: Not part of the recipe. Registers /ev3 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleFrameTooltip = ExampleFrameTooltip

-- QoL (harness only): makes the frame draggable and adds a close button so you
-- can tile demos side-by-side and dismiss them without the slash command.
-- Neither is part of the recipe — remove these lines along with the harness.
ExampleFrameTooltip:SetMovable(true)
ExampleFrameTooltip:RegisterForDrag("LeftButton")
ExampleFrameTooltip:SetScript("OnDragStart", function(self) self:StartMoving() end)
ExampleFrameTooltip:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
CreateFrame("Button", nil, ExampleFrameTooltip, "UIPanelCloseButtonDefaultAnchors")

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
