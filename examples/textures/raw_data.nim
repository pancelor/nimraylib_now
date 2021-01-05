#*******************************************************************************************
#
#   raylib [textures] example - Load textures from raw data
#
#   NOTE: Images are loaded in CPU memory (RAM) textures are loaded in GPU memory (VRAM)
#
#   This example has been created using raylib 1.3 (www.raylib.com)
#   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
#
#   Copyright (c) 2015 Ramon Santamaria (@raysan5)
#   /Converted in 2*20 by Guevara-chan.
#
#*******************************************************************************************

import raylib

#  Initialization
# --------------------------------------------------------------------------------------
const screenWidth = 800
const screenHeight = 450

InitWindow screenWidth, screenHeight, "raylib [textures] example - texture from raw data"

#  NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)

#  Load RAW image data (512x512, 32bit RGBA, no file header)
let 
    fudesumiRaw = LoadImageRaw("resources/fudesumi.raw", 384, 512, UNCOMPRESSED_R8G8B8A8, 0)
    fudesumi = LoadTextureFromImage(fudesumiRaw)  #  Upload CPU (RAM) image to GPU (VRAM)
UnloadImage fudesumiRaw                           #  Unload CPU (RAM) image data

#  Generate a checked texture by code
let
    width = 960
    height = 480

#  Dynamic memory allocation to store pixels data (Color type)
var pixels = newSeq[Color](width*height)

for y in 0..<height:
    for x in 0..<width:
        pixels[y*width + x] = (if (((x div 32+y div 32) div 1) %% 2 == 0): ORANGE else: GOLD)

#  Load pixels data into an image structure and create texture
let
    checkedIm = Image(data:cast[ptr Color](pixels), width:width, height:height, format:UNCOMPRESSED_R8G8B8A8, mipmaps:1)
    checked = LoadTextureFromImage(checkedIm)
#UnloadImage checkedIm         #  Unload CPU (RAM) image data (do not do this in Nim, seriously)
# ---------------------------------------------------------------------------------------

#  Main game loop
while not WindowShouldClose(): #  Detect window close button or ESC key
    #  Update
    # ----------------------------------------------------------------------------------
    #  TODO: Update your variables here
    # ----------------------------------------------------------------------------------

    #  Draw
    # ----------------------------------------------------------------------------------
    BeginDrawing()

    ClearBackground(RAYWHITE)

    DrawTexture checked, screenWidth div 2 - checked.width div 2, screenHeight div 2 - checked.height div 2, 
        Fade(WHITE, 0.5f)
    DrawTexture fudesumi, 430, -30, WHITE

    DrawText "CHECKED TEXTURE ", 84, 85, 30, BROWN
    DrawText "GENERATED by CODE", 72, 148, 30, BROWN
    DrawText "and RAW IMAGE LOADING", 46, 210, 30, BROWN

    DrawText "(c) Fudesumi sprite by Eiden Marsal", 310, screenHeight - 20, 10, BROWN

    EndDrawing()
    # ----------------------------------------------------------------------------------

#  De-Initialization
# --------------------------------------------------------------------------------------
UnloadTexture fudesumi     #  Texture unloading
UnloadTexture checked      #  Texture unloading

CloseWindow()              #  Close window and OpenGL context
# --------------------------------------------------------------------------------------