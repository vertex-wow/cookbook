ExampleFrameModelPortrait:SetTitle("Example Model Portrait")
ExampleFrameModelPortrait:SetScript("OnShow", function(self)
    self:SetPortraitToUnit("player")
end)
