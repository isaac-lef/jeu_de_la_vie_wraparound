// Espace pour mettre en pause
// c pour effacer tout (clear)
// touche haut pour augmenter la vitesse,
// touche bas pour diminuer la vitesse.
// touche d pour colorier 1 colonne /2

int taille = 30;
Monde monde;
boolean pause = false;
int lenteur = 10;

void setup() {
  size(900, 900);
  rectMode(CORNER);

  monde = new Monde(taille);
}

void draw() {
  if (!pause) {
    if (frameCount % lenteur == 0) {
      monde.check();
      monde.update();
    }
  }
  monde.dessiner();
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
    println(lenteur);
  }
  else if (key == 'd') {
    monde.colonnes();
  }
}

void mouseReleased() {
  monde.click();
}
