import Foundation

extension Array where Element == Int {
  public var sum: Int {
    reduce(0) { partialResult, i in
      partialResult + i
    }
  }
}


extension Array where Element == String {
  public mutating func checkRepeatingCharacter() -> Character {
    sort { str1, str2 in
      str1.count < str2.count
    }
    let firstSet = Set(self[0].map({ $0 }))
    let secondSet = Set(self[1].map({ $0 }))
    var char: Character?
    for character in last! {
      if firstSet.contains(character) && secondSet.contains(character) {
        char = character
        break
      }
    }
    return char!
  }
}
