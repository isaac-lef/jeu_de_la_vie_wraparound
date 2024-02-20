public class ReglesVie {
  private final boolean[][] tableauVieVoisins;

  public ReglesVie(int maxVoisins) {
    tableauVieVoisins = new boolean[2][maxVoisins+1];
  }

  public ReglesVie(String notationBS) {
    tableauVieVoisins = BSNotationParser.parse(notationBS).tableauVieVoisins;
  }

  public void setEtatFinal(boolean etatInitial, int nbVoisins, boolean etatFinal) {
    tableauVieVoisins[etatInitial ? 1 : 0][nbVoisins] = etatFinal;
  }

  public boolean vaVivre(boolean etatInitial, int nbVoisins) {
    return tableauVieVoisins[etatInitial ? 1 : 0][nbVoisins];
  }

  public int maxVoisins() {
    return tableauVieVoisins[0].length;
  }

  @Override
  public String toString() {
    return BSNotationParser.reverseParse(this);
  }
}

//                      nombre de voisins
//             ┌───┬───┬───┬───┬───┬───┬───┬───┬───┐
//             │ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 8 │
//         ┌───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
//         │ 0 │...│...│...│...│...│...│...│...│...│
//  état   ├───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
// initial │ 1 │...│...│...│...│...│...│...│...│...│
//         └───┴───┴───┴───┴───┴───┴───┴───┴───┴───┘
//
// Tableau des états finaux en fonction de l'état initial et du nombre de voisins
// (0 = cellule morte, 1 = cellule en vie)
