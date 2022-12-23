import Foundation
import core

struct Day1_Solution: Runner {

  init(reader: Reader) {
    self.reader = reader
  }

  func run(url: URL) throws {
    let file = try reader.read(url: url)
    let elves = file.split(separator: "\n\n")
    var maxValue = 0
    var topThreeValues: [Int] = []
    for elf in elves {
      let total = elf.split(separator: "\n")
        .compactMap { $0.int }
        .sum
      maxValue = max(maxValue, total)

      topThreeValues.append(total)
      if topThreeValues.count > 3 {
        topThreeValues.sort()
        topThreeValues.remove(at: 0)
      }
    }
    print(maxValue)
    print(topThreeValues.sum)
  }

  private let reader: Reader
}
