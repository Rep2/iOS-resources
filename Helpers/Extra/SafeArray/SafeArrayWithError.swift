/**
 Safe array get, set, insert and delete.
 All action that would cause an error are ignored.
 */
extension Array {

    /**
     Removes element at index.
     Action that would cause an error are ignored.
     */
    mutating func remove(safeAt index: Index) throws {
        guard index >= 0 && index < count else {
            throw GenericError.error(text: "Index out of bounds while deleting item at index \(index) in \(self).")
        }

        remove(at: index)
    }

    /**
     Inserts element at index.
     Action that would cause an error are ignored.
     */
    mutating func insert(_ element: Element, safeAt index: Index) throws {
        guard index >= 0 && index <= count else {
            throw GenericError.error(text: "Index out of bounds while inserting item at index \(index) in \(self).")
        }

        insert(element, at: index)
    }

    /**
     Safe get set subscript.
     Action that would cause an error are ignored.
     */
    func get(safe index: Index) throws -> Element  {
        if indices.contains(index) {
            return self[index]
        } else {
            throw GenericError.error(text: "Index out of bounnds while geting item at index \(index) in \(self).")
        }
    }
}
