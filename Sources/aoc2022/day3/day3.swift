import Foundation
import core

struct Day3_Solution: Runner {

  init(reader: Reader) {
    self.reader = reader
  }

  func run(url: URL) throws {
    let file = try reader.read(url: url)
    let lines = file
      .split(separator: "\n")
      .compactMap { str in
        StringMapper(str: str)
      }

    var i = 0
    var total = 0
    var items: [String] = []
    for line in lines {
      i += (line.similarCharacter.int ?? 0)
      items.append(line.fillStr)
      if items.count == 3 {
        total += (items.checkRepeatingCharacter().int ?? 0)
        items = []
      }
    }
    print(i)
    print(total)
  }

  private let reader: Reader
}


struct StringMapper {

  init(str subString: Substring) {
    let index = subString.index(
      subString.startIndex,
      offsetBy: subString.count / 2)
    str = [
      subString[subString.startIndex..<index],
      subString[index..<subString.endIndex]
    ]
  }

  var similarCharacter: Character {
    let str1 = str[0]
    let str2 = str[1]
    var char: Character?
    for c in str1 {
      if str2.contains(where: { $0 == c }) {
        char = c
      }
    }
    return char!
  }

  var fillStr: String {
    String(str[0] + str[1])
  }

  private let str: [Substring]
}
