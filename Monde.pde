class Monde {
  Cellule[][] cellules;
  int w; // taille d'1 cellule

  Monde(int taille) {
    cellules = new Cellule[taille][taille];
    w = min(width, height) / taille;

    for (int i=0; i<taille; i++) {
      for (int j=0; j<taille; j++) {
          cellules[i][j] = new Cellule(i * w, j * w, w);
      }
    }
  }

  void dessiner() {
    for (int i=0; i<taille; i++) {
      for (int j=0; j<taille; j++) {
          cellules[i][j].dessiner();
      }
    }
  }

  void clear() {
    for (int i=0; i<taille; i++) {
      for (int j=0; j<taille; j++) {
          cellules[i][j].vivante = false;
      }
    }
  }

  void colonnes() {
    for (int i=0; i<taille; i++) {
      for (int j=0; j<taille; j++) {
        cellules[i][j].vivante = i % 2 == 0;;
      }
    }
  }

  void click() {
    int i = mouseX / w;
    int j = mouseY / w;
    cellules[i][j].click();
  }

  void check() {
    for (int i=0; i<taille; i++) {
      for (int j=0; j<taille; j++) {
          checkCellule(i, j);
      }
    }
  }

  void update() {
    for (int i=0; i<taille; i++) {
      for (int j=0; j<taille; j++) {
          cellules[i][j].update();
      }
    }
  }

  void checkCellule(int i, int j) {
    int nbVoisines = 0;
    int[] di = {-1,  0,  1, -1, 1, -1, 0, 1};
    int[] dj = {-1, -1, -1,  0, 0,  1, 1, 1};

    for (int k = 0; k < 8; k++) {
      int i2 = wrap( i + di[k] );
      int j2 = wrap( j + dj[k] );
      if ( estDedans(i2, j2) ) {
        if ( estVivante(i2, j2) ) {
          nbVoisines++;
        }
      }
    }

    if ( estVivante(i, j) ) {
      if (nbVoisines < 2 || 3 < nbVoisines) {
        cellules[i][j].vaVivre = false;
      }
      else {
        cellules[i][j].vaVivre = true;
      }
    }
    else {
      if (nbVoisines == 3) {
        cellules[i][j].vaVivre = true;
      }
      else {
        cellules[i][j].vaVivre = false;
      }
    }
  }

  boolean estVivante(int i, int j) {
    return cellules[i][j].vivante;
  }

  boolean estDedans(int i, int j) {
    return 0 <= i && i < taille && 0 <= j && j < taille;
  }

  int wrap(int i) {
    if (i < 0) {
      return taille - 1;
    }
    if (i >= taille) {
      return 0;
    }
    return i;
  }
}
