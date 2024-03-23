package com.github.jasmaa.yahtzee

private const val NUM_GAMES = 1000000
private const val NUM_DICE = 5
private const val NUM_TRIES = 3

/**
 * Simulates chance of getting yahtzee.
 * This project reuses logic from Java yahtzee.
 */
fun main() {
    var numWins = 0
    for (i in 1..NUM_GAMES) {
        val task = SimulationTask(NUM_DICE, NUM_TRIES, 1, 1)
        numWins += task.compute()
    }
    println("Percentage: ${numWins.toFloat() / NUM_GAMES}")
}