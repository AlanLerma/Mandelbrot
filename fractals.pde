float suma = 0;
boolean arriba, abajo, izquierda, derecha;
float horizontal = 0;
float vertical = 0;

void setup() {
  size(640, 480);
}
void draw() {
  background(255);
  
  
  loadPixels(); //Para hacer analisis a cada pixel
  //creamos una variable para la anchura y la altura que nos ayudaran a desplazarnos
  if (mousePressed && mouseButton == LEFT){
   suma = suma-0.1;
  }  
   if (mousePressed && mouseButton == RIGHT){
   suma = suma+0.1;
  }
 
  
  float w = 3.5+suma;
  float h = (w * height) / width; //damos proporción a la figura en base a w
  
  if (arriba){
  vertical = vertical -0.01;
  }
  if (abajo){
  vertical = vertical +0.01;
  }
  if (izquierda){
  horizontal = horizontal -0.01;
  }
  if (derecha){
  horizontal = horizontal +0.01;
  }
  
  // Lo posicionamos en el centro
  float xmin = -w/2 +horizontal; //horizontal
  float ymin = -h/2 +vertical; //vertical

  float xmax = xmin + w;

  // y goes from ymin to ymax
  float ymax = ymin + h;

  // Calculamos el incremento de cada pixel
  float dx = (xmax - xmin) / (width);
  float dy = (ymax - ymin) / (height);


  
  //Harémos analisis a cada pixel
  float y = ymin;
  for (int j = 0; j < height; j++) {  //para cadapixel en Y
    float x = xmin;
    for (int i = 0; i < width; i++) { //para cadapixel en X

      //Dado los conjuntos de Julia z = z^2 + c, donde veremos si se llega al infinito
      float a = x;
      float b = y;
      int n = 0;
      while (n < 100) {
        float acuadrada = a * a;
        float bcuadrada = b * b;
        float dosab = 2 * a * b;
        //dados las formulas, sustituimos a como a = a^2 - b^2 + x
        a = acuadrada - bcuadrada + x;
        b = dosab + y;
        
        //definimos infinito
        if (a*a + b*b > 100) {
          break;   
        }
        n++;
      }
 
     //Decidimos los colores cuando tiende a infinito y cuando no
      if (n == 100) {
        pixels[i+j*width] = color(0);
      } else {
        pixels[i+j*width] = color(254,250,120);
      }
      x += dx;
    }
    y += dy;
  }
  updatePixels();
   pushMatrix();
  fill(100,100,250);
  rect(15,5,220,46);
  fill(255);
  text("Click derecho e izquierdo para zoom",20,20);
  text("Direccionales para moverte",20,40);
  popMatrix();
}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      arriba = true;
    }
    if (keyCode == DOWN) {
      abajo = true;
    }
     if (keyCode == LEFT) {
      izquierda = true;
    }  
     if (keyCode == RIGHT) {
      derecha = true;
    }   
  }
}


void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      arriba = false;
    }
    if (keyCode == DOWN) {
      abajo = false;
    }
     if (keyCode == LEFT) {
      izquierda = false;
    }  
     if (keyCode == RIGHT) {
      derecha = false;
    }   
  }
}
