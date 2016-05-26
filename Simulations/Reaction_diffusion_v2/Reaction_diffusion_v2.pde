// Author: Daniel Shiffman
// Modified by Daniel Șuteu
// Written entirely based on
// http://www.karlsims.com/rd.html

// Also, could use for reference
// http://hg.postspectacular.com/toxiclibs/src/44d9932dbc9f9c69a170643e2d459f449562b750/src.sim/toxi/sim/grayscott/GrayScott.java?at=default

// Original code: https://github.com/shiffman/Video-Lesson-Materials/blob/master/code_challenges/Reaction-Diffusion/Holo_03_ReactionDiffusion.pde

Cell[][] grid;

void setup() {
  size(500, 300);
  grid = new Cell[height][width];

  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j ++) {
      grid[i][j] = new Cell(1, 0);
    }
  }

  for (int n = 0; n < 20; n++) {
    int startx = int(random(20, height-20));
    int starty = int(random(20, width-20));

    for (int i = startx; i < startx+10; i++) {
      for (int j = starty; j < starty+10; j ++) {
        grid[i][j] = new Cell(1, 1);
      }
    }
  }
}

float dA = 1.0;
float dB = 0.5;
float feed = 0.055;
float k = 0.062;

class Cell {
  float a;
  float b;

  Cell(float x, float y) {
    a = x;
    b = y;
  }
}

color hsv2rgb(float h, float s, float v) {
  float c = v * s;
  float x = c * (1 - abs(((h/60) % 2) - 1));
  float m = v - c;

  float r, g, b;
  if (h < 60) {
    r = c;
    g = x;
    b = 0;
  } else if (h < 120) {
    r = x;
    g = c;
    b = 0;
  } else if (h < 180) {
    r = 0;
    g = c;
    b = x;
  } else if (h < 240) {
    r = 0;
    g = x;
    b = c;
  } else if (h < 300) {
    r = x;
    g = 0;
    b = c;
  } else {
    r = c;
    g = 0;
    b = x;
  }

  int ri = round((r + m) * 255);
  int gi = round((g + m) * 255);
  int bi = round((b + m) * 255);

  return color(ri, gi, bi);
}

void draw() {
  println(frameRate);

  loadPixels();
  for (int i = 1; i < height-1; i++) {

    Cell[] above  = grid[i-1];
    Cell[] here   = grid[i];
    Cell[] bellow = grid[i+1];

    int pos = i * width;

    for (int j = 1; j < width-1; j++) {

      Cell spot = here[j];

      float a = spot.a;
      float b = spot.b;

      
      
      Cell left  = here[j-1];
      Cell right = here[j+1];

      Cell up       = above[j];
      Cell up_left  = above[j-1];
      Cell up_right = above[j+1];
      
      Cell down       = bellow[j];
      Cell down_left  = bellow[j-1];
      Cell down_right = bellow[j+1];

      float laplaceA = -a
        +         up.a * 0.2
        +       down.a * 0.2
        +       left.a * 0.2
        +      right.a * 0.2
        +    up_left.a * 0.05
        +   up_right.a * 0.05
        +  down_left.a * 0.05
        + down_right.a * 0.05;

      float laplaceB = -b
        +         up.b * 0.2
        +       down.b * 0.2
        +       left.b * 0.2
        +      right.b * 0.2
        +    up_left.b * 0.05
        +   up_right.b * 0.05
        +  down_left.b * 0.05
        + down_right.b * 0.05;

      spot.a = a + (dA*laplaceA - a*b*b + feed*(1-a))*1;
      spot.b = b + (dB*laplaceB + a*b*b - (k+feed)*b)*1;

      spot.a = constrain(spot.a, 0, 1);
      spot.b = constrain(spot.b, 0, 1);

      pixels[j + pos] = hsv2rgb((a*(i+j)) % 360, a, a-b);
    }
  }
  updatePixels();
}