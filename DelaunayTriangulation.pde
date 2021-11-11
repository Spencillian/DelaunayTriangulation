PVector[] points;
PVector[] directions;
Mesh m;

void setup(){
  //size(1000, 1000);
  fullScreen();
  frameRate(30);
  strokeWeight(3);
  strokeJoin(ROUND);
  strokeCap(ROUND);
  noFill();
  
  points = new PVector[100];
  for(int i = 0; i < points.length; i++){
    points[i] = new PVector(random(width), random(height));
    //ellipse(points[i].x, points[i].y, 10, 10);
  }
  
  directions = new PVector[100];
  for(int i = 0; i < directions.length; i++){
    directions[i] = new PVector(random(-5, 5), random(-5, 5));
    //ellipse(points[i].x, points[i].y, 10, 10);
  }
  
  m = new Mesh(points);
  m.displayDelaunay();
  
  saveFrame("out.png");
}

void draw(){
  background(255);
  for(int i = 0; i < points.length; i++){
    points[i].add(directions[i]);
    
    if(points[i].x > width){
      points[i].x -= width;
    }
    
    if(points[i].y > height){
      points[i].y -= height;
    }
    
    if(points[i].x < 0){
      points[i].x += width;
    }
    
    if(points[i].y < 0){
      points[i].y += height;
    }
    
    
    //ellipse(points[i].x, points[i].y, 10, 10);
  }
  
  m = new Mesh(points);
  //m.displayDelaunay();
  m.displayVoronoi();
}
