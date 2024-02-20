// https://conwaylife.com/wiki/Rulestring#B/S_notation

public final static class BSNotationParser {
  private BSNotationParser(){} // privé pour ne pas pouvoir instancier la classe

  public static final int MAX_VOISINS_DEFAUT = 8;

  public static BooleanUnaryOperator[] parse(String s, int maxVoisins) {
    if (s == null || s.isEmpty())
      throw new IllegalArgumentException("La notation ne peut pas être nulle ou vide");
    if (maxVoisins <= 0)
      throw new IllegalArgumentException("Le nombre maximum de voisins doit être supérieur à 0 (pas "+maxVoisins+")d");
    if (maxVoisins >= 10)
      throw new IllegalArgumentException("La notation B/S ne concerne que les chiffres, donc ne s'applique pas au dessus de 9 voisins (ici "+maxVoisins+")");

    // On parcourt la chaîne de caractères en remplissant un tableau à 2 dimensions : état initial (0 ou 1), nombre de voisins.
    boolean[][] etats = new boolean[2][maxVoisins+1];
    int ligne = 0;
    char c = s.charAt(0);
    if (c != 'B' && c != 'b' && c != 'S' && c != 's')
      throw new IllegalArgumentException("Notation invalide : "+s+"\nLa Notation B/S doit commencer par un B ou un S");

    for (int idChar = 0; idChar < s.length(); idChar++) {
      c = s.charAt(idChar);
      if (c == 'B' || c == 'b')
        ligne = 0;
      else if (c == 'S' || c == 's')
        ligne = 1;
      else if (Character.isDigit(c))
        etats[ligne][Character.digit(c,10)] = true;
      else if (c == '/') {
        /* Ne rien faire, séparateur valide */}
      else
        throw new IllegalArgumentException("Caractère invalide '"+c+"' dans la notation "+s+",en position "+idChar);
    }
    for (int i = 0; i < etats.length; i++) {
      for (int j = 0; j < etats[i].length; j++) {
        print(etats[i][j] + ",");
      }
      println();
    }
    
    // On convertit ce tableau en tableau d'opérateurs booléens unaires, pour économiser 1 ligne.
    BooleanUnaryOperator[] resultat = new BooleanUnaryOperator[maxVoisins+1];
    for (int i = 0; i < resultat.length; i++)
      resultat[i] = BooleanUnaryOperator.get(etats[0][i], etats[1][i]);

    return resultat;
  }

  public static BooleanUnaryOperator[] parse(String s) {
    return parse(s, MAX_VOISINS_DEFAUT);
  }
}
