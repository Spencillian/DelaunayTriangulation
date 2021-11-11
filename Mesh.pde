class Mesh{
  ArrayList<Tri> triangles = new ArrayList<Tri>();
  PVector[] points;
  
  Mesh(PVector[] points){
    this.points = points;
    
    triangles.add(new Tri(new PVector(-1, -1), new PVector(width * 2, 0), new PVector(0, height * 2)));
    
    for(int i = 0; i < this.points.length; i++){
      ArrayList<Tri> badTriangles = new ArrayList<Tri>();
      
      for(int j = 0; j < triangles.size(); j++){
        if(inCircle(triangles.get(j).circumcenter(), triangles.get(j).points()[0], points[i])){
           badTriangles.add(triangles.get(j));
        }
      }
      
      ArrayList<Edge> polygon = listEdges(badTriangles);
      for(int j = polygon.size() - 1; j >= 0; j--){
        boolean match = false;
        for(int k = polygon.size() - 1; k > j; k--){
          if(polygon.get(j).equals(polygon.get(k))){
            polygon.remove(k);
            match = true;
          }
        }
        if(match){
          polygon.remove(j);
        }
      }
      
      for(int j = 0; j < badTriangles.size(); j++){
        for(int k = triangles.size() - 1; k >= 0; k--){
          if(badTriangles.get(j).equals(triangles.get(k))){
            triangles.remove(k);
          }
        }
      }
      
      for(int j = 0; j < polygon.size(); j++){
        triangles.add(new Tri(polygon.get(j).points()[0], polygon.get(j).points()[1], points[i]));
      }
    }
    
    for(int i = triangles.size() - 1; i >= 0; i--){ // Somehow this loop can go out of bounds...? not sure if it's worth figuring out why
      for(int j = 0; j < 3; j++){

        // Ever heard of using mutliple lines /jesus fuck/
        if(triangles.get(i).points()[j].equals(new PVector(-1, -1)) || triangles.get(i).points()[j].equals(new PVector(width * 2, 0)) || triangles.get(i).points()[j].equals(new PVector(0, height * 2))){
          triangles.remove(i);
          break;
        }
      }
    }
  }
  
  boolean inCircle(PVector center, PVector edge, PVector loc){
    return center.copy().sub(loc).magSq() < center.copy().sub(edge).magSq();
  }
  
  void displayDelaunay(){
    for(int i = 0; i < triangles.size(); i++){
      
      pushStyle();
      if(triangles.get(i).average().dist(new PVector(width/2, height/2)) < 400){
        fill(255, 0, 0);
      }else{
        fill(255);
      }
      
      triangles.get(i).display();
      
      popStyle();
    }
  }
  
  void displayVoronoi(){
    for(int i = 0; i < triangles.size(); i++){
      //triangles.get(i).display();
      for(int j = 0; j < triangles.get(i).edges.length; j++){
        line(triangles.get(i).circumcenter().x, triangles.get(i).circumcenter().y, (triangles.get(i).edges[j].points[0].x + triangles.get(i).edges[j].points[1].x) / 2, (triangles.get(i).edges[j].points[0].y + triangles.get(i).edges[j].points[1].y) / 2);
        ellipse(triangles.get(i).circumcenter().x, triangles.get(i).circumcenter().y, 10, 10);
      }
    }
  }
  
  ArrayList<Edge> listEdges(ArrayList<Tri> triangle){
    ArrayList<Edge> out = new ArrayList<Edge>();
    for(Tri t : triangle){
      for(int j = 0; j < 3; j++){
        out.add(t.edges[j]);
      }
    }
    
    return out;
  }
      
  
}
