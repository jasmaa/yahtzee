package main

import (
	"fmt"
	"math/rand"
	"time"
)

func countUnique[T comparable](l []T) int {
	m := make(map[T]struct{})
	for _, v := range l {
		m[v] = struct{}{}
	}
	return len(m)
}

func mode[T comparable](l []T) T {
	m := make(map[T]int)
	for _, v := range l {
		if _, ok := m[v]; ok {
			m[v] += 1
		} else {
			m[v] = 1
		}
	}
	var mostCommon T
	mostCommonCount := 0
	for k, v := range m {
		if v > mostCommonCount {
			mostCommon = k
			mostCommonCount = v
		}
	}
	return mostCommon
}

func simulateYahtzee(nDice int, tries int) bool {
	dice := make([]int, nDice)
	for i, _ := range dice {
		dice[i] = rand.Intn(6) + 1
	}
	for i := 0; i < tries; i++ {
		if countUnique(dice) == 1 {
			return true
		}
		mostCommon := mode(dice)
		for i, v := range dice {
			if v != mostCommon {
				dice[i] = rand.Intn(6) + 1
			}
		}
	}
	return false
}

func main() {
	rand.Seed(time.Now().Unix())

	n := 10000000
	nWins := 0
	for i := 0; i < n; i++ {
		if simulateYahtzee(5, 3) {
			nWins++
		}
		if (i+1)%(n/10) == 0 {
			fmt.Printf("(i=%d) Percentage: %f\n", i, float64(nWins)/float64(i+1))
		}
	}
	fmt.Printf("Percentage: %f\n", float64(nWins)/float64(n))
}
