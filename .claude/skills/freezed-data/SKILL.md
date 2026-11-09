---
name: freezed-data
description: Use when creating entities, models, union types or Result types with freezed or json_serializable, or running build_runner code generation.
---

## Data Handling & Serialization

### Freezed for Immutable Classes
* **Freezed Package:** Use `freezed` with `freezed_annotation` for immutable data classes with built-in serialization, equality, and copyWith.
* **Union Types:** Use freezed for sealed classes and union types (e.g., API states, results). These require the `abstract` keyword.
* **Code Generation:** Freezed requires `build_runner` for code generation.
* **Models vs Entities:** Use freezed for both domain entities and data models.
* **Abstract Keyword:** Required for classes with multiple factory constructors (union types), optional for single constructor classes.
* **Custom Methods:** Add a private `._()` constructor to enable custom methods and getters on freezed classes.

#### Adding Freezed
```shell
flutter pub add freezed_annotation
flutter pub add json_annotation
flutter pub add dev:freezed
flutter pub add dev:build_runner
flutter pub add dev:json_serializable
```

#### Domain Entities with Freezed
```dart
// Domain entity (pure business object)
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
  }) = _User;
}
```

#### Data Models with Freezed + JSON Serialization
```dart
// Data model (with JSON serialization)
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _UserModel;
  
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
```

#### Union Types (Sealed Classes)
Use freezed for representing states, results, or discriminated unions. Classes with multiple constructors require the `abstract` keyword:

```dart
// API Response State
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_state.freezed.dart';

@freezed
abstract class ApiState<T> with _$ApiState<T> {
  const factory ApiState.initial() = _Initial<T>;
  const factory ApiState.loading() = _Loading<T>;
  const factory ApiState.success(T data) = _Success<T>;
  const factory ApiState.error(String message) = _Error<T>;
}

// Usage in controller
class UserController extends GetxController {
  final _userState = const ApiState<User>.initial().obs;
  ApiState<User> get userState => _userState.value;
  
  Future<void> fetchUser(String id) async {
    _userState.value = const ApiState.loading();
    
    try {
      final user = await userRepository.getUser(id);
      _userState.value = ApiState.success(user);
    } catch (e) {
      _userState.value = ApiState.error(e.toString());
    }
  }
}

// In view - pattern matching
Obx(() => controller.userState.when(
      initial: () => const Text('No data'),
      loading: () => const CircularProgressIndicator(),
      success: (user) => Text('Hello ${user.name}'),
      error: (message) => Text('Error: $message'),
    ))
```

#### Result Type Pattern
```dart
@freezed
abstract class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(String error) = Failure<T>;
}

// Usage in use case
class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase({required this.repository});
  
  Future<Result<User>> execute(String email, String password) async {
    try {
      final user = await repository.login(email, password);
      return Result.success(user);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}

// In controller
Future<void> login() async {
  final result = await loginUseCase.execute(email, password);
  
  result.when(
    success: (user) {
      Get.snackbar('Success', 'Welcome ${user.name}');
      Get.offAllNamed(Routes.home);
    },
    failure: (error) {
      Get.snackbar('Error', error);
    },
  );
}
```

#### Freezed Features
* **Immutability:** All freezed classes are immutable by default.
* **CopyWith:** Automatic `copyWith` method for creating modified copies.
* **Equality:** Automatic `==` and `hashCode` implementation.
* **toString:** Automatic readable `toString()` implementation.
* **Pattern Matching:** `when`, `maybeWhen`, `map`, `maybeMap` methods.
* **Custom Methods:** Add custom methods/getters using private `._()` constructor.

```dart
// CopyWith example
final user = User(id: '1', name: 'John', email: 'john@example.com');
final updatedUser = user.copyWith(name: 'Jane');

// Pattern matching with map
userState.map(
  initial: (_) => const SizedBox(),
  loading: (_) => const CircularProgressIndicator(),
  success: (state) => UserWidget(user: state.data),
  error: (state) => ErrorWidget(message: state.message),
);

// MaybeWhen with orElse
userState.maybeWhen(
  success: (user) => Text(user.name),
  orElse: () => const Text('Loading...'),
);
```

#### Adding Custom Methods to Freezed Classes
Use the private `._()` constructor to add custom methods or getters:

```dart
@freezed
class User with _$User {
  const User._(); // Private constructor for custom methods
  
  const factory User({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
  }) = _User;
  
  // Custom getters
  String get fullName => '$firstName $lastName';
  
  // Custom methods
  bool hasValidEmail() {
    return email.contains('@') && email.contains('.');
  }
  
  String get initials {
    return '${firstName[0]}${lastName[0]}'.toUpperCase();
  }
}

// Usage
final user = User(
  id: '1',
  firstName: 'John',
  lastName: 'Doe',
  email: 'john@example.com',
);
print(user.fullName); // John Doe
print(user.initials); // JD
```

#### Custom Methods on Union Types
```dart
@freezed
abstract class ApiState<T> with _$ApiState<T> {
  const ApiState._(); // Private constructor
  
  const factory ApiState.initial() = _Initial<T>;
  const factory ApiState.loading() = _Loading<T>;
  const factory ApiState.success(T data) = _Success<T>;
  const factory ApiState.error(String message) = _Error<T>;
  
  // Custom getters
  bool get isLoading => this is _Loading<T>;
  bool get isSuccess => this is _Success<T>;
  bool get hasError => this is _Error<T>;
  
  // Custom methods
  T? get dataOrNull => maybeWhen(
        success: (data) => data,
        orElse: () => null,
      );
}

// Usage in view
if (controller.userState.isLoading) {
  // Show loading indicator
}

final user = controller.userState.dataOrNull;
if (user != null) {
  // Use user data
}
```

### Alternative: json_serializable (without freezed)
For cases where freezed is not needed, use `json_serializable` directly:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  final String id;
  final String name;
  final String email;
  final DateTime? createdAt;
  
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
      
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
```

### When to Use Each Approach
* **Use Freezed when:**
  - You need union types or sealed classes
  - You want automatic `copyWith`, `==`, and `hashCode`
  - You're building data classes throughout your app
  - You want type-safe pattern matching
  - You prefer immutability by default

* **Use json_serializable (without freezed) when:**
  - You only need JSON serialization
  - You want more control over class implementation
  - You're working with legacy code that doesn't use freezed
  - The added code generation is not desired

## Code Generation
* **Build Runner:** If the project uses code generation, ensure that `build_runner` is listed as a dev dependency in `pubspec.yaml`.
* **Code Generation Tasks:** Use `build_runner` for all code generation tasks, such as for `json_serializable`.
* **Running Build Runner:** After modifying files that require code generation, run the build command:

```shell
dart run build_runner build --delete-conflicting-outputs
```

