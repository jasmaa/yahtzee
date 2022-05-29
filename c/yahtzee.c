#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int has_one_element(int *l, int len)
{
  int i;
  int v;
  if (len < 1)
  {
    return 0;
  }
  v = l[0];
  for (i = 1; i < len; i++)
  {
    if (l[i] != v)
    {
      return 0;
    }
  }
  return 1;
}

int dice_mode(int *dice, int n_dice)
{
  int rolls[6];
  int i;
  int most_common = -1;
  int most_common_count = 0;
  for (i = 0; i < 6; i++)
  {
    rolls[i] = 0;
  }
  for (i = 0; i < n_dice; i++)
  {
    rolls[dice[i] - 1]++;
  }
  for (i = 0; i < 6; i++)
  {
    if (rolls[i] > most_common_count)
    {
      most_common = i + 1;
      most_common_count = rolls[i];
    }
  }
  return most_common;
}

void print_dice(int *dice, int n_dice)
{
  int i;
  for (i = 0; i < n_dice; i++)
  {
    printf("%d,", dice[i]);
  }
  printf("\n");
}

int yahtzee(int n_dice, int tries)
{
  int i, j;
  int most_common;
  int *dice = malloc(sizeof(int) * n_dice);
  for (i = 0; i < n_dice; i++)
  {
    dice[i] = rand() % 6 + 1;
  }
  for (i = 0; i < tries; i++)
  {
    if (has_one_element(dice, n_dice))
    {
      free(dice);
      return 1;
    }
    most_common = dice_mode(dice, n_dice);
    for (j = 0; j < n_dice; j++)
    {
      if (dice[j] != most_common)
      {
        dice[j] = rand() % 6 + 1;
      }
    }
  }
  free(dice);
  return 0;
}

int main(int argc, char **argv)
{
  int n = 10000000;
  int i;
  int n_wins = 0;
  srand(time(NULL));
  for (i = 0; i < n; i++)
  {
    n_wins += yahtzee(5, 3);
    if ((i + 1) % (n / 10) == 0)
    {
      printf("(i=%d) Percentage: %f\n", i, (double)n_wins / (i + 1));
    }
  }
  return 0;
}