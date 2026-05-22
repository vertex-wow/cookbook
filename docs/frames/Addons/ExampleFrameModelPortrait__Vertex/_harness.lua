-- HARNESS: Not part of the recipe. Registers /ev7 so you can toggle the frame
-- in-game to see the example. Safe to delete when building your own addon.

VertexExamples = VertexExamples or {}
VertexExamples.ExampleFrameModelPortrait = ExampleFrameModelPortrait

-- QoL (harness only): makes the frame draggable so you can tile demos side-by-side.
-- PortraitFrameTemplate already provides a close button, so only drag is added here.
-- Not part of the recipe — remove these lines along with the harness.
ExampleFrameModelPortrait:SetMovable(true)
ExampleFrameModelPortrait:RegisterForDrag("LeftButton")
ExampleFrameModelPortrait:SetScript("OnDragStart", function(self) self:StartMoving() end)
ExampleFrameModelPortrait:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

SLASH_EXAMPLEFRAMEMODELPORTRAIT1 = "/ev7"
SlashCmdList["EXAMPLEFRAMEMODELPORTRAIT"] = function()
    local f = ExampleFrameModelPortrait
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
