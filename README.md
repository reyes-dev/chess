<h1 align="center">
    CLI Chess 
</h1>

Traditional Chess, playable from the command line, written from scratch in Ruby.

## Description
A Chess game you can play. You can play against a simple-minded CPU that makes random moves or another human. It enforces the main rules of the game, including restricted piece movements and check/checkmate, and includes the essentials features such 6 types of pieces, castling, pawn promotion, en-passant, being multiplayer, a colored board and black/white team colors. I've used modularization to organize code into feature-specific files, classes to model individual pieces and concepts such as the board and gameplay loop, and YAML serialization to save and load games.

## Features
- Human vs Human
- Human vs AI
- Save and Load your games
- Unicode graphics

## Play online
[Link to the replit](https://replit.com/@reyesdev/chess) where you can easily play it from your browser. Just hit the green run button and wait a moment for the dependencies to install.

## Run locally
Step-by-step instructions on how to run chess from your very own terminal! *Note: You will need to have Ruby and Git installed.*
1. Install Ruby. If you need some help with this, [here is a great resource for installing Ruby on MacOS and Linux](https://www.theodinproject.com/lessons/ruby-installing-ruby)
2. Clone this repo, if you need help, [GitHub has a great article on how to clone a repo.](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
3. Navigate into this repo with `cd chess`
4. Run `bundle install` to install Gemfile dependencies.
5. Run `ruby main.rb` to launch the game.
6. Play!

## Known bugs
- Replit occasionally changes how they render the terminal, making the board's visibility at risk at times
