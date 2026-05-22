-- HARNESS: Not part of the recipe. Registers /ev6 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleFrameIconPortrait = ExampleFrameIconPortrait

-- QoL (harness only): makes the frame draggable so you can tile demos side-by-side.
-- PortraitFrameTemplate already provides a close button, so only drag is added here.
-- Not part of the recipe — remove these lines along with the harness.
ExampleFrameIconPortrait:SetMovable(true)
ExampleFrameIconPortrait:RegisterForDrag("LeftButton")
ExampleFrameIconPortrait:SetScript("OnDragStart", function(self) self:StartMoving() end)
ExampleFrameIconPortrait:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

SLASH_EXAMPLEFRAMEICONPORTRAIT1 = "/ev6"
SlashCmdList["EXAMPLEFRAMEICONPORTRAIT"] = function()
    local f = ExampleFrameIconPortrait
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
