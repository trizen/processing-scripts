
// See: http://rosettacode.org/wiki/Julia_set
//      https://en.wikipedia.org/wiki/Julia_set

void setup() {
  size(640, 480);
}

float cX = -0.7;
float cY = 0.27015;
float zx, zy;
float maxIter = 300;

void draw() {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      zx = 1.5 * (x - width / 2) / (0.5 * width);
      zy = (y - height / 2) / (0.5 * height);
      float i = maxIter;
      while (zx * zx + zy * zy < 4 && i > 0) {
        float tmp = zx * zx - zy * zy + cX;
        zy = 2.0 * zx * zy + cY;
        zx = tmp;
        i -= 1;
      }
      color c = hsv2rgb(i / maxIter * 360, 1, i > 1 ? 1 : 0);
      set(x, y, c);
    }
  }
  noLoop();
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
