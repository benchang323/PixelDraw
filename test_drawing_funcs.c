#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "image.h"
#include "drawing_funcs.h"
#include "tctest.h"
// add prototypes for your helper functions

// an expected color identified by a (non-zero) character code
typedef struct
{
  char c;
  uint32_t color;
} ExpectedColor;

// struct representing a "picture" of an expected image
typedef struct
{
  ExpectedColor colors[20];
  const char *pic;
} Picture;

typedef struct
{
  struct Image small;
  struct Image large;
  struct Image tilemap;
  struct Image spritemap;
  struct Image empty;
} TestObjs;

// dimensions and pixel index computation for "small" test image (objs->small)
#define SMALL_W 8
#define SMALL_H 6
#define SMALL_IDX(x, y) ((y) * SMALL_W + (x))

// dimensions of the "large" test image
#define LARGE_W 24
#define LARGE_H 20

#define EMPTY_W 0
#define EMPTY_H 0

// create test fixture data
TestObjs *setup(void)
{
  TestObjs *objs = (TestObjs *)malloc(sizeof(TestObjs));
  init_image(&objs->small, SMALL_W, SMALL_H);
  init_image(&objs->large, LARGE_W, LARGE_H);
  init_image(&objs->empty, EMPTY_W, EMPTY_H);

  objs->tilemap.data = NULL;
  objs->spritemap.data = NULL;
  return objs;
}

// clean up test fixture data
void cleanup(TestObjs *objs)
{
  free(objs->small.data);
  free(objs->large.data);
  free(objs->tilemap.data);
  free(objs->spritemap.data);
  free(objs->empty.data);

  free(objs);
}

uint32_t lookup_color(char c, const ExpectedColor *colors)
{
  for (unsigned i = 0;; i++)
  {
    assert(colors[i].c != 0);
    if (colors[i].c == c)
    {
      return colors[i].color;
    }
  }
}

void check_picture(struct Image *img, Picture *p)
{
  unsigned num_pixels = img->width * img->height;
  assert(strlen(p->pic) == num_pixels);

  for (unsigned i = 0; i < num_pixels; i++)
  {
    char c = p->pic[i];
    uint32_t expected_color = lookup_color(c, p->colors);
    uint32_t actual_color = img->data[i];

    ASSERT(actual_color == expected_color);
  }
}

// prototypes of test functions
void test_draw_pixel(TestObjs *objs);
void test_draw_rect(TestObjs *objs);
void test_draw_circle(TestObjs *objs);
void test_draw_circle_clip(TestObjs *objs);
void test_draw_tile(TestObjs *objs);
void test_draw_sprite(TestObjs *objs);
void test_get_r(TestObjs *objs);
void test_get_g(TestObjs *objs);
void test_get_b(TestObjs *objs);
void test_get_a(TestObjs *objs);
void test_square(TestObjs *objs);
void test_blend_colors(TestObjs *objs);
void test_in_bounds(TestObjs *objs);
void test_compute_index(TestObjs *objs);
void test_check_rect_bounds(TestObjs *objs);
void test_blend_components(TestObjs *objs);
void test_draw_rect_2(TestObjs *objs);
void test_draw_rect_3(TestObjs *objs);
void test_draw_pixel_2(TestObjs *objs);

int main(int argc, char **argv)
{
  if (argc > 1)
  {
    // user specified a specific test function to run
    tctest_testname_to_execute = argv[1];
  }

  TEST_INIT();
  TEST(test_draw_circle_clip);
  TEST(test_draw_circle);

  //  add TEST() directives for your helper functions
  TEST(test_blend_colors);
  TEST(test_draw_pixel);
  TEST(test_draw_rect);
  TEST(test_draw_circle);
  TEST(test_draw_circle_clip);
  TEST(test_draw_sprite);

  TEST(test_draw_sprite);
  TEST(test_draw_tile);
  TEST(test_get_r);
  TEST(test_get_g);
  TEST(test_get_b);
  TEST(test_get_a);
  TEST(test_square);
  TEST(test_in_bounds);
  TEST(test_compute_index);
  TEST(test_check_rect_bounds);
  TEST(test_blend_components);
  TEST(test_draw_rect_2);
  TEST(test_draw_rect_3);
  TEST(test_draw_pixel_2);

  TEST_FINI();
}

