import core
import Foundation

struct Day8_Solution: Runner {

  // MARK: Lifecycle

  init(reader: Reader) {
    self.reader = reader
  }

  // MARK: Internal

  func run(url: URL) throws {
    let file = try reader.read(url: url)
    let matrix = file
      .split(separator: "\n")
      .map {
        $0
          .split(separator: "")
          .compactMap { $0.int }
      }
    var total = 0
    var scenicTotal = 0
    for row in 1..<(matrix.count - 1) {
      for element in 1..<(matrix[row].count - 1) {
        let value = matrix[row][element]
        var currentBoard = Board(board: matrix)
        let peak = currentBoard.peak(row, element, value)
        if peak.0 {
          total += 1
        }
        scenicTotal = max(peak.1, scenicTotal)
      }
    }
    let computedValue = (matrix.count * 2) + (matrix.first!.count * 2) - 4
    print("total: \(computedValue + total) scenicTotal: \(scenicTotal)")
  }

  // MARK: Private

  private let reader: Reader
}

struct Board {

  // MARK: Lifecycle

  init(board: [[Int]]) {
    self.board = board
  }

  // MARK: Internal

  enum SearchPath {
    case up, down, right, left
  }

  mutating func peak(
    _ row: Int,
    _ column: Int,
    _ currentValue: Int) -> (Bool, Int)
  {
    let up = peakHelper(row - 1, column, currentValue, .up)
    let down = peakHelper(row + 1, column, currentValue, .down)
    let right = peakHelper(row, column - 1, currentValue, .right)
    let left = peakHelper(row, column + 1, currentValue, .left)
    return (
      up.0 || down.0 || right.0 || left.0,
      up.1 * down.1 * right.1 * left.1)
  }

  // MARK: Private

  private let board: [[Int]]

  private mutating func peakHelper(
    _ row: Int,
    _ column: Int,
    _ currentValue: Int,
    _ searchPath: SearchPath)
    -> (Bool, Int)
  {
    if row < 0 || column < 0 || row >= board.count || column >= board.first!
      .count
    {
      return (true, 0)
    }

    if board[row][column] >= currentValue {
      return (false, 1)
    }
    switch searchPath {
    case .up:
      let values = peakHelper(row - 1, column, currentValue, searchPath)
      return (values.0, values.1 + 1)
    case .down:
      let values = peakHelper(row + 1, column, currentValue, searchPath)
      return (values.0, values.1 + 1)
    case .right:
      let values = peakHelper(row, column - 1, currentValue, searchPath)
      return (values.0, values.1 + 1)
    case .left:
      let values = peakHelper(row, column + 1, currentValue, searchPath)
      return (values.0, values.1 + 1)
    }
  }

}
