class Cellule {
  float x, y;     // coordonnées du sommet supérieur droit
  float c;        // taille d'un côté
  boolean vivante;
  boolean vaVivre;

  Cellule(float x, float y, float c) {
    this.x = x;
    this.y = y;
    this.c = c;
    vivante = false;
  }
  
  void click() {
    vivante = !vivante;
  }
  
  void update() {
    vivante = vaVivre;
  }

  void dessiner() {
    if (vivante) {
      fill(0);
    } else {
      fill(255);
    }

    rect(x, y, c, c);
  }
}
