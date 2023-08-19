//
//  SudokuSolverApp.swift
//  SudokuSolver
//
//  Created by Corey Perrigo on 8/19/23.
//

import SwiftUI

@main
struct SudokuSolverApp: App {
  let boardString1 = "..7..8.../.86925.4./2..7...8./..81...../7..283..6/.....73.8/.4..7...9/.5..412../.7.3..8.4"
  let boardString2 = "12345678./45678912./78912345./........./........./........./........./........./........."
  let boardString3 = "123456.../456789.../7...1...../........./........./........./........./........./........."
  let empty = "........./........./........./........./........./........./........./........./........."
      
  var body: some Scene {
    WindowGroup {
      ContentView(boardString: boardString1)
    }
  }
}
