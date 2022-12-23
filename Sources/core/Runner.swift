import Foundation

public enum Errors: Error {
  case fileNotFound, fileCantBeOpen, missingURL, missingDay, couldntParseData, poppedEmptyStack
}

public protocol Runner {
  func run(url: URL) throws
}
