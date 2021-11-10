void setup(){
  size(1000, 1000);
  
  noFill();
  
  PVector[] points = new PVector[100];
  for(int i = 0; i < points.length; i++){
    points[i] = new PVector(random(width), random(height));
    ellipse(points[i].x, points[i].y, 10, 10);
  }
  
  println("Meshing");
  Mesh m = new Mesh(points);
  m.display();
  println("Done");
}

void draw(){
  
}
