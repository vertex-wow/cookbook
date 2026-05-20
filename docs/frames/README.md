# Frames

A minimal XML frame. No Lua, no logic — just the frame definition.

![ExampleFrameBare in-game](./assets/example_frame_tooltip.png)
<!-- Replace screenshot.png with your in-game capture -->

## The frame

```xml
<Frame name="ExampleFrameBare" parent="UIParent"
       movable="true" enableMouse="true"
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
            <Color r="0" g="0" b="0" a="0.8"/>
          </Texture>
        </Layer>
      </Layers>
    </Frame>
  </Frames>
  <Layers>
    <Layer level="ARTWORK">
      <FontString name="$parentTitle" inherits="GameFontNormal"
                  text="Example Frame">
        <Anchors>
          <Anchor point="TOP" relativePoint="TOP" y="-16"/>
        </Anchors>
      </FontString>
    </Layer>
  </Layers>
</Frame>
```

## Key attributes

| Attribute | Value | Why |
|---|---|---|
| `hidden="true"` | true | Frame starts hidden |
| `movable="true"` | true | Player can drag it |
| `enableMouse="true"` | true | Required for drag/click |
| `frameStrata` | `MEDIUM` | Renders above world, below UI chrome |

## Background and border

The old XML `<Backdrop>` element is defunct in retail WoW — it is silently ignored.
The modern equivalent is two separate concerns:

**Border** — a child `Frame` inheriting `NineSlicePanelTemplate`.
`TooltipDefaultLayout` gives the rounded tooltip-style border (no title-bar overhang).
The layout includes its own center fill atlas at `textureSubLevel="0"` in the
BACKGROUND layer of the NineSlice child frame.

**Background fill** — a plain `<Color>` texture placed inside the same NineSlice
child frame at `textureSubLevel="1"`. Because higher sub-levels render in front,
this covers the built-in center atlas and replaces it with a solid translucent color.
The 4px insets keep the fill inside the border edge.

## Live demo

Install the addon in [Addons/ExampleFrameBare_EV1_Vertex](./Addons/ExampleFrameBare_EV1_Vertex/) and use `/ev1` to toggle the frame in-game.
