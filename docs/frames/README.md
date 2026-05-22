# Frames

XML frame recipes. No Lua, no logic — just the frame definitions.

| <a href="#bare-frame"><img src="./assets/example_frame_bare.png" width="140"><br/>Bare</a> | <a href="#translucent-frame"><img src="./assets/example_frame_translucent.png" width="140"><br/>Translucent</a> | <a href="#tooltip-frame"><img src="./assets/example_frame_tooltip.png" width="140"><br/>Tooltip</a> | <a href="#title-frame"><img src="./assets/example_frame_title.png" width="140"><br/>Title</a> | <a href="#icon-portrait"><img src="./assets/example_frame_icon_portrait.png" width="140"><br/>Icon Portrait</a> | <a href="#model-portrait"><img src="./assets/example_frame_model_portrait.png" width="140"><br/>Model Portrait</a> |
|:---:|:---:|:---:|:---:|:---:|:---:|

---

## Bare frame

A minimal frame with a solid background and no border.

![ExampleFrameBare in-game](./assets/example_frame_bare.png)

### The frame

```xml
<Frame name="ExampleFrameBare" parent="UIParent"
       enableMouse="true"
       frameStrata="MEDIUM" hidden="true">
  <Size x="240" y="160"/>
  <Anchors>
    <Anchor point="CENTER"/>
  </Anchors>
  <Layers>
    <Layer level="BACKGROUND">
      <Texture setAllPoints="true">
        <Color r="0" g="0" b="0" a="1"/>
      </Texture>
    </Layer>
    <Layer level="ARTWORK">
      <FontString name="$parentTitle" inherits="GameFontNormal"
                  text="Example Bare Frame">
        <Anchors>
          <Anchor point="TOP" relativePoint="TOP" y="-16"/>
        </Anchors>
      </FontString>
    </Layer>
  </Layers>
</Frame>
```

### Live demo

Install the addon in [Addons/ExampleFrameBare__Vertex](./Addons/ExampleFrameBare__Vertex/) and use `/ev1` to toggle the frame in-game.

---

## Translucent frame

A bare frame with a translucent background. The game world is visible through it.

![ExampleFrameTranslucent in-game](./assets/example_frame_translucent.png)

### The frame

```xml
<Frame name="ExampleFrameTranslucent" parent="UIParent"
       enableMouse="true"
       frameStrata="MEDIUM" hidden="true">
  <Size x="240" y="160"/>
  <Anchors>
    <Anchor point="CENTER"/>
  </Anchors>
  <Layers>
    <Layer level="BACKGROUND">
      <Texture setAllPoints="true">
        <Color r="0" g="0" b="0" a="0.5"/>
      </Texture>
    </Layer>
    <Layer level="ARTWORK">
      <FontString name="$parentTitle" inherits="GameFontNormal"
                  text="Example Translucent Frame">
        <Anchors>
          <Anchor point="TOP" relativePoint="TOP" y="-16"/>
        </Anchors>
      </FontString>
    </Layer>
  </Layers>
</Frame>
```

### frameStrata and draw order

`frameStrata` controls which rendering layer the frame occupies. Frames in a higher
strata always draw on top of frames in a lower one, regardless of their Z-order within
that strata.

Common values from bottom to top: `BACKGROUND`, `LOW`, `MEDIUM`, `HIGH`,
`DIALOG`, `FULLSCREEN`, `FULLSCREEN_DIALOG`, `TOOLTIP`.

A translucent frame placed in the wrong strata can be obscured by other frames or,
conversely, block UI elements it should sit behind.

### Live demo

Install the addon in [Addons/ExampleFrameTranslucent__Vertex](./Addons/ExampleFrameTranslucent__Vertex/) and use `/ev2` to toggle the frame in-game.

---

## Tooltip frame

A frame combining the rounded `NineSlicePanelTemplate` border with a semi-translucent background.

![ExampleFrameTooltip in-game](./assets/example_frame_tooltip.png)

### The frame

