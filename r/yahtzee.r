n_runs <- 100000

find_mode <- function (v) {
  nums <- unique(v)
  first_idxs <- match(v, nums)
  idx_counts <- tabulate(first_idxs)
  most_common_idx <- which.max(idx_counts)
  v[most_common_idx]
}

simulate_yahtzee <- function (n_dice = 5, n_tries = 3) {
  dice <- sample(1:6, n_dice, replace=TRUE)
  for (i in 1:n_tries) {
    if (length(unique(dice)) == 1) {
      return(TRUE)
    }
    most_common <- find_mode(dice)
    reroll_mask <- dice != most_common
    dice <- (!reroll_mask) * dice + reroll_mask * sample(1:6, n_dice, replace=TRUE)
  }
  FALSE
}

runs <- replicate(n_runs, simulate_yahtzee())
p <- sum(runs) / length(runs)

print(paste("Percentage: ", p))
