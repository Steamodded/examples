# Introduction
A Balatro example mod for adding custom Editions and Shaders.

Feel free to copy and use this* for any of projects!

***`anaglyphic`, `fluorescent`, `gilded`, `ionized`, `monochrome`, `greyscale` and `overexposed` shaders are not for public use and are only provided for learning purposes! (as requested by Eremel)**

Check [VanillaRemade](https://github.com/nh6574/VanillaRemade/blob/main/src/editions.lua) for examples of vanilla editions.

## Working with Shaders
See [the wiki](https://github.com/Steamodded/smods/wiki/SMODS.Shader-and-SMODS.ScreenShader) for documentation on `SMODS.Shader`

[ionized.fs](assets/shaders/ionized.fs) has shader code explanation with comments.
For a general guide, look at [LÖVE introduction to shaders](https://blogs.love2d.org/content/beginners-guide-shaders).

If you want to see vanilla Balatro shaders, unzip the Balatro.exe and go to `resources/shaders` folder.

To see values for default externs, check out `engine/sprite.lua` -> `Sprite:draw_shader`.


## Useful shaders resources
- [The book of shaders](https://thebookofshaders.com) - beginner friendly introduction to shaders.
- [GLSL Editor](https://patriciogonzalezvivo.github.io/glslEditor/) - preview your fragment shaders live.
- [Inigo Quilez articles](https://iquilezles.org/articles/) - in-depth articles on algorithms and techniques you could use in shaders. A lot of those are for 3D, but there's some 2D stuff as well.
- [Shadertoy](https://www.shadertoy.com) - tons of shaders from other people to learn from. A lot of them are pretty complex and 3D, but you can find simple 2D ones.

Note: in all resources the language is slightly different from LÖVE shaders language, but the logic works the same way.
