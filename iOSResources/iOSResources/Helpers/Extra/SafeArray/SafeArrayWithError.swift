/**
 Safe array get, set, insert and delete.
 All action that would cause an reported.
 */
extension Array {
    enum ArrayError: Error {
        case indexOutOfBounds
    }

    /**
     Removes element at index.
     Action that would cause an error are ignored.
     */
    mutating func remove(safeAt index: Index) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }

        return remove(at: index)
    }

    /**
     Inserts element at index.
     Action that would cause an error are ignored.
     */
    mutating func insert(_ element: Element, safeAt index: Index) throws {
        guard index >= 0 && index <= count else {
            throw ArrayError.indexOutOfBounds
        }

        insert(element, at: index)
    }

    /**
     Safe get set subscript.
     Action that would cause an error are ignored.
     */
    func get(safeAt index: Index) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }

        return self[index]
    }
}
