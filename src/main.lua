local MAX_FRAME_DELAY = 20
local MIN_FRAME_DELAY = 1
local screenWidth = 800
local screenHeight = 450
rl.SetConfigFlags(rl.FLAG_VSYNC_HINT)
rl.InitWindow(640, 480, "raylib [core] example - basic window")
while not rl.WindowShouldClose() do
  rl.BeginDrawing()
  rl.ClearBackground(rl.RAYWHITE)
  rl.DrawText("Congrats! You created your first window!", 19, 20, 20, rl.LIGHTGRAY)
  rl.EndDrawing()
end
return rl.CloseWindow()
