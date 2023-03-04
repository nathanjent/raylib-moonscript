-- MoonScript version of raylib [textures] example - gif playing
-- 
-- Example originally created with raylib 4.2, last time updated with raylib 4.2
-- 
-- Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
-- BSD-like license that allows static linking with closed source software
-- 
-- Copyright (c) 2021-2023 Ramon Santamaria (@raysan5)

MAX_FRAME_DELAY = 20
MIN_FRAME_DELAY = 1

-- Initialization
-----------------
screenWidth = 800
screenHeight = 450

rl.SetConfigFlags rl.FLAG_VSYNC_HINT

rl.InitWindow screenWidth, screenHeight, "raylib [textures] example - gif playing"

animFrames = 0;

-- Load all GIF animation frames into a single Image
-- NOTE: GIF data is always loaded as RGBA (32bit) by default
-- NOTE: Frames are just appended one after another in image.data memory
imScarfyAnim = rl.LoadImageAnim "gfx/spritesheet.gif", &animFrames

-- Load texture from image
-- NOTE: We will update this texture when required with next frame data
-- WARNING: It's not recommended to use this technique for sprites animation,
-- use spritesheets instead, like illustrated in textures_sprite_anim example
texScarfyAnim = rl.LoadTextureFromImage imScarfyAnim
 
nextFrameDataOffset = 0 -- Current byte offset to next frame in image.data

currentAnimFrame = 0 -- Current animation frame to load and draw
frameDelay = 8 -- Frame delay to switch between animation frames
frameCounter = 0 -- General frames counter

rl.SetTargetFPS 60 -- Set our game to run at 60 frames-per-second

-- Main game loop
while not rl.WindowShouldClose!
  --  Update
  --  ------
  frameCounter += 1
  if frameCounter >= frameDelay
    -- Move to next frame
    -- NOTE: If final frame is reached we return to first frame
    currentAnimFrame += 1
    if currentAnimFrame >= animFrames
      currentAnimFrame = 0
    
    -- Get memory offset position for next frame data in image.data
    nextFrameDataOffset = imScarfyAnim.width * imScarfyAnim.height * 4 * currentAnimFrame
     
    -- Update GPU texture data with next frame image data
    -- WARNING: Data size (frame size) and pixel format must match already created texture
    rl.UpdateTexture texScarfyAnim, imScarfyAnim.data + nextFrameDataOffset
     
    frameCounter = 0;
   
  -- Control frames delay
  if rl.IsKeyPressed rl.KEY_RIGHT
    frameDelay += 1
  else if IsKeyPressed rl.KEY_LEFT
    frameDelay -= 1
   
  if frameDelay > MAX_FRAME_DELAY
    frameDelay = MAX_FRAME_DELAY
  else if frameDelay < MIN_FRAME_DELAY
    frameDelay = MIN_FRAME_DELAY
  -------

  -- Draw
  ----------------
  rl.BeginDrawing!
  rl.ClearBackground rl.RAYWHITE
   
  rl.DrawText rl.TextFormat("TOTAL GIF FRAMES:  %02i", animFrames), 50, 30, 20, rl.LIGHTGRAY
  rl.DrawText rl.TextFormat("CURRENT FRAME: %02i", currentAnimFrame), 50, 60, 20, rl.GRAY
  rl.DrawText rl.TextFormat("CURRENT FRAME IMAGE.DATA OFFSET: %02i", nextFrameDataOffset), 50, 90, 20, rl.GRAY
  
  rl.DrawText "FRAMES DELAY: ", 100, 305, 10, rl.DARKGRAY
  rl.DrawText rl.TextFormat("%02i frames", frameDelay), 620, 305, 10, rl.DARKGRAY
  rl.DrawText "PRESS RIGHT/LEFT KEYS to CHANGE SPEED!", 290, 350, 10, rl.DARKGRAY
  -
  for i = 0, MAX_FRAME_DELAY
    if i < frameDelay
      rl.DrawRectangle 190 + 21 * i, 300, 20, 20, rl.RED
    rl.DrawRectangleLines(190 + 21 * i, 300, 20, 20, rl.MAROON
   
  rl.DrawTexture texScarfyAnim, rl.GetScreenWidth! / 2 - texScarfyAnim.width / 2, 140, rl.WHITE
   
  rl.DrawText "(c) Scarfy sprite by Eiden Marsal", screenWidth - 200, screenHeight - 20, 10, rl.GRAY

  rl.EndDrawing!
  --------------

  -- De-Initialization
  --------------------
  rl.UnloadTexture texScarfyAnim -- Unload texture
  rl.UnloadImage imScarfyAnim -- Unload image (contains all frames)

rl.CloseWindow!