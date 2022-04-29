//
//  Queue.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

/// Queue (FIFO) data structure.
struct Queue<Item> {
    // MARK: Properties

    private var items: [Item]

    // MARK: Initialization

    /// Create a `Queue` data structure.
    init() {
        items = []
    }
}

// MARK: - Public methods

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

// MARK: - CustomStringConvertible

extension Queue: CustomStringConvertible {
    var description: String {
        items.description
    }
}

// MARK: - Equatable

extension Queue: Equatable where Item: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.items == rhs.items
    }
}
