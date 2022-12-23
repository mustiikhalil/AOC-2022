import Foundation
import core

struct Day2_Solution: Runner {

  init(reader: Reader) {
    self.reader = reader
  }

  func run(url: URL) throws {
    let file = try reader.read(url: url)
    let tournament = file
      .split(separator: "\n")
      .compactMap { str in
        try? GameRound(str: str)
      }
    var total = 0
    var secondTotal = 0
    for round in tournament {
      total += round.playRound1()
      secondTotal += round.playRound2()
    }
    print("\(total) \(secondTotal)")
  }

  private let reader: Reader
}


struct GameRound {

  init(str: Substring) throws {
    let values = str.split(separator: " ")
    guard
      let opponent = Shape(values[0]),
      let me = Shape(values[1]),
      let meRound = Round(rawValue: values[1]) else
    {
      throw Errors.couldntParseData
    }
    self.opponent = opponent
    self.me = me
    self.meRound = meRound
  }

  func playRound1() -> Int {
    me.game(opponent: opponent) + me.handScore
  }

  func playRound2() -> Int {
    meRound.game(opponent: opponent)
  }

  private let opponent: Shape
  private let me: Shape
  private let meRound: Round
}

enum Shape: String {
  case scissors, paper, rock

  init?(_ arg: Substring) {
    switch arg {
    case "A", "X":
      self = .rock
    case "B", "Y":
      self = .paper
    case "C", "Z":
      self = .scissors
    default:
      return nil
    }
  }

  var handScore: Int {
    switch self {
    case .scissors:
      return 3
    case .paper:
      return 2
    case .rock:
      return 1
    }
  }

  var counter: Shape {
    switch self {
    case .scissors:
      return .rock
    case .paper:
      return .scissors
    case .rock:
      return .paper
    }
  }

  var loserHand: Shape {
    switch self {
    case .scissors:
      return .paper
    case .paper:
      return .rock
    case .rock:
      return .scissors
    }
  }

  func game(opponent: Shape) -> Int {
    switch (self, opponent) {
    case (.scissors, .scissors), (.paper, .paper), (.rock, .rock):
      return 3
    case (.scissors, .paper), (.paper, .rock), (.rock, .scissors):
      return 6
    default:
      return 0
    }
  }
}

enum Round: Substring {
  case x = "X", y = "Y", z = "Z"

  func game(opponent: Shape) -> Int {
    switch self {
    case .x:
      return opponent.loserHand.handScore
    case .y:
      return 3 + opponent.handScore
    case .z:
      return 6 + opponent.counter.handScore
    }
  }

}
