import core
import Foundation

struct Day9_Solution: Runner {

  // MARK: Lifecycle

  init(reader: Reader) {
    self.reader = reader
  }

  // MARK: Internal

  typealias Position = (Int, Int)

  func run(url: URL) throws {
    let file = try reader.read(url: url)
    var matrixSize = (0,0)
    var directions: [Direction] = []
    for line in file.split(separator: "\n") {
      let split = line.split(separator: " ")
      if let v = split.last?.int,
         let direction = Direction(s: split.first!, value: v)
      {
        directions.append(direction)
        switch direction {
        case .right(let steps), .left(let steps):
          matrixSize = (matrixSize.0 + steps, matrixSize.1)
        case .up(let steps), .down(let steps):
          matrixSize = (matrixSize.0, matrixSize.1 + steps)
        }
      }
    }
    var matrix = Array(
      repeating: Array(
        repeating: "O",
        count: matrixSize.1),
      count: matrixSize.0)
    var currentPosition = (0, matrix.count - 1)
    matrix[currentPosition.1][currentPosition.0] = "S"

    var positions: Set<String> = Set()
    for direction in directions {
      switch direction {
      case .right(let steps):
        let _currentPosition = (currentPosition.0 + steps, currentPosition.1)
        appendPositions(
          matrix: &matrix,
          positions: &positions,
          currentPosition: currentPosition,
          endPosition: _currentPosition)
        currentPosition = _currentPosition
      case .left(let steps):
        let _currentPosition = (currentPosition.0 - steps, currentPosition.1)
        appendPositions(
          matrix: &matrix,
          positions: &positions,
          currentPosition: currentPosition,
          endPosition: _currentPosition)
        currentPosition = _currentPosition
      case .up(let steps):
        let _currentPosition = (currentPosition.0, currentPosition.1 - steps)
        appendPositions(
          matrix: &matrix,
          positions: &positions,
          currentPosition: currentPosition,
          endPosition: _currentPosition)
        currentPosition = _currentPosition
      case .down(let steps):
        let _currentPosition = (currentPosition.0, currentPosition.1 + steps)
        appendPositions(
          matrix: &matrix,
          positions: &positions,
          currentPosition: currentPosition,
          endPosition: _currentPosition)
        currentPosition = _currentPosition
      }
    }
    matrix.printArray()
    print(positions.count)
  }

  func appendPositions(
    matrix: inout [[String]],
    positions: inout Set<String>,
    currentPosition: Position,
    endPosition: Position)
  {
    for row in min(currentPosition.0, endPosition.0)..<max(
      currentPosition.0,
      endPosition.0)
    {
      matrix[currentPosition.1][row] = "H"
      let tailIndex = row - 1
      if row > 0 {
        positions.insert("\(tailIndex)\(currentPosition.1)")
        matrix[currentPosition.1][row] = "T"
      }
    }

    for column in min(currentPosition.1, endPosition.1)..<max(
      currentPosition.1,
      endPosition.1)
    {
      matrix[column][currentPosition.0] = "H"
      let tailIndex = column - 1
      if tailIndex > 0 {
        positions.insert("\(currentPosition.0)\(column)")
        matrix[column][currentPosition.0] = "T"
      }
    }

  }

  // MARK: Private

  private let reader: Reader
}

enum Direction {

  case right(steps: Int), left(steps: Int), up(steps: Int), down(steps: Int)

  // MARK: Lifecycle

  init?(s: Substring, value v: Int) {
    switch s {
    case "R": self = .right(steps: v)
    case "L": self = .left(steps: v)
    case "U": self = .up(steps: v)
    case "D": self = .down(steps: v)
    default: return nil
    }
  }

}
