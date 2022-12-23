import Foundation

public struct Stack<Element>: CustomDebugStringConvertible {


  private let title: Substring
  private var items: [Element]

  public var debugDescription: String {
    "\(items) with title: \(title)"
  }

  public var peak: Element? {
    items.last
  }

  public init(title: Substring, items: [Element] = []) {
    self.title = title
    self.items = items
  }

  public mutating func popMultiple(count: Int) throws -> ArraySlice<Element> {
    if items.isEmpty || count > items.count {
      throw Errors.poppedEmptyStack
    }
    let range = items.count - count
    var _items = items[range..<items.count]
    items.removeLast(count)
    return _items
  }

  public mutating func pop() -> Element? {
    if items.isEmpty {
      return nil
    }
    return items.removeLast()
  }

  public mutating func append(_ e: Element) {
    items.append(e)
  }

  public mutating func append(contentOf e: any Collection<Element>) {
    items.append(contentsOf: e)
  }
}
