import XCTest
import Combine
@testable import SpecialtyCoffeeApp

class LoginViewModelTests: XCTestCase {
    private var viewModel: LoginViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testLoginSuccess() {
        // Given
        viewModel.username = "user"
        viewModel.password = "password"

        let expectation = XCTestExpectation(description: "Login succeeds")

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        viewModel.login()

        // Then
        wait(for: [expectation], timeout: 3.0)
    }

    func testLoginFailure() {
        // Given
        viewModel.username = "wrong"
        viewModel.password = "credentials"

        let expectation = XCTestExpectation(description: "Login fails")

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Invalid credentials")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        viewModel.login()

        // Then
        wait(for: [expectation], timeout: 3.0)
    }
}