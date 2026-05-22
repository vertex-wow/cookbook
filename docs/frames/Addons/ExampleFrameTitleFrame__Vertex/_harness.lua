-- HARNESS: Not part of the recipe. Registers /ev5 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleFrameTitleFrame = ExampleFrameTitleFrame

-- QoL (harness only): makes the frame draggable and adds a close button so you
-- can tile demos side-by-side and dismiss them without the slash command.
-- Neither is part of the recipe — remove these lines along with the harness.
ExampleFrameTitleFrame:SetMovable(true)
ExampleFrameTitleFrame:RegisterForDrag("LeftButton")
ExampleFrameTitleFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
ExampleFrameTitleFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
CreateFrame("Button", nil, ExampleFrameTitleFrame, "UIPanelCloseButtonDefaultAnchors")

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
