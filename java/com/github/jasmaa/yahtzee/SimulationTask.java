package com.github.jasmaa.yahtzee;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.RecursiveTask;

public class SimulationTask extends RecursiveTask<Integer> {

  private int numDice;
  private int numTries;
  private long numSimulations;
  private long maxNumSimulations;

  public SimulationTask(int numDice, int numTries, long numSimulations, long maxNumSimulations) {
    this.numDice = numDice;
    this.numTries = numTries;
    this.numSimulations = numSimulations;
    this.maxNumSimulations = maxNumSimulations;
  }

  protected Integer compute() {
    if (numSimulations > maxNumSimulations) {
      long childNumSimulations1 = numSimulations / 2;
      long childNumSimulations2 = numSimulations - childNumSimulations1;
      SimulationTask childTask1 = new SimulationTask(numDice, numTries, childNumSimulations1, maxNumSimulations);
      SimulationTask childTask2 = new SimulationTask(numDice, numTries, childNumSimulations2, maxNumSimulations);
      childTask1.fork();
      try {
        return childTask1.get() + childTask2.invoke();
      } catch (InterruptedException e) {
        e.printStackTrace();
      } catch (ExecutionException e) {
        e.printStackTrace();
      }
      return null;
    } else {
      int numWins = 0;
      for (int i = 0; i < numSimulations; i++) {
        Game game = new Game(numDice, numTries);
        if (game.call()) {
          numWins++;
        }
      }
      return numWins;
    }
  }

}
