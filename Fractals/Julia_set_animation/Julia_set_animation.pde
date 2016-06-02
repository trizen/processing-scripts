// Animation of the Julia set
// See: https://en.wikipedia.org/wiki/Julia_set

void setup() {
  size(640, 480);
}

float cX = -0.618;
float cY = 0;
float zx, zy;
float maxIter = 50;

float xmin = 0.005;
float xmax = 0.01;

float ymin = 0.005;
float ymax = 0.02;

float xiter = -random(xmin, xmax);
float yiter = +random(ymin, ymax);

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

  cX += xiter;
  cY += yiter;

  if (abs(cX) + abs(cY) >= 2.0) {
    xiter = random(xmin, xmax) * (cX < 0 ? 1 : -1);
    yiter = random(ymin, ymax) * (cY < 0 ? 1 : -1);
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