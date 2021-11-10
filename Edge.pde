class Edge{
  PVector[] points;
  
  Edge(PVector p1, PVector p2){
    points = new PVector[]{p1.copy(), p2.copy()};
  }
  
  PVector[] points(){
    return this.points;
  }
  
  boolean equals(Edge e){
    return (this.points[0].equals(e.points()[0]) && this.points[1].equals(e.points()[1])) || (this.points[1].equals(e.points()[0]) && this.points[0].equals(e.points()[1]));
  }
}
