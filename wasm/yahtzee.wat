(;
Memory layout:
|0x00|0x01|...               |$nDice-0x01|$nDice     |...                |$nDice+0x05|
|DDDD|DDDD|DDDD|DDDD|DDDD|...|DDDD       |MMMM       |MMMM|MMMM|MMMM|MMMM|MMMM       |

D: Dice values (len=nDice)
M: Count of dice values (len=6)
;)

(module
  (import "js" "random" (func $random (result f64)))
  (global $n (import "js" "n") i32)

  (memory $memory 1)

  (global $nDice i32 (i32.const 5))
  (global $nTries i32 (i32.const 3))

  (func $rollDie (result i32)
    call $random
    f64.const 6
    f64.mul
    f64.const 1
    f64.add
    i32.trunc_f64_u
  )

  (func $checkIsAllDiceSame (result i32)
    (local $i i32)
    (local $first i32)
    ;; Go thru all dice
    i32.const 1
    local.set $i
    i32.const 0
    i32.load
    local.set $first
    (loop $loop
      ;; Find offset to mode array
      (block $isSame
        local.get $i
        i32.const 4
        i32.mul
        i32.load
        local.get $first
        i32.eq
        br_if $isSame
        i32.const 0
        return
      )
      ;; Increment pointer
      (local.tee $i (i32.add (local.get $i) (i32.const 1)))
      global.get $nDice
      i32.lt_u
      br_if $loop
    )
    i32.const 1
  )

  (func $diceMode (result i32)
    (local $i i32)
    (local $modePtr i32)
    (local $mostCommon i32)
    (local $mostCommonCount i32)
    ;; Initialize mode array with 0s
    i32.const 0
    local.set $i
    (loop $initLoop
      local.get $i
      global.get $nDice
      i32.add
      i32.const 4
      i32.mul
      local.tee $modePtr
      i32.const 0
      i32.store
      ;; Increment pointer
      (local.tee $i (i32.add (local.get $i) (i32.const 1)))
      i32.const 6
      i32.lt_u
      br_if $initLoop
    )
    ;; Go thru all dice and count occurrences
    i32.const 0
    local.set $i
    (loop $loop
      ;; Find offset to mode array
      local.get $i
      i32.const 4
      i32.mul
      i32.load
      global.get $nDice
      i32.add
      i32.const 1
      i32.sub
      i32.const 4
      i32.mul
      ;; Increment mode array count at dice index
      local.tee $modePtr
      local.get $modePtr
      i32.load
      i32.const 1
      i32.add
      i32.store
      ;; Increment pointer
      (local.tee $i (i32.add (local.get $i) (i32.const 1)))
      global.get $nDice
      i32.lt_u
      br_if $loop
    )
    ;; Go thru mode array and get max
    i32.const 0
    local.set $mostCommon
    i32.const 0
    local.set $mostCommonCount
    i32.const 0
    local.set $i
    (loop $findModeLoop
      local.get $i
      global.get $nDice
      i32.add
      i32.const 4
      i32.mul
      local.set $modePtr
      ;; Check if more common
      (block $isNotMoreCommon
        local.get $modePtr
        i32.load
        local.get $mostCommonCount
        i32.le_u
        br_if $isNotMoreCommon
        local.get $i
        i32.const 1
        i32.add
        local.set $mostCommon
        local.get $modePtr
        i32.load
        local.set $mostCommonCount
      )
      ;; Increment pointer
      (local.tee $i (i32.add (local.get $i) (i32.const 1)))
      i32.const 6
      i32.lt_u
      br_if $findModeLoop
    )
    local.get $mostCommon
  )

  (func $simulateYahtzee (export "simulateYahtzee") (result i32)
    (local $i i32)
    (local $j i32)
    (local $dicePtr i32)
    (local $mostCommon i32)
    ;; Initialize dice with random values
    (local.set $dicePtr (i32.const 0))
    (loop $initLoop
      local.get $dicePtr
      call $rollDie
      i32.store
      ;; Increment pointer
      (local.tee $dicePtr (i32.add (local.get $dicePtr) (i32.const 4)))
      global.get $nDice
      i32.const 4
      i32.mul
      i32.lt_u
      br_if $initLoop
    )
    (local.set $i (i32.const 0))
    (block $isSame
      (loop $tryLoop
        call $checkIsAllDiceSame
        br_if $isSame
        call $diceMode
        local.set $mostCommon
        i32.const 0
        local.set $j
        (loop $rerollLoop
          (block $shouldNotReroll
            local.get $j
            i32.const 4
            i32.mul
            local.tee $dicePtr
            i32.load
            local.get $mostCommon
            i32.eq
            br_if $shouldNotReroll
            local.get $dicePtr
            call $rollDie
            i32.store
          )
          (local.tee $j (i32.add (local.get $j) (i32.const 1)))
          global.get $nDice
          i32.lt_u
          br_if $rerollLoop
        )
        (local.tee $i (i32.add (local.get $i) (i32.const 1)))
        global.get $nTries
        i32.lt_u
        br_if $tryLoop
      )
      i32.const 0
      return
    )
    i32.const 1
  )

  (func (export "runSimulation") (result f64)
    (local $i i32)
    (local $nWins i32)
    i32.const 0
    local.set $i
    i32.const 0
    local.set $nWins
    (loop $loop
      (block $isNotWin
        call $simulateYahtzee
        i32.const 0
        i32.eq
        br_if $isNotWin
        (local.set $nWins (i32.add (local.get $nWins) (i32.const 1)))
      )
      (local.tee $i (i32.add (local.get $i) (i32.const 1)))
      global.get $n
      i32.lt_u
      br_if $loop
    )
    ;; Calculate win percentage
    local.get $nWins
    f64.convert_i32_u
    global.get $n
    f64.convert_i32_u
    f64.div
  )
)