void test_draw_pixel(TestObjs *objs)
{
  // initially objs->small pixels are opaque black
  ASSERT(objs->small.data[SMALL_IDX(3, 2)] == 0x000000FFU);
  ASSERT(objs->small.data[SMALL_IDX(5, 4)] == 0x000000FFU);

  // test drawing completely opaque pixels
  draw_pixel(&objs->small, 3, 2, 0xFF0000FF); // opaque red
  ASSERT(objs->small.data[SMALL_IDX(3, 2)] == 0xFF0000FF);
  draw_pixel(&objs->small, 5, 4, 0x800080FF); // opaque magenta (half-intensity)
  ASSERT(objs->small.data[SMALL_IDX(5, 4)] == 0x800080FF);

  // test color blending
  draw_pixel(&objs->small, 3, 2, 0x00FF0080); // half-opaque full-intensity green
  ASSERT(objs->small.data[SMALL_IDX(3, 2)] == 0x7F8000FF);
  draw_pixel(&objs->small, 4, 2, 0x0000FF40); // 1/4-opaque full-intensity blue
  ASSERT(objs->small.data[SMALL_IDX(4, 2)] == 0x000040FF);
}

void test_draw_rect(TestObjs *objs)
{
  struct Rect red_rect = {.x = 2, .y = 2, .width = 3, .height = 3};
  struct Rect blue_rect = {.x = 3, .y = 3, .width = 3, .height = 3};
  draw_rect(&objs->small, &red_rect, 0xFF0000FF);  // red is full-intensity, full opacity
  draw_rect(&objs->small, &blue_rect, 0x0000FF80); // blue is full-intensity, half opacity

  const uint32_t red = 0xFF0000FF;   // expected full red color
  const uint32_t blue = 0x000080FF;  // expected full blue color
  const uint32_t blend = 0x7F0080FF; // expected red/blue blend color
  const uint32_t black = 0x000000FF; // expected black (background) color

  Picture expected = {
      {{'r', red}, {'b', blue}, {'n', blend}, {' ', black}},
      "        "
      "        "
      "  rrr   "
      "  rnnb  "
      "  rnnb  "
      "   bbb  "};

  check_picture(&objs->small, &expected);
}

void test_draw_circle(TestObjs *objs)
{
  Picture expected = {
      {{' ', 0x000000FF}, {'x', 0x00FF00FF}},
      "   x    "
      "  xxx   "
      " xxxxx  "
      "  xxx   "
      "   x    "
      "        "};

  draw_circle(&objs->small, 3, 2, 2, 0x00FF00FF);

  check_picture(&objs->small, &expected);
}

void test_draw_circle_clip(TestObjs *objs)
{
  Picture expected = {
      {{' ', 0x000000FF}, {'x', 0x00FF00FF}},
      " xxxxxxx"
      " xxxxxxx"
      "xxxxxxxx"
      " xxxxxxx"
      " xxxxxxx"
      "  xxxxx "};

  draw_circle(&objs->small, 4, 2, 4, 0x00FF00FF);

  check_picture(&objs->small, &expected);
}

void test_draw_tile(TestObjs *objs)
{
  ASSERT(read_image("img/PrtMimi.png", &objs->tilemap) == IMG_SUCCESS);

  struct Rect r = {.x = 4, .y = 2, .width = 16, .height = 18};
  draw_rect(&objs->large, &r, 0x1020D0FF);

  struct Rect grass = {.x = 0, .y = 16, .width = 16, .height = 16};
  draw_tile(&objs->large, 3, 2, &objs->tilemap, &grass);

  Picture pic = {
      {
          {' ', 0x000000ff},
          {'a', 0x52ad52ff},
          {'b', 0x1020d0ff},
          {'c', 0x257b4aff},
          {'d', 0x0c523aff},
      },
      "                        "
      "                        "
      "             a     b    "
      "            a      b    "
      "            a     ab    "
      "           ac      b    "
      "           ac a    b    "
      "      a a  ad  a   b    "
      "     a  a aad  aa ab    "
      "     a  a acd aaacab    "
      "    aa  cdacdaddaadb    "
      "     aa cdaddaaddadb    "
      "     da ccaddcaddadb    "
      "    adcaacdaddddcadb    "
      "   aaccacadcaddccaab    "
      "   aacdacddcaadcaaab    "
      "   aaaddddaddaccaacb    "
      "   aaacddcaadacaaadb    "
      "    bbbbbbbbbbbbbbbb    "
      "    bbbbbbbbbbbbbbbb    "};

  check_picture(&objs->large, &pic);
}

