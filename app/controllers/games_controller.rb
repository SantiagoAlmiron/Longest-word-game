require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = (0..10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "")
    @include = include?(@word, @letters)
    @dictionary = english_word?(@word)
  end

  private

  def english_word?(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(url.read)
    json['found']
  end

  def include?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
