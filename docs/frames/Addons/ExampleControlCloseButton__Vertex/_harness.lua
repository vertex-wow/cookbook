-- HARNESS: Not part of the recipe. Registers /ev8 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleControlCloseButton = ExampleControlCloseButton

-- QoL (harness only): makes the frame draggable so you can tile demos side-by-side.
-- The recipe itself provides the close button, so only drag is added here.
-- Not part of the recipe — remove these lines along with the harness.
ExampleControlCloseButton:SetMovable(true)
ExampleControlCloseButton:RegisterForDrag("LeftButton")
ExampleControlCloseButton:SetScript("OnDragStart", function(self) self:StartMoving() end)
ExampleControlCloseButton:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

SLASH_EXAMPLECONTROLCLOSEBUTTON1 = "/ev8"
SlashCmdList["EXAMPLECONTROLCLOSEBUTTON"] = function()
    local f = ExampleControlCloseButton
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
