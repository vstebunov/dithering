PImage img;

int[] range(int start, int end) {
  int[] r = new int[end + 1];
  for (int i = 0; i <= end; i = i + 1) {
    r[i] = i;
  }
  return r;
}

float[] make_map(int size) {
  int s = size * size;
  int[] r = range(0, s - 1);
  float[] result = new float[s];
  int i = 0;
  for (int p : r) {
    int q = p ^ (p >> 3);    
    result[i] = (((p & 4) >> 2) | ((q & 4) >> 1)
          | ((p & 2) << 1) | ((q & 2) << 2)
          | ((p & 1) << 4) | ((q & 1) << 5)) / 64.0;    
    i = i + 1;
  }  
  return result;
}

int findClosestPaletteColorZX(int c, float map_value, int thresold) {
  float r = red(c) + map_value * thresold;
  float g = green(c) + map_value * thresold;
  float b = blue(c) + map_value * thresold;
  /*
  r = red(c);
  g = green(c);
  b = blue(c);
  */
  float m = max(r,g,b);
  
  if (m < 0xD7) {
    r = 0;
    g = 0;
    b = 0;
  } else if (m != 0xFF) {
    r = r >= 0xD7 ? 0xD7 : 00;
    g = g >= 0xD7 ? 0xD7 : 00;
    b = b >= 0xD7 ? 0xD7 : 00;
  }
  
  return color( r, g, b);
}

PImage ditherImage(PImage img) {
  
  float[] map = make_map(8);
  int thresold = 256 / 2;
  
  img.loadPixels();        
  for (int y = 0; y < img.height-1; y = y + 1) {
    for (int x = 0; x < img.width-1; x = x + 1) {      
      float map_value = map[(x & 7) + ((y & 7) << 3)];
      int old_pixel = img.pixels[x + y * img.width];      
      int new_pixel = findClosestPaletteColorZX(old_pixel, map_value, thresold);
      img.pixels[x + y * img.width] = new_pixel;      
    }
  }
  
  img.updatePixels();
  
  return img;
}

void setup() {
  size(648, 655);  
  
  img = loadImage("test.jpeg");
  img = ditherImage(img);   
  image(img, 0, 0);
  
  img.save("result.jpeg");
}

void draw() {
}
