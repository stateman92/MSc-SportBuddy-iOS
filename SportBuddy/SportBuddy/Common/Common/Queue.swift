//
//  Queue.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

/// Queue (FIFO) data structure.
struct Queue<Item> {
    private var items: [Item]

    /// Create a `Queue` data structure.
    init() {
        items = []
    }
}

extension Queue {
    /// The number of the stored items.
    var count: Int {
        items.count
    }

    /// Enqueue an item.
    /// - Parameters:
    ///   - _: the item.
    mutating func enqueue(_ item: Item) {
        items.append(item)
    }

    /// Dequeue the first item.
    /// - Returns:
    ///     The item.
    @discardableResult mutating func dequeue() -> Item? {
        !items.isEmpty ? items.removeFirst() : nil
    }

    /// Peek the first item.
    /// - Returns:
    ///     The item.
    func peek() -> Item? {
        items.first
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        items.description
    }
}

extension Queue: Equatable where Item: Equatable {
    static func == (lhs: Queue, rhs: Queue) -> Bool {
        lhs.items == rhs.items
    }
}
