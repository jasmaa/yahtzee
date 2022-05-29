import random
import statistics


def simulate_yahtzee(n_dice=5, tries=3):
    dice = [random.randint(1, 6) for _ in range(n_dice)]
    for _ in range(tries):
        if len(set(dice)) == 1:
            return True
        most_common = statistics.mode(dice)
        dice = [
            x if x == most_common else random.randint(1, 6)
            for x in dice
        ]
    return False


if __name__ == "__main__":
    n = 1000000
    n_wins = 0
    for i in range(n):
        if simulate_yahtzee():
            n_wins += 1
        if (i+1) % (n//10) == 0:
            print(f"(i={i}) Percentage: {n_wins / (i+1)}")
