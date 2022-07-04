package com.github.jasmaa.yahtzee;

import java.util.concurrent.ForkJoinPool;

public class Yahtzee {

  private final static int NUM_GAMES = 1000000;
  private final static int NUM_DICE = 5;
  private final static int NUM_TRIES = 3;

  public static void main(String[] args) {
    ForkJoinPool pool = ForkJoinPool.commonPool();
    SimulationTask task = new SimulationTask(NUM_DICE, NUM_TRIES, NUM_GAMES, 10000);
    int numWins = pool.invoke(task);
    System.out.printf("Percentage: %f", (float) numWins / NUM_GAMES);
  }
}