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

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
        puts
    end

    def input_to_index(input)
        index = input.to_i - 1
    end

    def move(index, token="X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == " " ? false : true
    end

    def valid_move?(index)
        !self.position_taken?(index) && index < 9 && index >= 0 ? true : false
    end


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

    def current_player
        self.turn_count % 2 == 0 ? "X" : "O"
    end

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

    def full?        
        self.turn_count == 9 ? true : false
    end

    def draw?
        self.full? && !self.won? ? true : false
    end

    def over?
        self.full? || self.won? ? true : false
    end

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