require 'pry'

class TicTacToe

    attr_accessor :index 

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize(board=nil)
        @board = board || Array.new(9, " ")
    end

# #display_board
# Define a method that prints the current board representation based on the @board instance variable.

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
        puts
    end

# #input_to_index
# Define a method into which we can pass user input (in the form of a string, e.g., "1", "5", etc.) and have it return to us the corresponding index of the @board array. Remember that, from the player's point of view, the board contains spaces 1-9. But the indices in an array start their count at 0. If the user inputs 5, your method must correctly translate that from the player's perspective to the array's — accounting for the fact that @board[5] is not where the user intended to place their token.

    def input_to_index(input)
        index = input.to_i - 1
    end

# #move
# Your #move method must take in two arguments: the index in the @board array that the player chooses and the player's token 
# (either "X" or "O"). The second argument, the player's token, should default to "X".

    def move(index, token="X")

        @board[index] = token

    end

# #position_taken?
# 
# The #position_taken? method will be responsible for evaluating the user's desired move against the Tic Tac Toe board 
# and checking to see whether or not that position is already occupied. 
# Note that this method will be running after #input_to_index, so it will be checking index values. 
# When it is passed the index value for a prospective move, #position_taken? will check to see if that position on the @board is vacant 
# or if it contains an "X" or an "O". If the position is free, the method should return false (i.e., "the position is not taken"); 
# otherwise, it will return true.

    def position_taken?(index)

        @board[index] == " " ? false : true

    end

# #valid_move?
# Build a method valid_move? that accepts a position to check and returns true if the move is valid and false or nil if not. 
# A valid move means that the submitted position is:
# Present on the game board.
# Not already filled with a token.

    def valid_move?(index)

        !self.position_taken?(index) && index < 9 && index >= 0 ? true : false

    end

# #turn
# 
# Build a method #turn to encapsulate the logic of a single complete turn composed of the following routine:
#
# Ask the user for their move by specifying a position between 1-9.
# Receive the user's input.
# Translate that input into an index value.
# If the move is valid, make the move and display the board.
# If the move is invalid, ask for a new move until a valid move is received.
# All these procedures will be wrapped into our #turn method. 
# However, the majority of the logic for these procedures will be defined and encapsulated in individual methods that you've already 
# built.
#
# You can imagine the pseudocode for the #turn method:
#
# ask for input
# get input
# translate input into index
# if index is valid
#   make the move for index
#   show the board
# else
#   ask for input again
# end 
# #turn_count
# This method returns the number of turns that have been played based on the @board variable.

    def turn_count
        count = 0
        @board.each {|spot| count += 1 if spot != " "}
        count
    end

    def turn

        puts "Please select a spot (ex. 1-9):"
        input = gets
        puts
        index = self.input_to_index(input)
        if self.valid_move?(index)
            self.move(index, self.current_player)
            self.display_board
        else
            self.turn
        end
    end

# #current_player
# The #current_player method should use the #turn_count method to determine if it is "X"'s or "O"'s turn.

    def current_player

        self.turn_count % 2 == 0 ? "X" : "O"

    end

# #won?
# Your #won? method should return false/nil if there is no win combination present in the board and return the winning combination indexes 
# as an array if there is a win. Use your WIN_COMBINATIONS constant in this method.

    def won?
        x = Array.new(9, " ")
        o = Array.new(9, " ")

        @board.each_with_index do |space, index|
            x << index if space == "X"
            o << index if space == "O"
        end

        # some sort of iteration that checks if there's a match?
        WIN_COMBINATIONS.each do |win|
            if x.include?(win[0]) && x.include?(win[1]) && x.include?(win[2])
                return win
            elsif o.include?(win[0]) && o.include?(win[1]) && o.include?(win[2])
                return win
            end
        end

        return false

    end

# #full?
# The #full? method should return true if every element in the board contains either an "X" or an "O".

    def full?
        
        self.turn_count == 9 ? true : false

    end

# #draw?
# Build a method #draw? that returns true if the board is full and has not been won, false if the board is won, and false if the board is neither won nor full.

    def draw?

        self.full? && !self.won? ? true : false

    end

# #over?
# Build a method #over? that returns true if the board has been won or is full (i.e., is a draw).

    def over?

        self.full? || self.won? ? true : false

    end

# #winner
# Given a winning @board, the #winner method should return the token, "X" or "O", that has won the game.

    def winner

        x = Array.new(9, " ")
        o = Array.new(9, " ")

        @board.each_with_index do |space, index|
            x << index if space == "X"
            o << index if space == "O"
        end

        # some sort of iteration that checks if there's a match?
        WIN_COMBINATIONS.each do |win|
            if x.include?(win[0]) && x.include?(win[1]) && x.include?(win[2])
                return "X"
            elsif o.include?(win[0]) && o.include?(win[1]) && o.include?(win[2])
                return "O"
            end
        end

        return nil

    end

    def play

        self.turn until self.over? || self.draw?

        if self.draw?
            puts "Cat's Game!"
            puts
        elsif self.won?
            puts "Congratulations #{self.winner}!"
            puts
        end

    end

end