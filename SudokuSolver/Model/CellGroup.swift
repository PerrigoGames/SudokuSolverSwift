//
//  CellGroup.swift
//  SudokuSolver
//
//  Created by Corey Perrigo on 8/19/23.
//

import SwiftUI

class CellGroup : CustomStringConvertible {
  let possibilities: Set<Int>
  var cells: Set<Cell> = []
  
  init(initialCell: Cell) {
    self.possibilities = initialCell.possibilities
    self.cells.insert(initialCell)
  }
  
  func findCommonElements() -> Set<GroupType> {
    var out: Set<GroupType> = []
    let firstCell = cells.first!
    if cells.allSatisfy({ $0.row == firstCell.row }) {
      out.insert(.row)
    }
    if cells.allSatisfy({ $0.col == firstCell.col }) {
      out.insert(.col)
    }
    if cells.allSatisfy({ $0.sqRow == firstCell.sqRow && $0.sqCol == firstCell.sqCol }) {
      out.insert(.square)
    }
    return out
  }
  
  public var description: String { return "\(possibilities) - \(cells.count) elements with \(findCommonElements())" }
}
