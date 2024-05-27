// C implementations of drawing functions (and helper functions)

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include "drawing_funcs.h"

////////////////////////////////////////////////////////////////////////
// Helper functions
////////////////////////////////////////////////////////////////////////

// check if current x,y position is in bounds of image
int32_t in_bounds(struct Image *img, int32_t x, int32_t y)
{
  // Check if x and y are within bounds
  if (x >= 0 && x < img->width && y >= 0 && y < img->height)
  {
    return 1;
  }
  // OOB
  return 0;
}

// compute index in row-major order
uint32_t compute_index(struct Image *img, int32_t x, int32_t y)
{
  return y * img->width + x;
}

uint32_t blend_colors(uint32_t fg, uint32_t bg)
{
  uint32_t new_color = 0;

  // getting alpha, and colors so that we can blend
  uint8_t alpha_fg = get_a(fg);
  uint8_t fg_r = get_r(fg);
  uint8_t bg_r = get_r(bg);
  uint8_t fg_g = get_g(fg);
  uint8_t bg_g = get_g(bg);
  uint8_t fg_b = get_b(fg);
  uint8_t bg_b = get_b(bg);

  // blend red, green, blue with the specified alpha
  uint8_t blend_red = blend_components(fg_r, bg_r, alpha_fg);
  uint8_t blend_green = blend_components(fg_g, bg_g, alpha_fg);
  uint8_t blend_blue = blend_components(fg_b, bg_b, alpha_fg);

  // left shift in the bits from our result
  new_color = (blend_red << 24) | (blend_green << 16) | (blend_blue << 8) | 255;

  return new_color;
}

uint8_t blend_components(uint32_t fg, uint32_t bg, uint32_t alpha)
{
  // equation that blends based on alpha
  return ((alpha * fg + ((0xFF) - alpha) * bg) / 255);
}

uint8_t get_a(uint32_t color)
{
  // bits 0-7 are alpha
  return color & (0xFF);
}

uint8_t get_r(uint32_t color)
{
  // bits 24-31 are red
  return (color >> 24) & (0xFF);
}

uint8_t get_b(uint32_t color)
{
  // bits 8-15 are blue
  return (color >> 8) & (0xFF);
}

uint8_t get_g(uint32_t color)
{
  // bits 16-23 are green;
  return (color >> 16) & (0xFF);
}

// returning squared value
int64_t square(int64_t x)
{
  return x * x;
}

int check_rect_bounds(struct Image *tilemap, const struct Rect *tile)
{
  // Iterate through the entire tile
  for (int i = 0; i < tile->width; i++)
  {
    for (int j = 0; j < tile->height; j++)
    {
      // Check bounds
      if (in_bounds(tilemap, tile->x + i, tile->y + j) == 0)
      {
        return 0;
      }
    }
  }
  return 1;
}

////////////////////////////////////////////////////////////////////////
// API functions
////////////////////////////////////////////////////////////////////////

//
// Draw a pixel.
//
// Parameters:
//   img   - pointer to struct Image
//   x     - x coordinate (pixel column)
//   y     - y coordinate (pixel row)
//   color - uint32_t color value
//
void draw_pixel(struct Image *img, int32_t x, int32_t y, uint32_t color)
{

  if (in_bounds(img, x, y)) // checking if x,y in bounds
  {
    // draw pixel in graph using row-major order, color needs to be blended
    img->data[compute_index(img, x, y)] = blend_colors(color, img->data[compute_index(img, x, y)]);
  }
}

//
// Draw a rectangle.
// The rectangle has rect->x,rect->y as its upper left corner,
// is rect->width pixels wide, and rect->height pixels high.
//
// Parameters:
//   img     - pointer to struct Image
//   rect    - pointer to struct Rect
//   color   - uint32_t color value
//
void draw_rect(struct Image *img,
               const struct Rect *rect,
               uint32_t color)
{
  // TODO: implement
  uint32_t start_x = rect->x;
  uint32_t start_y = rect->y;

  // Iterate through the entire rect to draw the pixels
  for (uint32_t i = 0; i < rect->width; ++i)
  {
    for (uint32_t j = 0; j < rect->height; ++j)
    {
      draw_pixel(img, start_x + i, start_y + j, color);
    }
  }
}

//
// Draw a circle.
// The circle has x,y as its center and has r as its radius.
//
// Parameters:
//   img     - pointer to struct Image
//   x       - x coordinate of circle's center
//   y       - y coordinate of circle's center
//   r       - radius of circle
//   color   - uint32_t color value
//
void draw_circle(struct Image *img,
                 int32_t x, int32_t y, int32_t r,
                 uint32_t color)
{
  // Iterate over the square that bounds the circle
  for (int i = x - r; i <= x + r; i++)
  {
    for (int j = y - r; j <= y + r; j++)
    {
      // Check if the current pixel is within the circle
      if ((square(i - x) + square(j - y)) <= square(r))
      {
        draw_pixel(img, i, j, color);
      }
    }
  }
}

//
// Draw a tile by copying all pixels in the region
// enclosed by the tile parameter in the tilemap image
// to the specified x/y coordinates of the destination image.
// No blending of the tile pixel colors with the background
// colors should be done.
//
// Parameters:
//   img     - pointer to Image (dest image)
//   x       - x coordinate of location where tile should be copied
//   y       - y coordinate of location where tile should be copied
//   tilemap - pointer to Image (the tilemap)
//   tile    - pointer to Rect (the tile)
//
void draw_tile(struct Image *img,
               int32_t x, int32_t y,
               struct Image *tilemap,
               const struct Rect *tile)
{
  // Bound Check
  if (check_rect_bounds(tilemap, tile) == 0)
  {
    return;
  }

  // Iterate through the entire tile
  for (int i = 0; i < tile->width; i++)
  {
    for (int j = 0; j < tile->height; j++)
    {
      if (in_bounds(img, x + i, y + j) == 0)
      {
        continue;
        // copying tilemap pixel in to destination
      }
      // tile pixel location in the tilemap converted from row-major
      uint32_t tilemap_ind = compute_index(tilemap, tile->x + i, tile->y + j);
      // destination pixle location in the img converted from row-major, start given by param x,y
      uint32_t destination_ind = compute_index(img, x + i, y + j);
      img->data[destination_ind] = tilemap->data[tilemap_ind];
    }
  }
}

//
// Draw a sprite by copying all pixels in the region
// enclosed by the sprite parameter in the spritemap image
// to the specified x/y coordinates of the destination image.
// The alpha values of the sprite pixels should be used to
// blend the sprite pixel colors with the background
// pixel colors.
//
// Parameters:
//   img       - pointer to Image (dest image)
//   x         - x coordinate of location where sprite should be copied
//   y         - y coordinate of location where sprite should be copied
//   spritemap - pointer to Image (the spritemap)
//   sprite    - pointer to Rect (the sprite)
//
void draw_sprite(struct Image *img,
                 int32_t x, int32_t y,
                 struct Image *spritemap,
                 const struct Rect *sprite)
{
  // Bound Check
  if (check_rect_bounds(spritemap, sprite) == 0)
  {
    return;
  }

  // go through entire rect
  for (int i = 0; i < sprite->width; i++)
  {
    for (int j = 0; j < sprite->height; j++)
    {
      // find index of sprite data
      uint32_t spritemap_ind = compute_index(spritemap, sprite->x + i, sprite->y + j);
      // draw pixel in x,y of specified img location from the sprite in the spritemap
      draw_pixel(img, x + i, y + j, spritemap->data[spritemap_ind]);
    }
  }
}