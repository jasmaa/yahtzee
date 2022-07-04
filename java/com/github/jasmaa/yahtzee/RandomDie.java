package com.github.jasmaa.yahtzee;

import java.util.Random;

public class RandomDie implements Die {

  private int value;
  private int numSides = 6;
  private Random rand;

  public RandomDie() {
    this.rand = new Random();
    this.roll();
  }

  public int getValue() {
    return value;
  }

  public void roll() {
    this.value = rand.nextInt(numSides) + 1;
  }
}