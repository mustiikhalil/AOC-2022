import core
import Foundation

struct Day7_Solution: Runner {

  // MARK: Lifecycle

  init(reader: Reader) {
    self.reader = reader
  }

  // MARK: Internal

  func run(url: URL) throws {
    let file = try reader
      .read(url: url)
      .split(separator: "\n")
    Terminal()
      .parse(lines: file)
  }

  // MARK: Private

  private let reader: Reader
}

struct Terminal {
  typealias Leaf = Node<File>
  enum Commands {
    case ls, cd(dir: Substring)

    // MARK: Lifecycle

    init?(value: String) {
      var data = value.split(separator: " ")
      data.removeFirst()

      switch data.first! {
      case "cd": self = .cd(dir: data.last!)
      case "ls": self = .ls
      default: return nil
      }
    }
  }

  var root = Leaf(name: "", data: [], childern: [])

  func parse(lines: [Substring]) {
    var currentDirectory = root
    for line in lines {
      if line.starts(with: "$") {
        let command = Commands(value: String(line))!
        switch command {
        case .ls:
          continue
        case .cd(let dir):
          if dir == "/" {
            currentDirectory = root
          } else if dir == "..", let parent = currentDirectory.parent {
            currentDirectory = parent
          } else {
            currentDirectory = currentDirectory.childern.filter({ node in
              node.name == String(dir)
            }).first!
          }
        }
      } else {
        let objects = line.split(separator: " ")
        if "dir" == objects.first {
          currentDirectory.childern.append(
            Leaf(
              name: String(objects.last!),
              data: [],
              parent: currentDirectory,
              childern: []))
        } else {
          currentDirectory.data.append(
            File(
              name: objects.last!,
              size: objects.first!))
        }
      }
    }
    root.printNode()
    print(root.getSumOfAllDirectoriesUnder100K(sum: 0))
    print(root.sumOfDirectoriesToAddressMemoryIssue(
      totalMemory: 70000000,
      updateSize: 30000000))
  }

}

protocol Sizable {
  var fileSize: Int { get }
}

final class Node<T> where T: Sizable {

  // MARK: Lifecycle

  internal init(
    name: String,
    data: [T],
    parent: Node<T>? = nil,
    childern: [Node<T>])
  {
    self.name = name
    self.data = data
    self.parent = parent
    self.childern = childern
  }

  // MARK: Internal

  var name: String
  var data: [T]
  var parent: Node<T>?
  var childern: [Node<T>]

  var sum: Int {
    if let s = _sum {
      return s
    }
    let _sum = data.reduce(0) { partialResult, object in
      partialResult + object.fileSize
    }
    self._sum = _sum
    return _sum
  }

  var totalSum: Int {
    if let s = _totalSum {
      return s
    }
    let _sum = sum + childern.reduce(0, { $0 + $1.totalSum })
    _totalSum = _sum
    return _sum
  }


  func printNode(indent: Int = 0) {
    let spacing = String(repeating: " ", count: indent)
    print(spacing + "- name: \(name)")
    print(spacing + " - files: \(data)")
    print(spacing + " - size: \(sum) and recersive size: \(totalSum)")
    print(
      spacing +
        " - children: \(childern.map { $0.printNode(indent: indent + 1)})")
  }

  func getSumOfAllDirectoriesUnder100K(sum: Int) -> Int {
    var totalSum = 0
    for i in childern {
      totalSum += i.sumOfAlldirectoriesUnder100KHelper(adder: sum)
    }
    return totalSum
  }

  func sumOfAlldirectoriesUnder100KHelper(adder: Int = 0) -> Int {
    let sum = totalSum
    let total = getSumOfAllDirectoriesUnder100K(sum: adder)
    if sum < 100_000 {
      return adder + sum + total
    }
    return total
  }

  func sumOfDirectoriesToAddressMemoryIssue(
    totalMemory: Int,
    updateSize: Int) -> Int
  {
    let missingMemory = totalMemory - totalSum
    let requiredSpace = updateSize - missingMemory
    let files = fetchAllFiles()
      .sorted(by: { $0.size < $1.size })
    var smallestPossible = 0
    for size in files {
      if size.size >= requiredSpace {
        smallestPossible = size.size
        break
      }
    }
    return smallestPossible
  }

  // MARK: Private

  private var _sum: Int?
  private var _totalSum: Int?

  private func fetchAllFiles() -> [FileSize] {
    var items: [FileSize] = []
    items.append(FileSize(directory: name, size: totalSum))
    for i in childern {
      items.append(
        contentsOf:
        i.fetchAllFiles())
    }
    return items
  }

}

struct FileSize {
  var directory: String
  var size: Int
}

struct File: Sizable {
  var name: Substring
  var size: Substring

  var fileSize: Int {
    size.int!
  }

}
