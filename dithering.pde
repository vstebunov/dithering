PImage img;

int findClosestPaletteColor(int c) {  
  int b = c / 255;
  return  color(b, b, b);
}

void setup() {
  size(750, 785);  
    
  img = loadImage("test.jpg");
  
  //img.resize(320,0);
  
  img.loadPixels();        
  for (int y = 0; y < img.height-1; y = y + 1) {
    for (int x = 0; x < img.width-1; x = x + 1) {
      int old_pixel = img.pixels[x + y * img.width];
      int new_pixel = findClosestPaletteColor(old_pixel);    
      
      img.pixels[x + y * img.width] = new_pixel;
      
      int quant_error = old_pixel - new_pixel;
      img.pixels[x + 1 + y * img.width]       = img.pixels[x + 1 + y * img.width]       + quant_error * 7 / 16;      
      img.pixels[x - 1 + (y + 1) * img.width] = img.pixels[x - 1 + (y + 1) * img.width] + quant_error * 3 / 16;      
      img.pixels[x     + (y + 1) * img.width] = img.pixels[x     + (y + 1) * img.width] + quant_error * 5 / 16;
      img.pixels[x + 1 + (y + 1) * img.width] = img.pixels[x + 1 + (y + 1) * img.width] + quant_error * 1 / 16;      
    }
  }
  
  img.updatePixels();
  
 
}

void draw() {
   image(img, 0, 0);
}