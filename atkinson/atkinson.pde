PImage img;

int findClosestPaletteColor(int c) {  
  int b = c / 255;
  return  color(b, b, b);
}

void setup() {
  size(648, 655);  
    
  img = loadImage("test.jpeg"); 
  img.loadPixels();        
  for (int y = 0; y < img.height-1; y = y + 1) {
    for (int x = 0; x < img.width-1; x = x + 1) {
      int old_pixel = img.pixels[x + y * img.width];
      int new_pixel = findClosestPaletteColor(old_pixel);    
      
      img.pixels[x + y * img.width] = new_pixel;
      
      int quant_error = old_pixel - new_pixel;
      img.pixels[x + 1 + y       * img.width] = img.pixels[x + 1 + y * img.width] + quant_error * 1 / 8;      
      img.pixels[x + 2 + y       * img.width] = img.pixels[x + 2 + y * img.width] + quant_error * 1 / 8;      
      img.pixels[x - 1 + (y + 1) * img.width] = img.pixels[x - 1 + (y + 1) * img.width] + quant_error * 1 / 8;      
      img.pixels[x     + (y + 1) * img.width] = img.pixels[x     + (y + 1) * img.width] + quant_error * 1 / 8;
      img.pixels[x + 1 + (y + 1) * img.width] = img.pixels[x + 1 + (y + 1) * img.width] + quant_error * 1 / 8; 
      if (y+2 < img.height) {
        img.pixels[x     + (y + 2) * img.width] = img.pixels[x     + (y + 2) * img.width] + quant_error * 1 / 8;
      }
    }
  }
  
  
  
  img.updatePixels();
  img.save("result.jpeg");
}

void draw() {
   image(img, 0, 0);
}
