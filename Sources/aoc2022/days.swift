import core
import Foundation

final class BundleClass {}

public enum Days: String {
  case day1, day2, day3, day4, day5, day6, day7, day8, day9, day10

  // MARK: Public

  public func run(reader: Reader) throws {
    switch self {
    case .day1:
      try Day1_Solution(reader: reader).run(url: url)
    case .day2:
      try Day2_Solution(reader: reader).run(url: url)
    case .day3:
      try Day3_Solution(reader: reader).run(url: url)
    case .day4:
      try Day4_Solution(reader: reader).run(url: url)
    case .day5:
      try Day5_Solution(reader: reader).run(url: url)
    case .day6:
      try Day6_Solution(reader: reader).run(url: url)
    case .day7:
      try Day7_Solution(reader: reader).run(url: url)
    case .day8:
      try Day8_Solution(reader: reader).run(url: url)
    case .day9:
      try Day9_Solution(reader: reader).run(url: url)
    case .day10:
      try Day10_Solution(reader: reader).run(url: url)
    }
  }

  // MARK: Private

  private var url: URL {
    URL(
      filePath: "./AOC-2022_aoc2022.bundle/Contents/Resources/files/\(rawValue).txt")
  }
}
