package com.github.jasmaa.yahtzee;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class Statistics<T> {

  class ModeResult {
    private T value;
    private int count;

    public ModeResult(T value, int count) {
      this.value = value;
      this.count = count;
    }

    public T getValue() {
      return value;
    }

    public int getCount() {
      return count;
    }
  }

  public ModeResult mode(Collection<T> collection) {
    Map<T, Integer> m = new HashMap<T, Integer>();
    Iterator<T> iterator = collection.iterator();
    while (iterator.hasNext()) {
      T currentValue = iterator.next();
      if (m.containsKey(currentValue)) {
        m.put(currentValue, m.get(currentValue) + 1);
      } else {
        m.put(currentValue, 1);
      }
    }
    T mostCommon = null;
    int mostCommonFreq = 0;
    for (Map.Entry<T, Integer> entry : m.entrySet()) {
      if (entry.getValue() > mostCommonFreq) {
        mostCommonFreq = entry.getValue();
        mostCommon = entry.getKey();
      }
    }
    return new ModeResult(mostCommon, mostCommonFreq);
  }
}
