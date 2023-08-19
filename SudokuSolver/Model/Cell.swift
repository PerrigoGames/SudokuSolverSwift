//
//  Cell.swift
//  SudokuSolver
//
//  Created by Corey Perrigo on 8/19/23.
//

import SwiftUI

class Cell: ObservableObject, Identifiable {
  @Published var value: Int?
  @Published var possibilities: Set<Int> = []
  var id = UUID()
  
  let row: Int
  let col: Int
  
  let sqRow: Int
  let sqCol: Int
  
  init(row: Int, col: Int, value: Int?) {
    self.row = row
    self.col = col
    self.sqRow = row / 3
    self.sqCol = col / 3
    if (value != nil) {
      self.value = value
    } else {
      self.initPossibilities()
    }
  }
  
  func initPossibilities() {
    possibilities = Set(1...9)
  }
  
  func removePossibility(_ item: Int) {
    possibilities.remove(item as Int)
  }
  
  func removePossibilities(_ array: Array<Int>) {
    for item in array {
      removePossibility(item as Int)
    }
  }
  
  func removePossibilities(_ set: Set<Int>) {
    for item in set {
      removePossibility(item as Int)
    }
  }
}

extension Cell : Hashable {
  static func == (lhs: Cell, rhs: Cell) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
