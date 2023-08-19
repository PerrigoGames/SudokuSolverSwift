//
//  Board.swift
//  SudokuSolver
//
//  Created by Corey Perrigo on 8/19/23.
//

import SwiftUI

class Board: ObservableObject {
  @Published var cells: [[Cell]]
  
  init(boardString: String) {
    cells = (0...8).map { row in
      (0...8).map { col in
        Cell(row: row, col: col, value: nil)
      }
    }
    let lines = boardString.split(separator: "/")
    (0...8).forEach { row in
      let line = lines[row]
      (0...8).forEach { col in
        let index = line.index(line.startIndex, offsetBy: col)
        let char = line[index]
        if let value = char.wholeNumberValue {
          setCell(toValue: value, row: row, col: col)
        }
      }
    }
  }
  
  func assignSinglePossibilities() {
    var modCells: Set<Cell> = []
    forEachCellCoord { row, col in
      let cell = cells[row][col]
      if cell.value == nil && cell.possibilities.count == 1 {
        modCells.insert(cell)
      }
    }
    
    for cell in modCells {
      print("Single possibility found at (\(cell.col),\(cell.row))")
      self.setCell(toValue: cell.possibilities.removeFirst(), row: cell.row, col: cell.col)
    }
  }
  
  func findGroups(ofSize size: Int) {
    findGroups(inType: .square, ofSize: size)
    findGroups(inType: .row, ofSize: size)
    findGroups(inType: .col, ofSize: size)
  }
  
  func findGroups(inType type: GroupType, ofSize size: Int) {
    switch type {
    case .square:
      forEachSquareCoord { sqRow, sqCol in
        let cells = cellsInSquare(sqRow: sqRow, sqCol: sqCol)
        let result = findGroups(ofSize: size, inList: cells)
        if !result.isEmpty {
          print("Square \(sqRow),\(sqCol) contains groups \(result)")
          for group in result { applyGroup(group) }
        }
      }
    case .row:
      (0...8).forEach { slot in
        let cells = cellsInRow(slot)
        let result = findGroups(ofSize: size, inList: cells)
        if !result.isEmpty {
          print("Row \(slot) contains groups \(result)")
          for group in result { applyGroup(group) }
        }
      }
    case .col:
      (0...8).forEach { slot in
        let cells = cellsInCol(slot)
        let result = findGroups(ofSize: size, inList: cells)
        if !result.isEmpty {
          print("Col \(slot) contains groups \(result)")
          for group in result { applyGroup(group) }
        }
      }
    }
  }
  
  private func applyGroup(_ group: CellGroup) {
    let refCell = group.cells.first!
    let commons = group.findCommonElements()
    for type in commons {
      switch type {
      case .square:
        cellsInSquare(sqRow: refCell.sqRow, sqCol: refCell.sqCol).forEach {
          if $0.value == nil && !group.cells.contains($0) {
            $0.removePossibilities(group.possibilities)
          }
        }
      case .row:
        cellsInRow(refCell.row).forEach {
          if $0.value == nil && !group.cells.contains($0) {
            $0.removePossibilities(group.possibilities)
          }
        }
      case .col:
        cellsInCol(refCell.col).forEach {
          if $0.value == nil && !group.cells.contains($0) {
            $0.removePossibilities(group.possibilities)
          }
        }
      }
    }
  }
  
  func findGroups(ofSize size: Int, inList: [Cell]) -> [CellGroup] {
    let cellsOfSize = inList.filter { cell in
      cell.value == nil && cell.possibilities.count == size
    }
    let cellsBelowSize = inList.filter { cell in
      cell.value == nil && cell.possibilities.count < size
    }
    var groups: [CellGroup] = []
    
    cellsOfSize.forEach { cell in
      let existingGroup = groups.first { group in
        group.possibilities == cell.possibilities
      }
      if let existingGroup {
        existingGroup.cells.insert(cell)
      } else {
        groups.append(CellGroup(initialCell: cell))
      }
    }
    cellsBelowSize.forEach { cell in
      groups.forEach { group in
        if group.possibilities.isSuperset(of: cell.possibilities) {
          group.cells.insert(cell)
        }
      }
    }
    return groups.filter { $0.cells.count >= size }
  }
  
  private func setCell(toValue: Int, row: Int, col: Int) {
    cells[row][col].value = toValue
    let block = { (cell: Cell) -> Void in
      cell.removePossibility(toValue)
    }
    forEachIn(row: row, block: block)
    forEachIn(col: col, block: block)
    forEachInSquare(sqRow: row / 3, sqCol: col / 3, block: block)
  }
  
  func printBoard() {
    for row in cells {
      for cell in row {
        if (cell.value != nil) {
          print(" \(cell.value!) ", terminator: "")
        } else {
          print("(\(cell.possibilities.count))", terminator: "")
        }
      }
      print()
    }
  }
}
