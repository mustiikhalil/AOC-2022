import core
import Foundation

struct Day4_Solution: Runner {

  // MARK: Lifecycle

  init(reader: Reader) {
    self.reader = reader
  }

  // MARK: Internal

  func run(url: URL) throws {
    let file = try reader.read(url: url)
    let works = file
      .split(separator: "\n")
      .compactMap { try? Work(line: $0) }

    var i = 0
    var r = 0
    for work in works {
      if work.within {
        i += 1
      }
      if work.singleWithin {
        r += 1
      }
    }
    print(i)
    print(r)
  }

  // MARK: Private

  private let reader: Reader
}

struct Work {

  // MARK: Lifecycle

  init(line: Substring) throws {
    let content = line.split(separator: ",")
    firstClamp = try content.first!.range()
    secondClamp = try content.last!.range()
  }

  // MARK: Internal

  var within: Bool {
    isWithin(firstClamp, testRange: secondClamp) || isWithin(
      secondClamp,
      testRange: firstClamp)
  }

  var singleWithin: Bool {
    isWithin(firstClamp, testRange: secondClamp) ||
      isWithin(secondClamp, testRange: firstClamp) ||
      continuesClamp(firstClamp, testRange: secondClamp) ||
      continuesClamp(secondClamp, testRange: firstClamp) ||
      isSingleWithin(firstClamp, testRange: secondClamp)
  }

  // MARK: Private

  private let firstClamp: Range<Int>
  private let secondClamp: Range<Int>

  private func isWithin(_ range: Range<Int>, testRange: Range<Int>) -> Bool {
    range.lowerBound <= testRange.lowerBound && testRange.upperBound <= range
      .upperBound
  }

  private func isSingleWithin(
    _ range: Range<Int>,
    testRange: Range<Int>) -> Bool
  {
    range.lowerBound == testRange.lowerBound || testRange.upperBound == range
      .upperBound || range.upperBound == testRange.lowerBound || testRange
      .upperBound == range.lowerBound
  }

  private func continuesClamp(
    _ range: Range<Int>,
    testRange: Range<Int>) -> Bool
  {
    testRange.lowerBound <= range.upperBound && range.upperBound <= testRange
      .upperBound
  }
}