```xml
<Frame name="ExampleFrameTooltip" parent="UIParent"
       enableMouse="true"
       frameStrata="MEDIUM" hidden="true">
  <Size x="240" y="160"/>
  <Anchors>
    <Anchor point="CENTER"/>
  </Anchors>
  <Frames>
    <Frame inherits="NineSlicePanelTemplate" useParentLevel="true" setAllPoints="true">
      <KeyValues>
        <KeyValue key="layoutType" value="TooltipDefaultLayout" type="string"/>
      </KeyValues>
      <Layers>
        <Layer level="BACKGROUND" textureSubLevel="1">
          <Texture>
            <Anchors>
              <Anchor point="TOPLEFT" x="4" y="-4"/>
              <Anchor point="BOTTOMRIGHT" x="-4" y="4"/>
            </Anchors>
            <Color r="0" g="0" b="0" a="0.5"/>
          </Texture>
        </Layer>
      </Layers>
    </Frame>
  </Frames>
  <Layers>
    <Layer level="ARTWORK">
      <FontString name="$parentTitle" inherits="GameFontNormal"
                  text="Example Tooltip Frame">
        <Anchors>
          <Anchor point="TOP" relativePoint="TOP" y="-16"/>
        </Anchors>
      </FontString>
    </Layer>
  </Layers>
</Frame>
```

### Key attributes

| Attribute | Value | Why |
|---|---|---|
| `enableMouse="true"` | true | Required for drag/click; without this, clicks pass through to the game world even when the frame is visible |
| `frameStrata` | `MEDIUM` | Renders above world, below UI chrome |
| `hidden="true"` | true | Frame starts hidden |

### Background and border

The old XML `<Backdrop>` element is defunct in retail WoW — it is silently ignored.
The modern equivalent is two separate concerns:

**Border** — a child `Frame` inheriting `NineSlicePanelTemplate`.
`TooltipDefaultLayout` gives the rounded tooltip-style border (no title-bar overhang).
The layout includes its own center fill atlas at `textureSubLevel="0"` in the
BACKGROUND layer of the NineSlice child frame.

**Background fill** — a plain `<Color>` texture placed inside the same NineSlice
child frame at `textureSubLevel="1"`. Because higher sub-levels render in front,
this covers the built-in center atlas and replaces it with a semi-translucent color.
The 4px insets keep the fill inside the border edge.

### Live demo

Install the addon in [Addons/ExampleFrameTooltip__Vertex](./Addons/ExampleFrameTooltip__Vertex/) and use `/ev3` to toggle the frame in-game.

---

## Title frame

A frame using `DefaultPanelTemplate` — standard WoW panel chrome with a title bar and no portrait slot.

![ExampleFrameTitleFrame in-game](./assets/example_frame_title.png)

### The frame

```xml
<Frame name="ExampleFrameTitleFrame" parent="UIParent"
       toplevel="true" enableMouse="true"
       frameStrata="MEDIUM" hidden="true"
       inherits="DefaultPanelTemplate">
  <Size x="380" y="260"/>
  <Anchors>
    <Anchor point="CENTER"/>
  </Anchors>
</Frame>
```

### Setting the title

The template applies `DefaultPanelMixin` (which extends `TitledPanelMixin`) to the frame, exposing a `SetTitle` method:

```lua
ExampleFrameTitleFrame:SetTitle("Example Title Frame")
```

`SetTitle` writes directly to `self.TitleContainer.TitleText`, the `FontString` embedded in the title bar by the template. Setting it in the Lua file (loaded after the XML) is the canonical pattern — the template leaves the text empty so the caller controls it.

### What DefaultPanelTemplate provides

`DefaultPanelTemplate` is a Blizzard-supplied virtual frame built on `DefaultPanelBaseTemplate`:

| Key | Type | Purpose |
|---|---|---|
| `frame.TitleContainer.TitleText` | FontString | Title label in the header bar |
| `frame.NineSlice` | Frame | `ButtonFrameTemplateNoPortrait` nine-slice border |

The nine-slice layout (`ButtonFrameTemplateNoPortrait`) gives the standard metal WoW panel chrome without a portrait cutout in the top-left corner. There is no built-in close button — dismiss the frame programmatically or add your own.

