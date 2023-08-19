//
//  Board+Iterate.swift
//  SudokuSolver
//
//  Created by Corey Perrigo on 8/19/23.
//

extension Board {
  func forEachCellCoord(_ block: (Int, Int) -> Void) {
    for i in 0...8 {
      for j in 0...8 {
        block(i, j)
      }
    }
  }
  
  func forEachSquareCoord(_ block: (Int, Int) -> Void) {
    for i in 0...2 {
      for j in 0...2 {
        block(i, j)
      }
    }
  }
  
  func forEachIn(row: Int, block: (Cell) -> Void) {
    (0...8).forEach { block(cells[row][$0]) }
  }
  
  func mapRow<T>(_ row: Int, block: (Cell) -> T) -> [T] {
    return (0...8).map { block(cells[row][$0]) }
  }
  
  func cellsInRow(_ row: Int) -> [Cell] {
    return mapRow(row) { return $0 }
  }
  
  func forEachIn(col: Int, block: (Cell) -> Void) {
    (0...8).forEach { block(cells[$0][col]) }
  }
  
  func mapCol<T>(_ col: Int, block: (Cell) -> T) -> [T] {
    return (0...8).map { block(cells[$0][col]) }
  }
  
  func cellsInCol(_ col: Int) -> [Cell] {
    return mapCol(col) { return $0 }
  }
  
  func forEachInSquare(sqRow: Int, sqCol: Int, block: (Cell) -> Void) {
    return (0...8).forEach { spot in
      let adjRow = (sqRow * 3) + (spot / 3)
      let adjCol = (sqCol * 3) + (spot % 3)
      block(cells[adjRow][adjCol])
    }
  }
  
  func mapSquare<T>(sqRow: Int, sqCol: Int, block: (Cell) -> T) -> [T] {
    return (0...8).map { spot in
      let adjRow = (sqRow * 3) + (spot / 3)
      let adjCol = (sqCol * 3) + (spot % 3)
      return block(cells[adjRow][adjCol])
    }
  }
  
  func cellsInSquare(sqRow: Int, sqCol: Int) -> [Cell] {
    return mapSquare(sqRow: sqRow, sqCol: sqCol) { cell in
      return cell
    }
  }
  
  func mapSquare<T>(globRow: Int, globCol: Int, block: (Cell) -> T) -> [T] {
    return mapSquare(sqRow: globRow / 3, sqCol: globCol / 3, block: block)
  }
}
