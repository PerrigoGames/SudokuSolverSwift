//
//  ContentView.swift
//  SudokuSolver
//
//  Created by Corey Perrigo on 8/19/23.
//

import SwiftUI

struct ContentView: View {
  @StateObject var board: Board
  
  init(boardString: String) {
    _board = StateObject(
      wrappedValue: Board(boardString: boardString)
    )
  }
  
  var body: some View {
    HStack {
      SudokuGridView()
      VStack {
        Button("Assign Single Possibilities") {
          board.objectWillChange.send()
          board.assignSinglePossibilities()
          print("Complete")
        }
        .padding(.vertical, 8)
        Text("Find Groups")
        HStack {
          ForEach(2..<7) { count in
            Button(String(count)) {
              board.objectWillChange.send()
              board.findGroups(ofSize: count)
              print("Complete")
            }
            .padding(.horizontal, 4)
          }
        }
      }
    }
    .environmentObject(board)
  }
}
