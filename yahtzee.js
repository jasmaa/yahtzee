function mode(l) {
  const m = new Map();
  for (const x of l) {
    if (m.has(x)) {
      m.set(x, m.get(x) + 1);
    } else {
      m.set(x, 1);
    }
  }
  let mostCommon = null;
  let mostCommonCount = 0;
  for (const [k, v] of m.entries()) {
    if (v > mostCommonCount) {
      mostCommonCount = v;
      mostCommon = k;
    }
  }
  return mostCommon;
}

function simulateYahtzee(nDice = 5, tries = 3) {
  let dice = Array(nDice).fill(null).map(_ => Math.floor(6 * Math.random()) + 1);
  for (let i = 0; i < tries; i++) {
    const s = new Set(dice);
    if (s.size == 1) {
      return true;
    }
    mostCommon = mode(dice);
    dice = dice.map(x => x == mostCommon ? x : Math.floor(6 * Math.random()) + 1);
  }
  return false;
}

const n = 100000;
let nWins = 0;
for (let i = 0; i < n; i++) {
  nWins += !!simulateYahtzee();
  if ((i + 1) % (n / 10) == 0) {
    console.log(`(i=${i}) Percentage: ${nWins / (i + 1)}`);
  }
}
