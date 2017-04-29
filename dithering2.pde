PImage img;

int findClosestPaletteColorZX(int c) {
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  
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
  img.loadPixels();        
  for (int y = 0; y < img.height-1; y = y + 1) {
    for (int x = 0; x < img.width-1; x = x + 1) {
      int old_pixel = img.pixels[x + y * img.width];      
      int new_pixel = findClosestPaletteColorZX(old_pixel);
      img.pixels[x + y * img.width] = new_pixel;      
    }
  }
  
  img.updatePixels();
  
  return img;
}

void setup() {
  size(1024, 768);  
  
  img = loadImage("test4.jpg");
  img = ditherImage(img);   
  image(img, 0, 0, 1024, 768);
}

void draw() {
}