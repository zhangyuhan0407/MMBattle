import XCTest
@testable import MMBattleServer

class MMBattleServerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(MMBattleServer().text, "Hello, World!")
    }


    static var allTests : [(String, (MMBattleServerTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
