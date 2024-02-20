// Interpréteur de notation B/S, tel qu'expliqué là :
// https://conwaylife.com/wiki/Rulestring#B/S_notation
// Convertit une chaîne de caractères B/S en tableau d'états : état final d'une cellule en fonction de son état initial et de son nombre de voisins.
// et vice versa.

// NB: pour B/S -> tableau, la notation est souple
// - séparateur "/" n'importe où. B/3S//4/5/ = B3/S45
// - insensible à la casse             b1/s1 = B1S1
// - redondance acceptée           B1/S55555 = B1/S5
// - passages de B à S              S2B2S345 = B2/S2345
// - ordre indifférent             B312/S876 = B123/S678
// Mais pour tableau -> B/S, résultat toujours identique

public final class BSNotationParser {
  private BSNotationParser(){} // privé pour ne pas pouvoir instancier la classe

  public static final int MAX_VOISINS_DEFAUT = 8;

  public static boolean[][] parse(String s, int maxVoisins) {
    if (s == null || s.isEmpty())
      throw new IllegalArgumentException("La notation ne peut pas être nulle ou vide");
    if (maxVoisins <= 0)
      throw new IllegalArgumentException("Le nombre maximum de voisins doit être supérieur à 0 (pas "+maxVoisins+")");
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
      else if (c == '/' || c == ' ') {
        /* Ne rien faire, séparateur valide */}
      else
        throw new IllegalArgumentException("Caractère invalide '"+c+"' dans la notation "+s+",en position "+idChar);
    }
    
    return etats;
  }

  public static boolean[][] parse(String s) {
    return parse(s, MAX_VOISINS_DEFAUT);
  }

  public static String reverseParse(boolean[][] etats) {
    if(etats.length != 2)
      throw new IllegalArgumentException("Un tableau d'états valide doit avoir 2 lignes, ici il y en a "+etats.length);

    StringBuilder sb = new StringBuilder("B");
    for(int nbVoisins = 0; nbVoisins < etats[0].length; nbVoisins++)
      if(etats[0][nbVoisins] == true)
        sb.append(nbVoisins);

    sb.append("/S");
    for(int nbVoisins = 0; nbVoisins < etats[1].length; nbVoisins++)
      if(etats[1][nbVoisins] == true)
        sb.append(nbVoisins);

    return sb.toString();
  }
}
