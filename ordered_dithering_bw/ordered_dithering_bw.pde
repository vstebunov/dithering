PImage img;

float[] make_map() {
  /**/
  float[] map = new float[16];
  map[0] = 1.0 / 17;
  map[1] = 9.0 / 17;
  map[2] = 3.0 / 17;
  map[3] = 11.0 / 17;
  map[4] = 14.0 / 17;
  map[5] = 5.0 / 17;
  map[6] = 16.0 / 17;
  map[7] = 7.0 / 17;
  map[8] = 4.0 / 17;
  map[9] = 12.0 / 17;
  map[10] = 2.0 / 17;
  map[11] = 10.0 / 17;
  map[12] = 16.0 / 17;
  map[13] = 8.0 / 17;
  map[14] = 14.0 / 17;
  map[15] = 6.0 / 17;
  
  /*
  float[] map = new float[4];
  map[0] = 1.0 / 4;
  map[1] = 3.0 / 4;
  map[2] = 2.0 / 4;
  map[3] = 4.0 / 4;
  */
  return map;
}

int findClosestPaletteColorBW(int c, float map_value, float thresold) {
  color p = color(brightness(c) + map_value * thresold);
  if (brightness(p) < 128) {
    return color(0,0,0);
  } else {    
    //println(brightness(c));
    return color(255,255,255);
  }
}

PImage ditherImage(PImage img) {  
  float[] map = make_map();
  float thresold = 255.0 / 5;  
  img.loadPixels();        
  for (int y = 0; y < img.height; y = y + 1) {
    for (int x = 0; x < img.width; x = x + 1) {     
      float map_value = map[(x & 3) + ((y & 3) << 2)];
      //float map_value = map[(x & 1) + (y & 1)];
      int old_pixel = img.pixels[x + y * img.width];      
      int new_pixel = findClosestPaletteColorBW(old_pixel, map_value, thresold);
      img.pixels[x + y * img.width] = new_pixel;      
    }
  }
  
  img.updatePixels();
  
  return img;
}

void setup() {
  size(648, 655);  
  String image_name = "test.jpeg";   
  img = loadImage(image_name);
  img = ditherImage(img);   
  image(img, 0, 0);
  
  noLoop();
  noStroke();
  noSmooth();
  
  img.save("result.jpeg");
}

void draw() {
}
