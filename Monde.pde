import java.lang.IllegalArgumentException;
import java.util.function.Consumer;

class Monde {
  Cellule[][] cellules;
  final float w; // taille d'1 cellule en pixels
  private final ReglesVie regles;

  Monde(int taille) {
    this(taille, taille);
  }

  Monde(int nbColonnes, int nbLignes, String notationBS) {
    if (nbColonnes < 1 || width < nbColonnes)
      throw new IllegalArgumentException("Nombre de colonnes invalide ("+nbColonnes+"), doit être entre 1 et "+width);
    if (nbLignes < 1 || height < nbLignes)
      throw new IllegalArgumentException("Nombre de lignes invalide ("+nbLignes+"), doit être entre 1 et "+height);

    cellules = new Cellule[nbLignes][nbColonnes];
    w = min(width*1.0 / nbColonnes, height*1.0 / nbLignes);

    for (int y=0; y<nbLignes(); y++)
      for (int x=0; x<nbColonnes(); x++)
          cellules[y][x] = new Cellule(x * w, y * w, w);

    regles = new ReglesVie(notationBS);
    println("Règle : "+regles);
  }

  Monde(int nbColonnes, int nbLignes) {
    this(nbColonnes, nbLignes, "B3/S23");
  }

  void dessiner() {
    for (int y=0; y<nbLignes(); y++)
      for (int x=0; x<nbColonnes(); x++)
          cellules[y][x].dessiner();
  }

  void clear() {
    for (int y=0; y<nbLignes(); y++)
      for (int x=0; x<nbColonnes(); x++)
          cellules[y][x].vivante = false;
  }

  void fillColonnes() {
    for (int y=0; y<nbLignes(); y++)
      for (int x=0; x<nbColonnes(); x++)
        cellules[y][x].vivante = x % 2 == 0;
  }

  void click(float x, float y) {
    int xCellule = (int)(x / w);
    int yCellule = (int)(y / w);
    cellules[yCellule][xCellule].click();
  }

  void fillRandom(float probabilite) {
    if (probabilite < 0 || probabilite > 1 || Double.isNaN(probabilite))
      throw new IllegalArgumentException("Une probabilité doit être un nombre valide entre 0 et 1 inclus, pas " + probabilite);

    for (int y=0; y<nbLignes(); y++)
      for (int x=0; x<nbColonnes(); x++)
        cellules[y][x].vivante = random(1) < probabilite;
  }

  void fillRandom() {
    fillRandom(0.5);
  }

  void check() {
    for (int y=0; y<nbLignes(); y++)
      for (int x=0; x<nbColonnes(); x++)
          checkCellule(x, y);
  }

  void update() {
    for (int y=0; y<nbLignes(); y++)
      for (int x=0; x<nbColonnes(); x++)
          cellules[y][x].update();
  }

  void checkCellule(int x, int y) {
    int nbVoisines = nbVoisines(x, y);

    cellules[y][x].vaVivre = regles.vaVivre(cellules[y][x].vivante, nbVoisines);
  }

  int nbVoisines(int x, int y) {
    int nbVoisines = 0;
    int[] dx = {-1,  0,  1, -1, 1, -1, 0, 1};
    int[] dy = {-1, -1, -1,  0, 0,  1, 1, 1};

    for (int k = 0; k < 8; k++) {
      int x2 = wrapX( x + dx[k] );
      int y2 = wrapY( y + dy[k] );
      if (estVivante(x2, y2))
        nbVoisines++;
    }
    return nbVoisines;
  }

  boolean estVivante(int x, int y) {
    return cellules[y][x].vivante;
  }

  boolean estDedans(int x, int y) {
    return 0 <= y && y < nbLignes() && 0 <= x && x < nbColonnes();
  }

  int wrapX(int x) {
    if (x < 0)
      return nbColonnes() - 1;

    if (x >= nbColonnes())
      return 0;

    return x;
  }

  int wrapY(int y) {
    if (y < 0)
      return nbLignes() - 1;

    if (y >= nbLignes())
      return 0;

    return y;
  }

  int nbColonnes() {
    return cellules[0].length;
  }
  
  int nbLignes() {
    return cellules.length;
  }

  void forEachCell(Consumer<Cellule> consumer) {
    for (int y=0; y<nbLignes(); y++)
      for (int x=0; x<nbColonnes(); x++)
          consumer.accept(cellules[y][x]);
  }
}
