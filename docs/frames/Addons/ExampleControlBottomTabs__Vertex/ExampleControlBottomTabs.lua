local TAB_PADDING = 20
local MIN_TAB_WIDTH = 70
local TAB_PANELS = { "AlphaPanel", "BetaPanel", "GammaPanel" }

ExampleControlBottomTabsMixin = {}

function ExampleControlBottomTabsMixin:OnShow()
    PanelTemplates_TabResize(self, TAB_PADDING, nil, MIN_TAB_WIDTH)
end

function ExampleControlBottomTabsMixin:OnClick()
    CallMethodOnNearestAncestor(self, "SelectTab", self.frameName)
end

ExampleControlBottomTabsFrameMixin = {}

function ExampleControlBottomTabsFrameMixin:OnLoad()
    self:SetTitle("Example Bottom Tabs")
    PanelTemplates_SetNumTabs(self, #TAB_PANELS)
end

function ExampleControlBottomTabsFrameMixin:OnShow()
    self:SelectTab("AlphaPanel")
end

function ExampleControlBottomTabsFrameMixin:SelectTab(frameName)
    for i, panelKey in ipairs(TAB_PANELS) do
        if panelKey == frameName then
            self[panelKey]:Show()
            PanelTemplates_SetTab(self, i)
        else
            self[panelKey]:Hide()
        end
    end
end
