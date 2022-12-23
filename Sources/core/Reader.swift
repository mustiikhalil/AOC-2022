import Foundation

public struct Reader {
  private let manager: FileManager

  public init(fileManager: FileManager = FileManager.default) {
    manager = fileManager
  }

  public func read(url: URL) throws -> String {
    let path = url.path()
    guard manager.isReadableFile(atPath: path) else {
      throw Errors.fileNotFound
    }
    guard let data = try? String(contentsOf: url, encoding: .utf8) else {
      throw Errors.fileCantBeOpen
    }
    return data
  }
}
