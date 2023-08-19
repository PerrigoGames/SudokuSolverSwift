//
//  CellView.swift
//  SudokuSolver
//
//  Created by Corey Perrigo on 8/19/23.
//

import SwiftUI

struct CellView: View {
  @Binding var cell: Cell
  var squareDimen: CGFloat
  
  var body: some View {
    ZStack {
      Rectangle().border(Color.black, width: 1)
        .foregroundColor(.clear)
      
      if let value = cell.value {
        Text(String(value))
          .font(.system(size: 48, weight: .bold, design: .default))
          .foregroundColor(.black)
      } else {
        SudokuPossibilitiesView(possibilities: $cell.possibilities)
          .frame(width: squareDimen, height: squareDimen)
      }
    }
    .frame(width: squareDimen, height: squareDimen)
  }
}
