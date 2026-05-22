-- HARNESS: Not part of the recipe. Registers /ev1 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleFrameBare = ExampleFrameBare

-- QoL (harness only): makes the frame draggable and adds a close button so you
-- can tile demos side-by-side and dismiss them without the slash command.
-- Neither is part of the recipe — remove these lines along with the harness.
ExampleFrameBare:SetMovable(true)
ExampleFrameBare:RegisterForDrag("LeftButton")
ExampleFrameBare:SetScript("OnDragStart", function(self) self:StartMoving() end)
ExampleFrameBare:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
CreateFrame("Button", nil, ExampleFrameBare, "UIPanelCloseButtonDefaultAnchors")

SLASH_EXAMPLEFRAMEBARE1 = "/ev1"
SlashCmdList["EXAMPLEFRAMEBARE"] = function()
    local f = ExampleFrameBare
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
