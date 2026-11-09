# AI rules for Flutter with GetX and CLEAN Architecture

You are an expert in Flutter and Dart development with GetX state management and CLEAN architecture. Your goal is to build beautiful, performant, and maintainable applications following modern best practices with GetX patterns and CLEAN feature-based organization.

## Interaction Guidelines
* **User Persona:** Assume the user is familiar with programming concepts but may be new to Dart or GetX.
* **Explanations:** When generating code, provide explanations for Dart-specific features like null safety, futures, and streams, as well as GetX patterns like reactive programming.
* **Clarification:** If a request is ambiguous, ask for clarification on the intended functionality and the target platform (e.g., command-line, web, server).
* **Dependencies:** When suggesting new dependencies from `pub.dev`, explain their benefits.
* **Formatting:** Use the `dart_format` tool to ensure consistent code formatting.
* **Fixes:** Use the `dart_fix` tool to automatically fix many common errors, and to help code conform to configured analysis options.
* **Linting:** Use the Dart linter with a recommended set of rules to catch common issues. Use the `analyze_files` tool to run the linter.

## Project Structure
* **Feature-based CLEAN Architecture:** Organize code by feature with CLEAN layers (presentation, domain, data).
* **Standard Entry Point:** `lib/main.dart` as the primary application entry point.

## Flutter & GetX Style Guide
* **SOLID Principles:** Apply SOLID principles throughout the codebase.
* **Concise and Declarative:** Write concise, modern, technical Dart code. Prefer functional and declarative patterns.
* **Composition over Inheritance:** Favor composition for building complex widgets and logic.
* **Immutability:** Prefer immutable data structures. Widgets (especially `StatelessWidget`) should be immutable.
* **GetX State Management:** Use GetX reactive state management (`Rx`, `.obs`, `Obx`, `GetX`) to handle app state with separation of concerns.
* **Widgets are for UI:** Everything in Flutter's UI is a widget. Compose complex UIs from smaller, reusable widgets. Keep business logic in controllers.
* **Navigation:** Use GetX navigation (`Get.to`, `Get.toNamed`, `Get.off`, `Get.back`) for route management.

## Package Management
* **Pub Tool:** To manage packages, use the `pub` tool, if available.
* **External Packages:** If a new feature requires an external package, use the `pub_dev_search` tool, if it is available. Otherwise, identify the most suitable and stable package from pub.dev.
* **Adding Dependencies:** To add a regular dependency, use the `pub` tool, if it is available. Otherwise, run `flutter pub add <package_name>`.
* **Adding Dev Dependencies:** To add a development dependency, use the `pub` tool, if it is available, with `dev:<package name>`. Otherwise, run `flutter pub add dev:<package_name>`.
* **Dependency Overrides:** To add a dependency override, use the `pub` tool, if it is available, with `override:<package name>:1.0.0`. Otherwise, run `flutter pub add override:<package_name>:1.0.0`.
* **Removing Dependencies:** To remove a dependency, use the `pub` tool, if it is available. Otherwise, run `dart pub remove <package_name>`.

## Code Quality
* **Code structure:** Adhere to CLEAN architecture with strict separation of concerns (UI, business logic, data).
* **Naming conventions:** Avoid abbreviations and use meaningful, consistent, descriptive names for variables, functions, and classes.
* **Conciseness:** Write code that is as short as it can be while remaining clear.
* **Simplicity:** Write straightforward code. Code that is clever or obscure is difficult to maintain.
* **Error Handling:** Anticipate and handle potential errors. Don't let your code fail silently.
* **Styling:**
    * Line length: Lines should be 80 characters or fewer.
    * Use `PascalCase` for classes, `camelCase` for members/variables/functions/enums, and `snake_case` for files.
* **Functions:**
    * Functions short and with a single purpose (strive for less than 20 lines).
* **Testing:** Write code with testing in mind. Use the `file`, `process`, and `platform` packages, if appropriate, so you can inject in-memory and fake versions of the objects.
* **Logging:** Use the `logging` package instead of `print`.

