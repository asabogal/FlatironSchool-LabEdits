
def intro_display_board(board)
  puts " 1 | 2 | 3 "
  puts "-----------"
  puts " 4 | 5 | 6 "
  puts "-----------"
  puts " 7 | 8 | 9 "
end
#displays board numbered positions


WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]
#defines all the possible winning combinations in form of arrays

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
#displays the cuttent state of the board at any given time as passed by the board array

def input_to_index(user_input)
  index = user_input.to_i - 1
end
#concverts the user's input into an integer and substracts 1 from it. Input is collected in #turn

def move(board, index, player)
  board[index] = player
end
#assings either player "X" or "O" to an index in the board.

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
#checks if the board for available positions

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
#checks if the player's input is a valid one by determining if it's within the correct range of 0-8
#and checks if the reuqested position is not already taken

def turn_count(board)
  turn_number = 0
  board.each do |index|
  if index == "X" || index == "O"
    turn_number += 1
    end
  end
  return turn_number
end
#keeps track of the current turn number that will help determine who's olayer's tuen is next

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end
#determines who turn is it by determining if the current turn number is divisible by 2 or not. If true, it's "X" turn, Otherwise is "O"

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    board[win_combo[0]] == board[win_combo[1]] &&
    board[win_combo[1]] == board[win_combo[2]] &&
    position_taken?(board, win_combo[0])
  end
end
#determines if there is a winning player; i.e a winning board combination based on WIN_COMBINATIONS arrays.


def full?(board)
  board.all? do |token|
    token == "X" || token == "O"
  end
end
#checks for a full board where all possible moves have taken place

def draw?(board)
  !won?(board) && full?(board)
end
##checks if the game is a draw. If the game isn't wond AND the board is not full, it MUST be a draw!

def over?(board)
  won?(board) || draw?(board) || full?(board)
end
#to be over, the game has to be eother won, full, or drawn

def winner(board)
  if winning_token = won?(board)
  board[winning_token[0]]
  end
end
#determines the winning player; get the return from #won? which is the winning combination array, and passes one of it's index
#to the board to return the board index value at that index

#----------------
# def turn(board)
#   puts "Please enter 1-9:"
#   input = gets.strip
#   index = input_to_index(input)
#   if valid_move?(board, index)
#     move(board, index, current_player(board))
#     display_board(board)
#   else
#     turn(board)
#   end
# end


def turn(board)
  puts "Please make your move. Enter 1-9 below:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))# the #move method takes player as an argument, we must pass the return of #current_player
    display_board(board)
  else
    turn(board)
  end
end
#encompasses all the mechanics for each player's turn.
#----------------
def play(board)
until over?(board)
  turn(board)
end
if won?(board)
  puts "Congratulations! #{winner(board)} is the winner!!!"
else draw?(board)
  puts "It's a draw game!!"
  end
end
#the main game loop: As long as the game is not over, evoke #turn. If the board returns a winner (#won?),
#congratulate the winning player by interpolating #winner(board).
#otherwise if the game is a draw, inform the players the game is drawn.
