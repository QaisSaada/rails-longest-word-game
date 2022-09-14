
class GamesController < ApplicationController
  def new
    @letters = creat_letters
  end

  def score
    @grid = params[:grid]
    @word = params[:word]

   @result =  if letter_in_grid?
                "good job"
              elsif !validate(@word)
                "not in the letters"
              else
                "that was not an english word"
              end
  end

  private 

  def creat_letters
    Array.new(10) { ('A'..'Z').to_a[rand(26)] }
  end

  def letter_in_grid?
    @word.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def validate(word)
    response = Faraday.get("https://wagon-dictionary.herokuapp.com/#{word}")
    JSON.parse(response.body) 
  end


end
