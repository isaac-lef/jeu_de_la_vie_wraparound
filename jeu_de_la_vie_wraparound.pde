// Espace pour mettre en pause
// ↑ pour augmenter la vitesse
// ↓ pour diminuer la vitesse
// C pour effacer tout (clear)
// D pour colorier une colonne sur deux
// R pour colorier les cellules au hasard (probabilité de 1/2)

final int     NB_COLONNES    = 100;
final int     NB_LIGNES      = 100;
final boolean DESSINE_GRILLE = false;
final color   COULEUR_GRILLE = color(200);
final String  REGLES_BS      = "B3/S23";
// Pour essayer d'autres règles : https://conwaylife.com/wiki/List_of_Life-like_cellular_automata

boolean pause = false;
int lenteur = 10;
Monde monde;

void setup() {
  size(800, 800);
  rectMode(CORNER);
  monde = new Monde(NB_COLONNES, NB_LIGNES, REGLES_BS);
  monde.fillRandom(0.5);
  if (DESSINE_GRILLE)
    stroke(COULEUR_GRILLE);
  else
    noStroke();
}

void draw() {
  if (!pause && frameCount % lenteur == 0) {
    monde.check();
    monde.update();
  }
  monde.dessiner();
  
  // inverser case au hasard
  //monde.click(random(monde.w * monde.nbColonnes()), random(monde.w * monde.nbLignes()));
}

void keyPressed() {
  if (key == ' ') {
    pause = !pause;
  }
  else if (key == 'c') {
    monde.clear();
  }
  else if (keyCode == UP && lenteur > 1) {
    lenteur--;
  }
  else if (keyCode == DOWN) {
    lenteur++;
  }
  else if (key == 'd') {
    monde.fillColonnes();
  }
  else if (key == 'r') {
    monde.fillRandom();
  }
}

void mouseReleased() {
  monde.click(mouseX, mouseY);
}
