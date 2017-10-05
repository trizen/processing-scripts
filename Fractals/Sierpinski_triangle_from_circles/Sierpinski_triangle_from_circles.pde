// Processing version of Daniel Shiffman's code.
// https://www.youtube.com/watch?v=jPsZwrV9ld0

 void setup() {
   size(1000, 1000);
   background(0);
   stroke(255);
   noFill();
   drawCircle(width/2, height/2, (width+height)/4);
}

void drawCircle (float x, float y, float d) {
  ellipse(x, y, d, d);

  if (d > 3) {
   drawCircle(x + d*0.5, y, d*0.5);
   drawCircle(x - d*0.5, y, d*0.5);
   drawCircle(x, y - d*0.5, d*0.5);
   //drawCircle(x, y + d*0.5, d*0.5);
  }
}
