let roll_die () = (Random.int 6) + 1;;

let mode l =
  let counter =
    List.fold_left (fun acc x ->
      if List.mem_assoc x acc
      then (x, List.assoc x acc + 1) :: List.remove_assoc x acc
      else (x, 1) :: acc
    ) [] l
  in
  match List.sort (fun (_, v1) (_, v2) -> v2 - v1) counter with
  | (k, _) :: _ -> k
  | _ -> failwith "list must have length greater than 0"
;;

let simulate_yahtzee n_dice tries =
  let init_dice () =
    let rec init_dice_helper = fun n ->
      if n > 0
      then roll_die () :: init_dice_helper (n-1)
      else []
    in
    init_dice_helper n_dice
  in
  let rec simulate_yahtzee_helper dice tries =
    if tries - 1 > 0
    then
      let most_common = mode dice in
      let dice = List.map (fun x ->
        if x == most_common
        then x
        else roll_die ()
      ) dice
      in
      simulate_yahtzee_helper dice (tries-1)
    else dice
  in
  let dice = init_dice () in
  let dice = simulate_yahtzee_helper dice tries in
  let most_common = mode dice in
  List.fold_left (fun acc x ->
    acc && (x == most_common)
  ) true dice
;;

let simulate_win_percentage n_games n_dice n_tries =
  let rec count_wins = fun n ->
    if n > 0
    then
      (if simulate_yahtzee n_dice n_tries then 1 else 0) + count_wins (n-1)
    else 0
  in
  (float_of_int (count_wins n_games)) /. (float_of_int n_games)
;;

simulate_win_percentage 100000 5 3;;
