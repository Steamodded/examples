// both values come from the `send_vars` function in the lua file.
extern float example_number;
extern vec3 example_vec3;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
  vec4 tex = Texel(texture, texture_coords);
  // this gives the colour of the pixel

  tex.g *= example_number; // multiply the green value by the sent number
  tex.rgb *= example_vec3; // multiplies the entire colour by the sent vector
  // note that you must use tex.rgb, as tex is a vec4, and you can't multiply the two.

  return tex;
}
