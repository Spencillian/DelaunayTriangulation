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
      for(int j = 0; j < polygon.size(); j++){
        boolean match = false;
        for(int k = polygon.size() - 1; k > j; k--){
          if(polygon.get(j).equals(polygon.get(k))){
            polygon.remove(k);
            match = true;
          }
        }
        if(match){
          polygon.remove(j);
          j--;
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
    
    for(int i = triangles.size() - 1; i >= 0; i--){
      for(int j = 0; j < 3; j++){

        // Ever heard of using mutliple lines /jesus fuck/
        if(triangles.get(i).points()[j].equals(new PVector(-1, -1)) || triangles.get(i).points()[j].equals(new PVector(width * 2, 0)) || triangles.get(i).points()[j].equals(new PVector(0, height * 2))){
          triangles.remove(i);
        }
      }
    }
  }
  
  boolean inCircle(PVector center, PVector edge, PVector loc){
    return center.copy().sub(loc).magSq() < center.copy().sub(edge).magSq();
  }
  
  void display(){
    for(int i = 0; i < triangles.size(); i++){
      triangles.get(i).display();
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
