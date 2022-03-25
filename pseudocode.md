four_in_a_row
  check if there are four of the same pieces connected in the same row
    - tranform the row array to a string
    - check if the string include 'xxxx' or 'oooo'




7 columns x 6 rows

methods

game_won? when one of the player has 4 pieces connected
ask_column wait for player input to put the piece in a column
play should ask_column and check if game_won? every turn

variables in a Game class

board that is an hash storing the input value { row1 => array of 7 elements ecc.}
player_one
player_two

verbose

Ask the player for the input (a number for each column)
Store the move in the board starting from row1, if that coordinate is already taken, go to the next row ecc
Check to see if there are four pieces connecting each other, in a row, in a column, in diagonal
Repeat from the start if the previosly statement is false
