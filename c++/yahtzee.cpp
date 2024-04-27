#include <ctime>
#include <iostream>
#include <map>
#include <vector>
#include <boost/random/mersenne_twister.hpp>
#include <boost/random/uniform_int_distribution.hpp>
#include <boost/accumulators/accumulators.hpp>
#include <boost/accumulators/statistics/stats.hpp>
#include <boost/accumulators/statistics/mean.hpp>

using namespace std;
using namespace boost::accumulators;

boost::random::mt19937 gen;

class Die
{
public:
  void roll()
  {
    boost::random::uniform_int_distribution<> dist(1, 6);
    value = dist(gen);
  }

  int getValue()
  {
    return value;
  }

private:
  int value;
};

int find_dice_mode(vector<Die> dice)
{
  map<int, int> counts;

  // Count dice value occurences
  for (int i = 0; i < dice.size(); i++)
  {
    int v = dice[i].getValue();
    if (counts.find(v) != counts.end())
    {
      counts[v]++;
    }
    else
    {
      counts[v] = 1;
    }
  }

  // Get most common dice value
  int max_count = 0;
  int max_count_dice_value = -1;
  for (auto const &pair : counts)
  {
    int dice_value = pair.first;
    int count = pair.second;
    if (count > max_count)
    {
      max_count = count;
      max_count_dice_value = dice_value;
    }
  }

  return max_count_dice_value;
}

bool simulate_game(int num_dice, int num_rounds)
{
  vector<Die> dice(num_dice, Die());
  for (int i = 0; i < dice.size(); i++)
  {
    dice[i].roll();
  }

  for (int i = 0; i < num_rounds; i++)
  {
    int mode = find_dice_mode(dice);

    bool isNotMatchMode = false;
    for (int i = 0; i < dice.size(); i++)
    {
      if (dice[i].getValue() != mode)
      {
        isNotMatchMode = true;
      }
    }

    if (!isNotMatchMode)
    {
      return true;
    }

    for (int i = 0; i < dice.size(); i++)
    {
      if (dice[i].getValue() != mode)
      {
        dice[i].roll();
      }
    }
  }

  return false;
}

int main()
{
  int num_games = 10000;

  accumulator_set<double, stats<tag::mean>> acc;

  for (int i = 0; i < num_games; i++)
  {
    acc(simulate_game(5, 3));
  }

  cout << "Percentage: " << mean(acc) << endl;

  return 0;
}
