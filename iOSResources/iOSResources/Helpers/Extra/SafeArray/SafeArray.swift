/**
 Safe array get, set, insert and delete.
 All action that would cause an error are ignored.
 */
extension Array {

    /**
     Removes element at index.
     Action that would cause an error are ignored.
     */
    mutating func remove(safeAtIndex index: Index) {
        guard index >= 0 && index < count else {
            print("Index out of bounds while deleting item at index \(index) in \(self). This action is ignored.")
            return
        }

        remove(at: index)
    }

    /**
     Inserts element at index.
     Action that would cause an error are ignored.
     */
    mutating func insert(_ element: Element, safeAtIndex index: Index) {
        guard index >= 0 && index <= count else {
            print("Index out of bounds while inserting item at index \(index) in \(self). This action is ignored")
            return
        }

        insert(element, at: index)
    }

    /**
     Safe get set subscript.
     Action that would cause an error are ignored.
     */
    subscript (safeIndex index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            remove(safeAtIndex: index)

            if let element = newValue {
                insert(element, safeAtIndex: index)
            }
        }
    }
}
