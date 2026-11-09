---
name: flutter-testing
description: Use when writing or running unit, widget or integration tests for Flutter/GetX code.
---

## Testing
* **Running Tests:** To run tests, use the `run_tests` tool if it is available, otherwise use `flutter test`.
* **Unit Tests:** Use `package:test` for unit tests.
* **Widget Tests:** Use `package:flutter_test` for widget tests.
* **Integration Tests:** Use `package:integration_test` for integration tests.
* **Assertions:** Prefer using `package:checks` for more expressive and readable assertions over the default `matchers`.

### Testing Best Practices
* **Convention:** Follow the Arrange-Act-Assert (or Given-When-Then) pattern.
* **Unit Tests:** Write unit tests for use cases, repositories, and controllers.
* **Widget Tests:** Write widget tests for UI components.
* **Integration Tests:** For broader application validation, use integration tests to verify end-to-end user flows.
* **Mocks:** Prefer fakes or stubs over mocks. If mocks are absolutely necessary, use `mockito` or `mocktail`.
* **GetX Testing:** Use `Get.testMode = true;` and `Get.reset()` in tests.

```dart
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setUp(() {
    Get.testMode = true;
  });
  
  tearDown(() {
    Get.reset();
  });
  
  test('HomeController increments counter', () {
    // Arrange
    final controller = HomeController(
      authUseCase: MockAuthUseCase(),
    );
    
    // Act
    controller.increment();
    
    // Assert
    expect(controller.count, 1);
  });
}
```

