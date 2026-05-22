-- HARNESS: Not part of the recipe. Registers /ev12 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleControlRightTabs = ExampleControlRightTabs

-- QoL (harness only): makes the frame draggable and adds a close button so you
-- can tile demos side-by-side and dismiss them without the slash command.
-- Neither is part of the recipe — remove these lines along with the harness.
ExampleControlRightTabs:SetMovable(true)
ExampleControlRightTabs:RegisterForDrag("LeftButton")
ExampleControlRightTabs:SetScript("OnDragStart", function(self) self:StartMoving() end)
ExampleControlRightTabs:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
CreateFrame("Button", nil, ExampleControlRightTabs, "UIPanelCloseButtonDefaultAnchors")

SLASH_EXAMPLECONTROLRIGHTTABS1 = "/ev12"
SlashCmdList["EXAMPLECONTROLRIGHTTABS"] = function()
    local f = ExampleControlRightTabs
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
