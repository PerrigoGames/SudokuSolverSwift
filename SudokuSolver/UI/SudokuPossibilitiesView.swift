//
//  SudokuPossibilitiesView.swift
//  SudokuSolver
//
//  Created by Corey Perrigo on 8/19/23.
//

import SwiftUI

struct SudokuPossibilitiesView: View {
  @Binding var possibilities: Set<Int>
  
  var body: some View {
    GeometryReader { geometry in
      let cellSize = min(geometry.size.height, geometry.size.width) * 0.25
      Grid {
        ForEach(0..<3) { innerRow in
          GridRow {
            ForEach(0..<3) { innerCol in
              let testVal = (innerRow * 3) + innerCol + 1
              let text = possibilities.contains(testVal) ? String(testVal) : ""
              Text(text)
                .font(.system(size: 18, weight: .regular, design: .monospaced))
                .foregroundColor(.black)
                .frame(width: cellSize, height: cellSize)
            }
          }
        }
      }
    }
  }
}
