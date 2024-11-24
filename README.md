# Minesweeper
This is a mobile adapation of the popular [Minesweeper](https://en.wikipedia.org/wiki/Minesweeper_(video_game)) game inspired by Google's online [version](https://g.co/kgs/y2rWv6x). Comes with an easy, medium, and hard setting. Built for ipadOS and macOS. Hope you enjoy!

<img src="https://github.com/EvanC8/Minesweeper/blob/main/showcase2.gif?raw=true" width="500">

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#installation">Installation</a></li>
    <li><a href="#usage">Usage</a></li>
    <li>
      <a href="#how-it-works">How it works</a>
      <ul>
        <li><a href="#first-move">First Move</a></li>
        <li><a href="#Gameplay">Gameplay</a></li>
      </ul>
    </li>
    <li><a href="#next-steps">Next Steps</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

# Installation
* Clone the repo
   ```sh
   git clone https://github.com/EvanC8/Minesweeper.git
   ```
# Usage
1. Download project
2. Run project from XCode
3. Play Minesweeper!

# How it works

<img src="https://github.com/EvanC8/Minesweeper/blob/main/showcase1.jpg?raw=true" height="250"> <img src="https://github.com/EvanC8/Minesweeper/blob/main/showcase3.jpg?raw=true" height="250">

### Gameplay
The goal of the game is to reveal all space on the board without touching a mine. The number shown on a cell represents the number of mines within a one block radius of that cell. With this in mind, a player can deduce where mines are hidden. The user can then mark the cell believed to be a mine with a flag. With the clock running, it's all about how fast the player can win without falling vicitim to a mine explosion!!

### First Move
The board is represented by a 2D array of cells. At this stage, no cells have been assigned to mines. When the player first tappes the board, mines are then randomly placed surrounding the area of the tap. Each time a mine is placed, the value of all adjacent cells is incremented. Then, `recursion` is used to reveal all empty cells (cells with value of 0) and the bordering cells surrounding the user's tap location in a staggered fasion, providing the user with a starting point. The stopwatch starts. 

# Next Steps
* Add more animation and visual effects for a more interactive and rewarding player experience.

# License
Destributed under the MIT License. See `LICENSE.txt` for more information.

# Contact
Evan Cedeno - escedeno8@gmail.com

Project Link: [Minesweeper](https://github.com/EvanC8/Minesweeper)
