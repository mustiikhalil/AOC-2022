import core
import Foundation

public enum Days: String {
  case day1, day2, day3, day4, day5

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
    }
  }

  private var url: URL {
    URL(filePath: "./files/\(self.rawValue).txt")
  }
}
