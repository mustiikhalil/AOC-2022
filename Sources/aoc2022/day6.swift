import core
import Foundation

struct Day6_Solution: Runner {

  // MARK: Lifecycle

  init(reader: Reader) {
    self.reader = reader
  }

  // MARK: Internal

  func run(url: URL) throws {
    let file = try reader.read(url: url)
    for index in 0..<file.count {
      if (index + marker) >= file.count {
        throw Errors.couldntParseData
      }
      let startIndex = file.index(file.startIndex, offsetBy: index)
      let endIndex = file.index(startIndex, offsetBy: marker)
      let str = file[startIndex..<endIndex]
      let set = Set(str.map { $0 })
      if set.count == marker {
        print("correct:", str)
        print(index + marker)
        break
      }
    }
  }

  // MARK: Private

  private let reader: Reader
  private let marker = 14

}
