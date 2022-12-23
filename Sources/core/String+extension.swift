import Foundation

extension Character {

  public var int: Int? {
    Int(String(self))
  }

  public var asciiInt: Int? {
    guard let asciiValue = asciiValue else { return nil }
    let value = Int(asciiValue)
    return value - converter
  }

  private var converter: Int {
    return isUppercase ? 38 : 96
  }
}

extension Substring {

  /// Translates a substring to int
  public var int: Int? {
    Int(self)
  }

  public func range() throws -> Range<Int> {
    let data = split(separator: "-")
    guard let first = data.first?.int, let last = data.last?.int else {
      throw Errors.couldntParseData
    }
    return Range(uncheckedBounds: (first, last))
  }

  public func value(between range: Range<Substring.Index>) -> Substring {
    self[range]
  }

  public func emptySpace(after pointer: String.Index) -> Index? {
    self[pointer..<endIndex].firstIndex(where: { $0 == " " })
  }

}
