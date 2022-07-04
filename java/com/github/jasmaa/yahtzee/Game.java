package com.github.jasmaa.yahtzee;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.stream.Collectors;

public class Game implements Callable<Boolean> {

  private final int NUM_DICE;
  private final int NUM_TRIES;
  private List<Die> dice;
  private final Statistics<Integer> statistics;

  public Game(int numDice, int numTries) {
    this.NUM_DICE = numDice;
    this.NUM_TRIES = numTries;
    this.dice = new ArrayList<Die>();
    for (int i = 0; i < NUM_DICE; i++) {
      this.dice.add(new RandomDie());
    }
    this.statistics = new Statistics<Integer>();
  }

  public Boolean call() {
    for (int i = 0; i < NUM_TRIES; i++) {
      Statistics<Integer>.ModeResult modeResult = findDiceMode();
      int mostCommon = modeResult.getValue();
      int mostCommonFreq = modeResult.getCount();
      if (mostCommonFreq == NUM_DICE) {
        return true;
      }
      for (int j = 0; j < NUM_DICE; j++) {
        if (dice.get(j).getValue() != mostCommon) {
          dice.get(j).roll();
        }
      }
    }
    return false;
  }

  private Statistics<Integer>.ModeResult findDiceMode() {
    List<Integer> diceValues = dice.stream()
        .map((die) -> die.getValue())
        .collect(Collectors.toList());
    return statistics.mode(diceValues);
  }
}