void test_draw_sprite(TestObjs *objs)
{
  ASSERT(read_image("img/NpcGuest.png", &objs->spritemap) == IMG_SUCCESS);

  struct Rect r = {.x = 1, .y = 1, .width = 14, .height = 14};
  draw_rect(&objs->large, &r, 0x800080FF);

  struct Rect sue = {.x = 128, .y = 136, .width = 16, .height = 15};
  draw_sprite(&objs->large, 4, 2, &objs->spritemap, &sue);

  Picture pic = {
      {
          {' ', 0x000000ff},
          {'a', 0x800080ff},
          {'b', 0x9cadc1ff},
          {'c', 0xefeae2ff},
          {'d', 0x100000ff},
          {'e', 0x264c80ff},
          {'f', 0x314e90ff},
      },
      "                        "
      " aaaaaaaaaaaaaa         "
      " aaaaaaaaaaaaaa         "
      " aaaaaaaaaaaaaa         "
      " aaaaaaabccccccbc       "
      " aaaaacccccccccccc      "
      " aaaacbddcccddcbccc     "
      " aaacbbbeccccedbccc     "
      " aaacbbceccccebbbccc    "
      " aaabbbccccccccbbccc    "
      " aaaabbbcccccccb ccb    "
      " aaaabaaaaabbaa  cb     "
      " aaaaaaaaafffea         "
      " aaaaaaaaaffeea         "
      " aaaaaaacffffcc         "
      "        cffffccb        "
      "         bbbbbbb        "
      "                        "
      "                        "
      "                        "};

  check_picture(&objs->large, &pic);
}

// TEST FOR uint8_t get_r(uint32_t color);
void test_get_r(TestObjs *objs)
{
  // Test Normal and Black / White
  ASSERT(get_r(0x12345678) == 0x12);
  ASSERT(get_r(0x00000000) == 0x00);
  ASSERT(get_r(0xFFFFFFFF) == 0xFF);
}

// TEST FOR uint8_t get_g(uint32_t color);
void test_get_g(TestObjs *objs)
{
  // Test Normal and Black / White
  ASSERT(get_g(0x12345678) == 0x34);
  ASSERT(get_g(0x00000000) == 0x00);
  ASSERT(get_g(0xFFFFFFFF) == 0xFF);
}

// TEST FOR uint8_t get_b(uint32_t color);
void test_get_b(TestObjs *objs)
{
  // Test Normal and Black / White
  ASSERT(get_b(0x12345678) == 0x56);
  ASSERT(get_b(0x00000000) == 0x00);
  ASSERT(get_b(0xFFFFFFFF) == 0xFF);
}

// TEST FOR uint8_t get_a(uint32_t color);
void test_get_a(TestObjs *objs)
{
  // Test Normal and Black / White
  ASSERT(get_a(0x12345678) == 0x78);
  ASSERT(get_a(0x00000000) == 0x00);
  ASSERT(get_a(0xFFFFFFFF) == 0xFF);
}

// TEST FOR int64_t square(int64_t x);
void test_square(TestObjs *objs)
{
  // Test Normal and Negative
  ASSERT(square(5) == 25);
  ASSERT(square(-5) == 25);

  // Test Edge Cases
  ASSERT(square(0) == 0);
  ASSERT(square(1) == 1);

  // Test Large Numbers
  ASSERT(square(1000000) == 1000000000000);
  ASSERT(square(-1000000) == 1000000000000);
}

// TEST FOR int32_t in_bounds(struct Image *img, int32_t x, int32_t y);
void test_in_bounds(TestObjs *objs)
{
  // Normal / Edge Case
  ASSERT(in_bounds(&objs->small, 0, 0) == 1);
  ASSERT(in_bounds(&objs->small, 7, 5) == 1);
  ASSERT(in_bounds(&objs->small, 0, 5) == 1);

  // Empty Image
  ASSERT(in_bounds(&objs->empty, 0, 0) == 0);

  // Large Image
  ASSERT(in_bounds(&objs->large, 0, 0) == 1);
  ASSERT(in_bounds(&objs->large, 23, 19) == 1);
  ASSERT(in_bounds(&objs->large, 0, 19) == 1);

  // Out of Bounds
  ASSERT(in_bounds(&objs->small, 8, 5) == 0);
  ASSERT(in_bounds(&objs->small, 7, 6) == 0);

  // Negative
  ASSERT(in_bounds(&objs->small, -1, -1) == 0);
  ASSERT(in_bounds(&objs->small, -1, 5) == 0);

  // Negative and Out of Bounds
  ASSERT(in_bounds(&objs->small, -1, 5) == 0);
  ASSERT(in_bounds(&objs->small, 8, -1) == 0);
}

