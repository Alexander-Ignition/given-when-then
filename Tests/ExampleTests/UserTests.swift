import XCTest
import GivenWhenThen
@testable import Example

final class UserTests: TestCase {

    func testName0() {
        // Given
        var user = User(name: "Alex")

        // When
        user.name = "Bob"

        // Then
        XCTAssertEqual(user.name, "Bob")
    }

    func testName1() {
        var user = XCTContext.runActivity(named: "Given: Create user") { _ -> User in
            return User(name: "Alex")
        }
        XCTContext.runActivity(named: "When: Change name") { _ -> Void in
            user.name = "Bob"
        }
        XCTContext.runActivity(named: "Then: Check new name") { _ -> Void in
            XCTAssertEqual(user.name, "Bob")
        }
    }

    func testName2() {
        given("Create user")
        var user = User(name: "Alex")

        when("Change name")
        user.name = "Bob"

        then("Check new name")
        XCTAssertEqual(user.name, "Bob")
    }
}
