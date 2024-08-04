import XCTest
@testable import Core

final class ArrayReplaceLastTests: XCTestCase {
    func testReplaceLastWithNonEmptyArray() {
        var array = [1, 2, 3, 4]
        array.replaceLast(with: 5)
        XCTAssertEqual(array, [1, 2, 3, 5], "The last element should be replaced with 5.")
    }
    
    func testReplaceLastWithEmptyArray() {
        var array = [Int]()
        array.replaceLast(with: 1)
        XCTAssertTrue(array.isEmpty, "Array should remain empty when trying to replace last element.")
    }
    
    func testReplaceLastWithSingleElementArray() {
        var array = [10]
        array.replaceLast(with: 20)
        XCTAssertEqual(array, [20], "Single element array should be updated to new value.")
    }
}
