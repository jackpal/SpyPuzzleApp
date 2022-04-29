# SpyPuzzleApp - an iOS SwiftUI app for exploring Spy Puzzle game Levels

This app lets you design and solve your own game levels for a spy puzzle game that is
similar to [Hitman Go](https://en.wikipedia.org/wiki/Hitman_Go).

Features:

+ Displays user-written puzzle levels in a schematic top-down view.
- Supports a variety of terrain, enemies, items, objectives and game rules.
+ Allows manual level solving.
  - Prevents accidental single-move deaths.
  - Allows Undo/Redo/Reset
+ Built-in solver can automatically solve many levels.

Limitations:

- The provided puzzle levels are primarily for testing the implementation.
- If you want to solve more interesting or complicated levels, you'll have to enter them yourself.
- The solver can get stuck on complicated levels.
- The solver is single-threaded, and only uses one of your CPUs.

# FAQ

Q: Why did you write this?

A: Over the 2021 holidays, I was stuck on a Hitman Go level. I thought it would be fun to write a
little program to help me solve it. One thing lead to another, and here we are.

Q: Where are the Hitman Go game levels?

A: They are not included, because they are the property of the Hitman Go developers and publishers.

Q: But I want to solve a particular Hitman Go level.

A: There are plenty of "Hitman Go Walkthrough level N-M" websites that can help you do that.

Q: Why isn't this app in the App Store?

A: Without clever puzzle levels it's not that interesting to end users. The graphics are a little sketchy,
and the UX is a little unpolished.

Q: How come the solver is sometimes very slow?

A: The solver currently doesn't do any if-then planning. So for example
if the exit is behind a door, the solver doesn't know that it should get the key first. Instead, it
does a breadth-first-search until it happens to find the key, after which it can quickly get to the exit.

Q: Can I add my own levels?

A: Absolutely! Just edit Levels/Levels.swift. The level format is documented in
[SpyPuzzleGameState](https://github.com/jackpal/SpyPuzzleGameState).

Q: Can I use this code in my own projects?

A: Yes, certainly! It's licensed under the MIT license.

# Links

[SpyPuzzleGameState](https://github.com/jackpal/SpyPuzzleGameState) - a Swift package for the
Spy Puzzle game state and game rules.

[SpyPuzzleSolver](https://github.com/jackpal/SpyPuzzleGameState) - a Swift package for the level solver.

[SpyPuzzleCLI](https://github.com/jackpal/SpyPuzzleCLI) - a Swift package for a command-line app that
can parse and solve text-based Spy Puzzle levels. Currently only tested on MacOS.
