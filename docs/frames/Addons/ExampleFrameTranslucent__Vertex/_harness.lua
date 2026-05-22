-- HARNESS: Not part of the recipe. Registers /ev2 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleFrameTranslucent = ExampleFrameTranslucent

-- QoL (harness only): makes the frame draggable and adds a close button so you
-- can tile demos side-by-side and dismiss them without the slash command.
-- Neither is part of the recipe — remove these lines along with the harness.
ExampleFrameTranslucent:SetMovable(true)
ExampleFrameTranslucent:RegisterForDrag("LeftButton")
ExampleFrameTranslucent:SetScript("OnDragStart", function(self) self:StartMoving() end)
ExampleFrameTranslucent:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
CreateFrame("Button", nil, ExampleFrameTranslucent, "UIPanelCloseButtonDefaultAnchors")

SLASH_EXAMPLEFRAMETRANSLUCENT1 = "/ev2"
SlashCmdList["EXAMPLEFRAMETRANSLUCENT"] = function()
    local f = ExampleFrameTranslucent
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
