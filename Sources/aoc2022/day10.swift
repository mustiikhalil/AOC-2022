import core
import Foundation

struct Day10_Solution: Runner {

  // MARK: Lifecycle

  init(reader: Reader) {
    self.reader = reader
  }

  // MARK: Internal

  func run(url: URL) throws {
    let file = try reader.read(url: url)
    var cpu = CPU()
    cpu.instructions(file: file)
  }

  // MARK: Private

  private let reader: Reader
}


struct CPU {
  mutating func instructions(file: String) {
    let executions = file.split(separator: "\n")

    for execution in executions {
      print(execution)
      if execution == "noop" {
        numberOfCycles += 1
      } else {
        execution.split(separator: " ").forEach { command in
          startDrawing()
          if let _value = command.int {
            drawingPosition += _value
            numberOfCycles += 1
            value += _value
          } else {
            drawingPosition += 1
            numberOfCycles += 1
          }
        }
      }
      if numberOfCycles > 20 {
        break
      }
    }
    print(totalSignal.reduce(0, { partialResult, value in
      partialResult + value
    }))
    chars.printArray()
  }
  var value = 1

  var upperLimitForCycle = 20
  let CRTLowerLimit = 40
  var totalSignal: [Int] = []
  var numberOfCycles = 0 {
    didSet {
      if numberOfCycles == upperLimitForCycle {
        upperLimitForCycle += 40
        let sum = value * numberOfCycles
        totalSignal.append(sum)
      }
    }
  }

  var drawingPosition = 0

  var chars = Array(repeating: Array(repeating: ".", count: 40), count: 6)


  private mutating func startDrawing() {
    let v = numberOfCycles / CRTLowerLimit
    if value > 0 && v < 6 {
      print("v: \(v) value: \(value) position: \(drawingPosition)")
      print(chars[v].map { "\($0)" }.joined())
      chars[v][drawingPosition] = "X"
    }
  }
}
