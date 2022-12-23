import Foundation
import core

struct Day5_Solution: Runner {

  init(reader: Reader) {
    self.reader = reader
  }

  func run(url: URL) throws {
    let file = try reader.read(url: url)
    let data = file.split(separator: "\n\n")
    let objects = data.first!
    var structure = Structure(objects)
    structure.parse()
    let moves = Moves(data.last!.split(separator: "\n"))
    print(structure)
    try structure.move(by: moves, keepsOrder: true)
    print(structure.peak())
  }

  private let reader: Reader
}

typealias Move = (count: Int, from: Int, to: Int)

struct Moves {

  var moves: [Move]

  init(_ moves: [Substring]) {
    self.moves = moves
      .compactMap { str -> (Int, Int, Int)? in
        // Ugly decoding
        // wanted to use str.index
        let v = str
          .split(separator: " ")
          .compactMap { $0.int }
        return (v[0], v[1], v[2])
      }
  }

}

struct Structure: CustomDebugStringConvertible {

  typealias SubStringStack = Stack<Substring>


  private let str: String
  var stacks: [SubStringStack] = []

  var debugDescription: String {
    return "\(stacks.map { "\($0.debugDescription)" }.joined(separator: "\n"))"
  }

  init(_ str: Substring) {
    // Ugly decoding
    self.str = String(str)
      .replacingOccurrences(of: "    ", with: " x ")
  }

  mutating func parse() {
    // Ugly decoding
    var splittedItems = str.split(separator: "\n")
    let symbols = splittedItems.removeLast()
    stacks = symbols
      .split(separator: " ")
      .compactMap { SubStringStack(title: $0) }

    for line in splittedItems.reversed() {
      let values = line.split(separator: " ")
      for (index, value) in values.enumerated() {
        if value == "x" || stacks.count <= index { continue }
        stacks[index].append(value)
      }
    }
  }

  mutating func move(by moves: Moves, keepsOrder ordered: Bool = false) throws {
    for move in moves.moves {
      let items = try stacks[move.from - 1].popMultiple(
        count: move.count)
      if ordered {
        stacks[move.to - 1].append(
          contentOf: items)
      } else {
        stacks[move.to - 1].append(
          contentOf: items.reversed())
      }
    }
  }

  mutating func peak() -> String {
    return stacks
      .map {
        "\($0.peak ?? "")"
        .replacingOccurrences(of: "[", with: "")
        .replacingOccurrences(of: "]", with: "")
      }
      .joined()
  }
}

