class Tri{
  PVector[] points;
  Edge[] edges;
  
  Tri(PVector p1, PVector p2, PVector p3){
    this.points = new PVector[]{p1, p2, p3};
    this.edges = new Edge[]{new Edge(p1, p2), new Edge(p2, p3), new Edge(p3, p1)};
  }
  
  void display(){
    triangle(points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y);
  }
  
  PVector[] points(){
    return this.points;
  }
  
  Edge[] edges(){
    return this.edges;
  }
  
  PVector average(){
    return new PVector((points[0].x + points[1].x + points[2].x) / 3, (points[0].y + points[1].y + points[2].y) / 3);
  }
  
  PVector circumcenter(){
    float m1 = -1 / ((points[0].y - points[1].y) / (points[0].x - points[1].x));
    float m2 = -1 / ((points[0].y - points[2].y) / (points[0].x - points[2].x));
    
    float y1 = (points[0].y + points[1].y) / 2;
    float y2 = (points[0].y + points[2].y) / 2;
    float x1 = (points[0].x + points[1].x) / 2;
    float x2 = (points[0].x + points[2].x) / 2;
    
    float x = (-(m2 * x2) + y2 + (m1 * x1) - y1) / (m1 - m2);
    float y = m1 * (x - x1) + y1;
    
    return new PVector(x, y);
  }
  
  boolean equals(Tri other){
    ArrayList<PVector> data = new ArrayList<PVector>();
    data.add(other.points()[0].copy());
    data.add(other.points()[1].copy());
    data.add(other.points()[2].copy());
    
    for(int i = this.points.length - 1; i >= 0; i--){
      for(int j = data.size() - 1; j >= 0; j--){
        if(this.points()[i].equals(data.get(j))){
          data.remove(j);
        }
      }
    }
    
    return data.size() == 0;
  }
}