// TEST FOR uint32_t compute_index(struct Image *img, int32_t x, int32_t y);
void test_compute_index(TestObjs *objs)
{
  // Normal / Edge Case (No need for OOB)
  ASSERT(compute_index(&objs->small, 0, 0) == 0);
  ASSERT(compute_index(&objs->small, 7, 5) == 47);
  ASSERT(compute_index(&objs->small, 7, 0) == 7);
  ASSERT(compute_index(&objs->small, 0, 5) == 40);
}

// TEST FOR int check_rect_bounds(struct Image *tilemap, const struct Rect *tile);
void test_check_rect_bounds(TestObjs *objs)
{
  // Small - In Bounds
  struct Rect s1 = {1, 1, 6, 4};
  ASSERT(check_rect_bounds(&objs->small, &s1) == 1);

  // Small - OOB (Partial)
  struct Rect s2 = {6, 4, 3, 3};
  ASSERT(check_rect_bounds(&objs->small, &s2) == 0);

  // Small - OOB (Full)
  struct Rect s3 = {8, 6, 2, 2};
  ASSERT(check_rect_bounds(&objs->small, &s3) == 0);

  // Small - Exact
  struct Rect s4 = {0, 0, 8, 6};
  ASSERT(check_rect_bounds(&objs->small, &s4) == 1);

  // Empty
  struct Rect rand = {0, 0, 1, 1};
  ASSERT(check_rect_bounds(&objs->empty, &rand) == 0);
}

// TEST FOR void draw_rect(struct Image *img, const struct Rect *rect, uint32_t color);
void test_draw_rect_2(TestObjs *objs)
{
  // Draw partial bounds
  struct Rect edge_rect = {.x = 6, .y = 2, .width = 4, .height = 2};
  draw_rect(&objs->small, &edge_rect, 0x00FF00FF);

  const uint32_t green = 0x00FF00FF;
  const uint32_t black = 0x000000FF;
  Picture expected = {
      {{'g', green}, {' ', black}},
      "        "
      "        "
      "      gg"
      "      gg"
      "        "
      "        "};

  check_picture(&objs->small, &expected);
}

void test_draw_rect_3(TestObjs *objs)
{
  // Draw OOB
  struct Rect out_rect = {.x = 10, .y = 10, .width = 5, .height = 5};
  draw_rect(&objs->small, &out_rect, 0xFFFF00FF);

  const uint32_t black = 0x000000FF;

  // Empty since OOB
  Picture expected = {
      {{' ', black}},
      "        "
      "        "
      "        "
      "        "
      "        "
      "        "};

  check_picture(&objs->small, &expected);
}

// TEST FOR void draw_pixel(struct Image *img, int32_t x, int32_t y, uint32_t color);
void test_draw_pixel_2(TestObjs *objs)
{
  uint32_t color = 0x00FF00FF;
  draw_pixel(&objs->small, SMALL_W - 1, SMALL_H - 1, color);
  ASSERT(objs->small.data[SMALL_IDX(SMALL_W - 1, SMALL_H - 1)] == color);
}

// TEST FOR uint8_t blend_components(uint32_t fg, uint32_t bg, uint32_t alpha);
void test_blend_components(TestObjs *objs)
{
  ASSERT(blend_components(0xFF, 0x00, 0xFF) == 0xFF);
  ASSERT(blend_components(0xFF, 0x00, 0x00) == 0x00);
  ASSERT(blend_components(0xFF, 0x00, 0x80) == 0x80);
}

// TEST FOR uint32_t blend_colors(uint32_t fg, uint32_t bg);
void test_blend_colors(TestObjs *objs)
{
  ASSERT(blend_colors(0xFFFFFFFF, 0x00FFFFFF) == 0xFFFFFFFF);
  ASSERT(blend_colors(0x00FFFFFF, 0x00FFFFFF) == 0x00FFFFFF);
}