### Live demo

Install the addon in [Addons/ExampleFrameTitleFrame__Vertex](./Addons/ExampleFrameTitleFrame__Vertex/) and use `/ev4` to toggle the frame in-game.

---

## Icon portrait

A frame using `PortraitFrameTemplate` with a custom icon texture as the portrait.

![ExampleFrameIconPortrait in-game](./assets/example_frame_icon_portrait.png)

### The frame

```xml
<Frame name="ExampleFrameIconPortrait" parent="UIParent"
       toplevel="true" enableMouse="true"
       frameStrata="MEDIUM" hidden="true"
       inherits="PortraitFrameTemplate">
  <Size x="380" y="260"/>
  <Anchors>
    <Anchor point="CENTER"/>
  </Anchors>
</Frame>
```

### What PortraitFrameTemplate provides

`PortraitFrameTemplate` is a Blizzard-supplied virtual frame that wires up the
standard WoW panel chrome — title bar, close button, border, and a portrait slot —
all accessible as named children on the frame:

| Key | Type | Purpose |
|---|---|---|
| `frame.TitleText` | FontString | Title label in the header bar |
| `frame.PortraitContainer.portrait` | Texture | Circular portrait image in the top-left |
| `frame.CloseButton` | Button | Hides the frame when clicked |

### Populating the portrait

Portrait content is set in Lua after the frame is created. The XML loads first, then
the Lua file runs at addon load time:

```lua
ExampleFrameIconPortrait:SetTitle("Example Icon Portrait")
ExampleFrameIconPortrait:SetPortraitToAsset("Interface\\AddOns\\ExampleFrameIconPortrait__Vertex\\vertex-icon")
ExampleFrameIconPortrait:GetPortrait():SetTexCoord(0, 1, 1, 0)
ExampleFrameIconPortrait:SetPortraitTextureSizeAndOffset(64, -6, 10)
```

`SetPortraitToAsset` and `SetPortraitTextureSizeAndOffset` are methods provided by
`PortraitFrameTemplate` — use these rather than calling `SetPortraitToTexture` on
`frame.Portrait` directly. The size and offset control how the texture is positioned
within the circular portrait area.

To show a unit portrait instead (player's class icon, race, etc.):

```lua
SetPortraitTexture(ExampleFrameIconPortrait:GetPortrait(), "player")
```

### Live demo

Install the addon in [Addons/ExampleFrameIconPortrait__Vertex](./Addons/ExampleFrameIconPortrait__Vertex/) and use `/ev5` to toggle the frame in-game. The addon includes `vertex-icon.png` as the example portrait texture.

---

## Model portrait

A frame using `PortraitFrameTemplate` with the player's face rendered into the
portrait slot via `SetPortraitToUnit`.

![ExampleFrameModelPortrait in-game](./assets/example_frame_model_portrait.png)

### The frame

```xml
<Frame name="ExampleFrameModelPortrait" parent="UIParent"
       toplevel="true" enableMouse="true"
       frameStrata="MEDIUM" hidden="true"
       inherits="PortraitFrameTemplate">
  <Size x="380" y="260"/>
  <Anchors>
    <Anchor point="CENTER"/>
  </Anchors>
</Frame>
```

### Populating the portrait

`SetPortraitToUnit` renders the unit's face into the portrait texture and respects
the circular mask. Call it in an `OnShow` handler so the portrait refreshes each
time the frame opens — the same pattern used by `AuctionHouseFrame`, `BankFrame`,
and `TradeFrame`:

```lua
ExampleFrameModelPortrait:SetTitle("Example Model Portrait")
ExampleFrameModelPortrait:SetScript("OnShow", function(self)
    self:SetPortraitToUnit("player")
end)
```

This is identical in structure to the [Icon portrait](#icon-portrait) recipe —
the only difference is the portrait source: `SetPortraitToUnit` instead of
`SetPortraitToAsset`.

### Live demo

Install the addon in [Addons/ExampleFrameModelPortrait__Vertex](./Addons/ExampleFrameModelPortrait__Vertex/) and use `/ev6` to toggle the frame in-game.
