# Bare Frame

A minimal XML frame. No Lua, no logic — just the frame definition.

![ExampleFrameBare in-game](./screenshot.png)
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
  <Backdrop bgFile="Interface/DialogFrame/UI-DialogBox-Background"
            edgeFile="Interface/DialogFrame/UI-DialogBox-Border"
            tile="true">
    <BackgroundInsets left="11" right="12" top="12" bottom="11"/>
    <TileSize val="32"/>
    <EdgeSize val="32"/>
  </Backdrop>
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

## Live demo

Install the addon in [Addons/ExampleFrameBare_Vertex](./Addons/ExampleFrameBare_Vertex/) and use `/ev1` to toggle the frame in-game.
