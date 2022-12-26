import ArgumentParser
import core
import Foundation

// Days

import aoc2022

@main
struct Runner: ParsableCommand {

  static let reader = Reader()

  @Option(name: .shortAndLong)
  var day: String?

  func run() throws {
    guard let day = day, let day = Days(rawValue: day) else {
      throw Errors.missingDay
    }
    try day.run(reader: Runner.reader)
  }

}
