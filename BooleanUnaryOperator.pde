enum BooleanUnaryOperator {
  TRUE {
    @Override
    boolean apply(boolean b) {
      return true;
    }
  },
  FALSE {
    @Override
    boolean apply(boolean b) {
      return false;
    }
  },
  IDENTITY {
    @Override
    boolean apply(boolean b) {
      return b;
    }
  },
  COMPLEMENT {
    @Override
    boolean apply(boolean b) {
      return !b;
    }
  };

  abstract boolean apply(boolean b);
  
  static BooleanUnaryOperator get(boolean resultWhenFalse, boolean resultWhenTrue) {
    if (resultWhenFalse)
      if (resultWhenTrue)
        return TRUE;
      else
        return COMPLEMENT;
    else
      if (resultWhenTrue)
        return IDENTITY;
      else
        return FALSE;
  }
}
