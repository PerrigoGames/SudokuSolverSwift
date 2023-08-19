//
//  SudokuGridView.swift
//  SudokuSolver
//
//  Created by Corey Perrigo on 8/19/23.
//

import SwiftUI

struct SudokuGridView: View {
  let gridSize: Int = 9
  let groupSize: Int = 3
  
  @EnvironmentObject var board: Board
  
  var body: some View {
    GeometryReader { geometry in
      let minDimension = min(geometry.size.width, geometry.size.height)
      let squareDimen = minDimension / CGFloat(gridSize)
      let groupDimen = minDimension / CGFloat(groupSize)
      
      Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
        ForEach(0..<gridSize) { row in
          GridRow {
            ForEach(0..<gridSize) { col in
              let cell = $board.cells[row][col]
              CellView(cell: cell, squareDimen: squareDimen)
            }
          }
        }
      }
      .frame(width: minDimension, height: minDimension)
      .overlay {
        Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<groupSize) { row in
              GridRow {
                ForEach(0..<groupSize) { col in
                  Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: groupDimen, height: groupDimen)
                    .border(Color.black, width: 4)
                }
              }
            }
          }
        }
    }
  }
}

struct SudokuGridView_Previews: PreviewProvider {
  static var previews: some View {
    SudokuGridView()
      .environmentObject(
        Board(boardString: "..7..8.../.86925.4./2..7...8./..81...../7..283..6/.....73 .8/.4..7...9/.5..412../.7.3..8.4"))
  }
}