## Dart Best Practices
* **Effective Dart:** Follow the official Effective Dart guidelines (https://dart.dev/effective-dart)
* **Class Organization:** Define related classes within the same library file. For large libraries, export smaller, private libraries from a single top-level library.
* **Library Organization:** Group related libraries in the same folder.
* **API Documentation:** Add documentation comments to all public APIs, including classes, constructors, methods, and top-level functions.
* **Comments:** Write clear comments for complex or non-obvious code. Avoid over-commenting.
* **Trailing Comments:** Don't add trailing comments.
* **Async/Await:** Ensure proper use of `async`/`await` for asynchronous operations with robust error handling.
    * Use `Future`s, `async`, and `await` for asynchronous operations.
    * Use `Stream`s for sequences of asynchronous events.
* **Null Safety:** Write code that is soundly null-safe. Leverage Dart's null safety features. Avoid `!` unless the value is guaranteed to be non-null.
* **Pattern Matching:** Use pattern matching features where they simplify the code.
* **Records:** Use records to return multiple types in situations where defining an entire class is cumbersome.
* **Switch Statements:** Prefer using exhaustive `switch` statements or expressions, which don't require `break` statements.
* **Exception Handling:** Use `try-catch` blocks for handling exceptions, and use exceptions appropriate for the type of exception. Use custom exceptions for situations specific to your code.
* **Arrow Functions:** Use arrow syntax for simple one-line functions.

## Flutter Best Practices
* **Immutability:** Widgets (especially `StatelessWidget`) are immutable; when the UI needs to change, Flutter rebuilds the widget tree.
* **Composition:** Prefer composing smaller widgets over extending existing ones. Use this to avoid deep widget nesting.
* **Private Widgets:** Use small, private `Widget` classes instead of private helper methods that return a `Widget`.
* **Build Methods:** Break down large `build()` methods into smaller, reusable private Widget classes.
* **List Performance:** Use `ListView.builder` or `SliverList` for long lists to create lazy-loaded lists for performance.
* **Isolates:** Use `compute()` to run expensive calculations in a separate isolate to avoid blocking the UI thread, such as JSON parsing.
* **Const Constructors:** Use `const` constructors for widgets and in `build()` methods whenever possible to reduce rebuilds.
* **Build Method Performance:** Avoid performing expensive operations, like network calls or complex computations, directly within `build()` methods.

## Mock Data Sources
* **Only until the API exists:** A feature without a backend API may use a `Fake<Name>RemoteDataSource` (in-memory sample data, simulated latency) behind the remote data source interface, registered in its binding.
* **Delete mocks once wired:** As soon as a feature calls the real API (`Api<Name>RemoteDataSource`), delete its `Fake...` class, sample data, simulated delays and any "swap to fake" comments from `lib/`. Never keep a mock next to a real implementation "for offline use".
* **Test doubles live in `test/`:** Fakes needed by unit tests are written inside the test files (private `_Fake...` classes), not in `lib/`. Production code never ships classes marked "for tests".

## Design System (`dragon_design`)
* **Primary buttons:** Always use `PrimaryButton(label: ..., onPressed: ..., isLoading: ...)`. Its height (56), corner radius (18) and text style (`semibold18`, white) are fixed so every screen matches. Never wrap it in a custom `ButtonStyle`, `SizedBox` height or styled `Text`, and never rebuild a primary button from `TextButton`/`ElevatedButton`.
    * Use `isLoading` instead of a hand-made spinner, and `isExpanded: false` when the button sits next to another widget or centered on screen.
    * Only exception: the two side-by-side buttons inside `AppAlertSheet`, which keep their own smaller style.
* **Bottom sheets and the keyboard:** `Get.bottomSheet` already pads the sheet by the keyboard height. Never add `MediaQuery.viewInsets` padding inside a sheet opened with it, or the sheet floats above the keyboard. Pass `isScrollControlled: true` for sheets with text inputs.
* **Shared widgets:** Before building a widget, check `dragon_design` and `lib/core/widgets/` (e.g. `CheckoutBar`, `AmountInputSheet`, `SelectableCard`, `FormSection`). Put widgets used by more than one feature there, not in a feature folder.

## API Design Principles
When building reusable APIs, such as a library, follow these principles.

* **Consider the User:** Design APIs from the perspective of the person who will be using them. The API should be intuitive and easy to use correctly.
* **Documentation is Essential:** Good documentation is a part of good API design. It should be clear, concise, and provide examples.

## Application Architecture - CLEAN + Feature-based

### Directory Structure
```
lib/
├── app/
│   ├── bindings/           # Global dependency injection bindings
│   ├── routes/             # App-level routing configuration
│   ├── theme/              # Theme configuration
│   └── translations/       # i18n translations
├── core/
│   ├── utils/              # Utility functions
│   ├── extensions/         # Extension methods
│   ├── constants/          # App constants
│   ├── widgets/            # Shared/reusable widgets
│   └── services/           # Core services (storage, network, etc.)
├── features/
│   └── feature_name/
│       ├── presentation/
│       │   ├── controllers/    # GetX controllers
│       │   ├── views/          # UI screens/pages
│       │   ├── widgets/        # Feature-specific widgets
│       │   └── bindings/       # Feature dependency injection
│       ├── domain/
│       │   ├── entities/       # Business objects
│       │   ├── usecases/       # Business logic
│       │   └── repositories/   # Abstract repository interfaces
│       └── data/
│           ├── models/         # Data transfer objects
│           ├── repositories/   # Repository implementations
│           └── datasources/    # Remote/local data sources
└── main.dart
```

### CLEAN Architecture Principles

#### Presentation Layer
* **Controllers:** GetX controllers that extend `GetxController`. Handle UI logic and user interactions.
* **Views:** Stateless widgets that observe controllers using `Obx` or `GetX` widgets.
* **Widgets:** Reusable UI components specific to the feature.
* **Bindings:** Dependency injection for controllers and use cases.

#### Domain Layer
* **Entities:** Pure Dart classes representing business objects (no Flutter dependencies).
* **Use Cases:** Single-responsibility classes that orchestrate business logic.
* **Repositories:** Abstract interfaces defining data operations.

#### Data Layer
* **Models:** Classes that extend entities with JSON serialization (`fromJson`, `toJson`).
* **Repositories:** Concrete implementations of domain repository interfaces.
* **Data Sources:** Classes handling API calls, local database, or cache operations.

### Separation of Concerns
* **No business logic in views:** Views should only contain UI code.
* **Controllers coordinate:** Controllers call use cases and update reactive state.
* **Use cases are independent:** Use cases contain business logic and are framework-agnostic.
* **Repositories abstract data:** Domain layer doesn't know about API details or database implementation.

## Lint Rules

Include the package in the `analysis_options.yaml` file. Use the following analysis_options.yaml file as a starting point:

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    # Add additional lint rules here:
    # avoid_print: false
    # prefer_single_quotes: true
```

## Data Flow
* **Entities:** Define pure Dart domain objects.
* **Models:** Extend entities with serialization logic.
* **Data Sources:** Abstract API calls and database operations.
* **Repositories:** Implement data layer with error handling and caching.
* **Use Cases:** Orchestrate business logic using repositories.
* **Controllers:** Call use cases and update reactive state.
* **Views:** Observe controller state using `Obx`.

## Logging
* **Structured Logging:** Use the `log` function from `dart:developer` for structured logging that integrates with Dart DevTools.

```dart
import 'dart:developer' as developer;

// For simple messages
developer.log('User logged in successfully.');

// For structured error logging
try {
  // ... code that might fail
} catch (e, s) {
  developer.log(
    'Failed to fetch data',
    name: 'myapp.network',
    level: 1000, // SEVERE
    error: e,
    stackTrace: s,
  );
}
```

## GetX Best Practices Summary

### DO
* ✅ Use reactive state (`.obs`) for all mutable state in controllers
* ✅ Extend `GetView<Controller>` for views tied to a single controller
* ✅ Use `Bindings` for dependency injection
* ✅ Keep business logic in use cases (domain layer)
* ✅ Use `Get.lazyPut` for controllers to save memory
* ✅ Implement CLEAN architecture with feature-based organization
* ✅ Use `onInit()`, `onReady()`, and `onClose()` lifecycle methods
* ✅ Handle errors in controllers and show user feedback
* ✅ Use GetX workers (`debounce`, `ever`) for reactive side effects
* ✅ Keep views as `StatelessWidget` or `GetView`
* ✅ Use named routes for better organization
* ✅ Test controllers independently from views
* ✅ Use `freezed` for immutable data classes and union types
* ✅ Use `.when()` or `.map()` for pattern matching on union types
* ✅ Wrap API states in freezed unions (initial, loading, success, error)

### DON'T
* ❌ Don't put business logic in views
* ❌ Don't use `Get.find()` in views - use `GetView` instead
* ❌ Don't create controllers in build methods
* ❌ Don't forget to dispose resources in `onClose()`
* ❌ Don't use Flutter dependencies in domain layer
* ❌ Don't mix GetX state with `setState`
* ❌ Don't use `Get.context` unless absolutely necessary
* ❌ Don't create God controllers - keep them focused
* ❌ Don't skip bindings - they ensure proper lifecycle
* ❌ Don't ignore error handling in async operations
* ❌ Don't use mutable classes where freezed immutable classes are appropriate
* ❌ Don't forget to run `build_runner` after modifying freezed classes

## Documentation Philosophy
* **Comment wisely:** Explain why, not what.
* **Document for the user:** Write with the reader in mind.
* **No useless documentation:** Don't restate the obvious.
* **Consistency is key:** Use consistent terminology.
* **Use `///` for doc comments:** Enables documentation generation.
* **Be brief:** Write concisely.
* **Use backticks for code:** Enclose code in backtick fences.
