# Controls

Interactive widgets for use inside frames — buttons, dropdowns, checkboxes, radio buttons, tabs, scroll bars, and tables.

---

## Button

_Recipe coming soon._

---

## Dropdown

_Recipe coming soon._

---

## Checkbox

_Recipe coming soon._

---

## Radio button

_Recipe coming soon._

---

## Bottom tabs

Adding `PanelTabButtonTemplate` tabs to a [Title Frame](../frames/README.md#title-frame). Three tabs switch between three content panels.

Two mixins are needed: one for the tab buttons, one for the frame. Because the XML `mixin` attribute is resolved at parse time, **the Lua file must be listed before the XML in the TOC**.

**XML** — a virtual tab template, then one `<Button>` per tab with a `frameName` key value, and a content `<Frame>` per panel. The first tab anchors `BOTTOMLEFT` on the frame; each subsequent tab chains `LEFT` off the previous:

```xml
<Button name="ExampleControlBottomTabsTabTemplate"
        inherits="PanelTabButtonTemplate"
        mixin="ExampleControlBottomTabsMixin"
        virtual="true">
  <Scripts>
    <OnShow method="OnShow"/>
    <OnClick method="OnClick"/>
  </Scripts>
</Button>

<Frame name="ExampleControlBottomTabs" ...
       inherits="DefaultPanelTemplate"
       mixin="ExampleControlBottomTabsFrameMixin">
  <Frames>
    <Button name="$parentAlphaTab" parentKey="AlphaTab"
            inherits="ExampleControlBottomTabsTabTemplate" text="Alpha">
      <KeyValues>
        <KeyValue key="frameName" value="AlphaPanel" type="string"/>
      </KeyValues>
      <Anchors>
        <Anchor point="BOTTOMLEFT" x="20" y="-28"/>
      </Anchors>
    </Button>
    <Button name="$parentBetaTab" parentKey="BetaTab"
            inherits="ExampleControlBottomTabsTabTemplate" text="Beta">
      <KeyValues>
        <KeyValue key="frameName" value="BetaPanel" type="string"/>
      </KeyValues>
      <Anchors>
        <Anchor point="LEFT" relativeKey="$parent.AlphaTab" relativePoint="RIGHT" x="-15" y="0"/>
      </Anchors>
    </Button>
    ...
  </Frames>
  <Scripts>
    <OnLoad method="OnLoad"/>
    <OnShow method="OnShow"/>
  </Scripts>
</Frame>
```

**Lua**:

```lua
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
```

| | |
|---|---|
| `PanelTabButtonTemplate` | Provides the curved tab art and selected/unselected states |
| `frameName` KeyValue | Lets `OnClick` pass the target panel name up without coupling the button to the frame |
| `CallMethodOnNearestAncestor` | Walks the parent chain to call `SelectTab` — the tab button needs no direct reference to the outer frame |
| `PanelTemplates_TabResize` | Called on `OnShow` to size the tab to its label text plus padding |
| `PanelTemplates_SetNumTabs` | Tells the template how many tabs exist; required for `SetTab` to work |
| `PanelTemplates_SetTab` | Sets the visual selected state on the correct tab |

### Live demo

Install the addon in [Addons/ExampleControlBottomTabs__Vertex](../frames/Addons/ExampleControlBottomTabs__Vertex/) and use `/ev11` to toggle the frame in-game.

---

## Right tabs

Adding `LargeSideTabButtonTemplate` icon tabs to a [Title Frame](../frames/README.md#title-frame). Three tabs with icons appear stacked vertically on the right side of the frame, outside its border. Clicking a tab switches between three content panels and shows a tooltip on hover.

Because the frame mixin references the global `ExampleControlRightTabsFrameMixin`, **the Lua file must be listed before the XML in the TOC**.

**XML** — a virtual tab template inheriting `LargeSideTabButtonTemplate` with `parentArray="TabButtons"`, then one `<Frame>` per tab and one content `<Frame>` per panel. The first tab anchors `TOPLEFT` to the frame's `TOPRIGHT`; each subsequent tab chains `TOP` off the previous tab's `BOTTOM`:

```xml
<Frame name="ExampleControlRightTabsTabTemplate"
       inherits="LargeSideTabButtonTemplate"
       parentArray="TabButtons"
       virtual="true"/>

<Frame name="ExampleControlRightTabs" ...
       inherits="DefaultPanelTemplate"
       mixin="ExampleControlRightTabsFrameMixin">
  <Frames>
    <Frame name="$parentAlphaTab" parentKey="AlphaTab"
           inherits="ExampleControlRightTabsTabTemplate">
      <KeyValues>
        <KeyValue key="frameName"     value="AlphaPanel"                       type="string"/>
        <KeyValue key="tooltipText"   value="Alpha"                            type="string"/>
        <KeyValue key="activeAtlas"   value="questlog-tab-icon-quest"          type="string"/>
        <KeyValue key="inactiveAtlas" value="questlog-tab-icon-quest-inactive" type="string"/>
      </KeyValues>
      <Anchors>
        <Anchor point="TOPLEFT" relativePoint="TOPRIGHT" x="3" y="-28"/>
      </Anchors>
    </Frame>
    <Frame name="$parentBetaTab" parentKey="BetaTab"
           inherits="ExampleControlRightTabsTabTemplate">
      ...
      <Anchors>
        <Anchor point="TOP" relativeKey="$parent.AlphaTab" relativePoint="BOTTOM" x="0" y="-3"/>
      </Anchors>
    </Frame>
    ...
  </Frames>
  <Scripts>
    <OnLoad method="OnLoad"/>
    <OnShow method="OnShow"/>
  </Scripts>
</Frame>
```

**Lua**:

```lua
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
```

| | |
|---|---|
| `LargeSideTabButtonTemplate` | 43×55 frame with `questlog-tab-side` background art, icon slot, selected glow, and hover glow; provides `SidePanelTabButtonMixin` for mouse handling and tooltips |
| `parentArray="TabButtons"` | Each instantiated tab is automatically appended to `parent.TabButtons`; the frame mixin iterates this array rather than naming tabs individually |
| `activeAtlas` / `inactiveAtlas` | KeyValues read by `SidePanelTabButtonMixin:SetChecked` to swap the icon atlas between selected and deselected states |
| `tooltipText` | KeyValue read by `SidePanelTabButtonMixin:OnEnter` to show a tooltip anchored to the right of the tab |
| `SetCustomOnMouseUpHandler` | Hook provided by `SidePanelTabButtonMixin`; the handler runs after the built-in sound and icon-nudge, so both visual feedback and navigation fire on the same click |
| `CallMethodOnNearestAncestor` | Walks the parent chain to call `SelectTab` — the tab button needs no direct reference to the outer frame |
| `SetChecked` | Sets `activeAtlas` or `inactiveAtlas` on the Icon texture and shows/hides the `SelectedTexture` glow overlay |

### Live demo

Install the addon in [Addons/ExampleControlRightTabs__Vertex](../frames/Addons/ExampleControlRightTabs__Vertex/) and use `/ev12` to toggle the frame in-game.

---

## Scroll bar

_Recipe coming soon._

---

## Table

_Recipe coming soon._

> Maintained by the [Vertex WoW Community](https://github.com/vertex-wow) and [Vertex Industries](https://github.com/vertex-industries).
