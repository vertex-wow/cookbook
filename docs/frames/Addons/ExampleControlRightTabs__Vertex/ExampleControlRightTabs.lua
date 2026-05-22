local TAB_PANELS = { "AlphaPanel", "BetaPanel", "GammaPanel" }

ExampleControlRightTabsFrameMixin = {}

function ExampleControlRightTabsFrameMixin:OnLoad()
    self:SetTitle("Example Right Tabs")
    for _, tab in ipairs(self.TabButtons) do
        tab:SetCustomOnMouseUpHandler(function(self, button, upInside)
            if upInside and button == "LeftButton" then
                CallMethodOnNearestAncestor(self, "SelectTab", self.frameName)
            end
        end)
    end
end

function ExampleControlRightTabsFrameMixin:OnShow()
    self:SelectTab("AlphaPanel")
end

function ExampleControlRightTabsFrameMixin:SelectTab(frameName)
    for _, panelKey in ipairs(TAB_PANELS) do
        self[panelKey]:SetShown(panelKey == frameName)
    end
    for _, tab in ipairs(self.TabButtons) do
        tab:SetChecked(tab.frameName == frameName)
    end
end
