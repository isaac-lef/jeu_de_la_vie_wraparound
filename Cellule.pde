class Cellule {
  int x, y;     // coordonnées du sommet supérieur droit
  int c;        // taille d'un côté
  boolean vivante;
  boolean vaVivre;

  Cellule(int x, int y, int c) {
    this.x = x;
    this.y = y;
    this.c = c;
    if (int(random(2)) == 1) {
      vivante = true;
    } else {
      vivante = false;
    }
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
