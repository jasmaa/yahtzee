use std::collections::HashMap;

fn main() {
    let n = 100000;
    let n_dice = 5;
    let n_tries = 3;

    let mut n_wins = 0;
    for _ in 0..n {
        if simulate_yahtzee(n_dice, n_tries) {
            n_wins += 1;
        }
    }

    let p = (n_wins as f64) / (n as f64);
    println!("Percentage: {}", p);
}

fn simulate_yahtzee(n_dice: usize, n_tries: usize) -> bool {
    let mut dice = (0..n_dice).map(|_| roll_die()).collect::<Vec<u8>>();
    for _ in 0..n_tries {
        let dice_counts = get_dice_counts(&dice);
        if dice_counts.len() == 1 {
            return true;
        } else {
            let most_common = dice_counts
                .into_iter()
                .max_by_key(|(_, v)| *v)
                .map(|(k, _)| k)
                .unwrap();
            let mut updated_dice: Vec<u8> = Vec::new();
            for d in &dice {
                if *d == most_common {
                    updated_dice.push(*d);
                } else {
                    updated_dice.push(roll_die());
                }
            }
            dice = updated_dice;
        }
    }
    return false;
}

fn roll_die() -> u8 {
    rand::random::<u8>() % 6 + 1
}

fn get_dice_counts(dice: &Vec<u8>) -> HashMap<u8, usize> {
    let mut h = HashMap::new();
    for d in dice {
        *h.entry(*d).or_default() += 1;
    }
    h
}
