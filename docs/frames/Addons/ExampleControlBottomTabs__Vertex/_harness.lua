-- HARNESS: Not part of the recipe. Registers /ev11 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleControlBottomTabs = ExampleControlBottomTabs

-- QoL (harness only): makes the frame draggable and adds a close button so you
-- can tile demos side-by-side and dismiss them without the slash command.
-- Neither is part of the recipe — remove these lines along with the harness.
ExampleControlBottomTabs:SetMovable(true)
ExampleControlBottomTabs:RegisterForDrag("LeftButton")
ExampleControlBottomTabs:SetScript("OnDragStart", function(self) self:StartMoving() end)
ExampleControlBottomTabs:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
CreateFrame("Button", nil, ExampleControlBottomTabs, "UIPanelCloseButtonDefaultAnchors")

SLASH_EXAMPLECONTROLBOTTOMTABS1 = "/ev11"
SlashCmdList["EXAMPLECONTROLBOTTOMTABS"] = function()
    local f = ExampleControlBottomTabs
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
