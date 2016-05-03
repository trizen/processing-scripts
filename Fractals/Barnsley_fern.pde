
// See: http://rosettacode.org/wiki/Barnsley_fern
//      https://en.wikipedia.org/wiki/Barnsley_fern

void setup() {
  size(1920, 1080);
  background(0, 0, 0);
}

float x = 0;
float y = 0;

void draw() {
  for (int i = 0; i < 100000000; i++) {

    float xt = 0;
    float yt = 0;

    float r = random(1000);

    if (r <= 1) {
      xt = 0;
      yt = 0.16*y;
    } else if (r <= 8) {
      xt = 0.20*x - 0.26*y;
      yt = 0.23*x + 0.22*y + 1.60;
    } else if (r <= 15) {
      xt = -0.15*x + 0.28*y;
      yt =  0.26*x + 0.24*y + 0.44;
    } else {
      xt =  0.85*x + 0.04*y;
      yt = -0.04*x + 0.85*y + 1.60;
    }

    x = xt;
    y = yt;

    int m = round(width/2 + height/10*x);
    int n = height - round(height/10*y);

    set(m, n, #00ff00);
  }
  noLoop();
}
