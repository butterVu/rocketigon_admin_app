---
name: getx-state
description: Use when writing GetX controllers, views (GetView/Obx), bindings and dependency injection, use cases and repositories, GetxService, GetX utilities (snackbar, dialog, bottom sheet) or workers (ever, debounce).
---

## State Management with GetX

### Reactive Programming
* **Reactive Variables:** Use `.obs` to make variables reactive: `var count = 0.obs;`
* **Observing State:** Use `Obx(() => Widget)` for reactive rebuilds on specific widgets.
* **GetX Widget:** Use `GetX<Controller>` widget for more complex scenarios with automatic controller management.
* **GetBuilder:** Use for non-reactive updates when `.update()` is called explicitly.

### Controllers
* **Extend GetxController:** All controllers should extend `GetxController`.
* **Lifecycle Methods:** Use `onInit()`, `onReady()`, and `onClose()` for lifecycle management.
* **Reactive State:** Declare observable state using `.obs` extension.
* **Business Logic:** Keep all business logic in controllers, not in views.

```dart
class HomeController extends GetxController {
  final AuthUseCase authUseCase;
  
  HomeController({required this.authUseCase});
  
  // Reactive state
  final _count = 0.obs;
  int get count => _count.value;
  
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  
  @override
  void onInit() {
    super.onInit();
    // Initialize
  }
  
  @override
  void onReady() {
    super.onReady();
    // Called after onInit, when widget is rendered
    fetchData();
  }
  
  @override
  void onClose() {
    // Dispose resources
    super.onClose();
  }
  
  void increment() => _count.value++;
  
  Future<void> fetchData() async {
    _isLoading.value = true;
    try {
      final result = await authUseCase.execute();
      // Handle result
    } catch (e) {
      // Handle error
    } finally {
      _isLoading.value = false;
    }
  }
}
```

### Views with GetX
* **Use Obx:** Wrap widgets that need to rebuild with `Obx`.
* **GetView:** Extend `GetView<Controller>` for views tied to a single controller.
* **Stateless Preferred:** Keep views as `StatelessWidget` or `GetView`.

```dart
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Obx(() => controller.isLoading
            ? const CircularProgressIndicator()
            : Text('Count: ${controller.count}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### Dependency Injection with GetX
* **Bindings:** Use `Bindings` class to inject dependencies for each feature.
* **Lazy Loading:** Dependencies are created only when needed.
* **Get.put:** Use for immediate instantiation.
* **Get.lazyPut:** Use for lazy instantiation.
* **Get.find:** Retrieve already instantiated dependencies.

```dart
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Inject use cases
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: Get.find(),
      ),
    );
    
    Get.lazyPut<AuthUseCase>(
      () => AuthUseCase(repository: Get.find()),
    );
    
    // Inject controller
    Get.lazyPut<HomeController>(
      () => HomeController(authUseCase: Get.find()),
    );
  }
}
```

### Use Cases Pattern
* **Single Responsibility:** Each use case handles one business operation.
* **Framework Independent:** No Flutter or GetX dependencies in use cases.
* **Repository Pattern:** Use cases depend on repository abstractions.

```dart
// Domain layer - Use case
class GetUserProfileUseCase {
  final UserRepository repository;
  
  GetUserProfileUseCase({required this.repository});
  
  Future<User> execute(String userId) async {
    return await repository.getUserProfile(userId);
  }
}

// Domain layer - Repository interface
abstract class UserRepository {
  Future<User> getUserProfile(String userId);
  Future<void> updateUserProfile(User user);
}

// Data layer - Repository implementation
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<User> getUserProfile(String userId) async {
    try {
      final userModel = await remoteDataSource.fetchUser(userId);
      await localDataSource.cacheUser(userModel);
      return userModel.toEntity();
    } catch (e) {
      // Try local cache on error
      return await localDataSource.getCachedUser(userId);
    }
  }
  
  @override
  Future<void> updateUserProfile(User user) async {
    final model = UserModel.fromEntity(user);
    await remoteDataSource.updateUser(model);
    await localDataSource.cacheUser(model);
  }
}
```

## GetX Services
* **Global Services:** Use `GetxService` for app-wide services that persist.
* **Never Dispose:** Services extending `GetxService` are never disposed.
* **Examples:** Storage service, network service, auth service.

```dart
class StorageService extends GetxService {
  late SharedPreferences _prefs;
  
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }
  
  String? getString(String key) => _prefs.getString(key);
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);
}

// Initialize in main
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}
```

## GetX Utilities
* **GetX Snackbars:** Use `Get.snackbar()` for notifications.
* **GetX Dialogs:** Use `Get.dialog()` and `Get.defaultDialog()`.
* **GetX BottomSheets:** Use `Get.bottomSheet()`.
* **Get.context:** Access context anywhere (use sparingly).
* **Get.theme:** Access theme anywhere.

```dart
// Show snackbar
Get.snackbar(
  'Success',
  'Profile updated successfully',
  snackPosition: SnackPosition.BOTTOM,
);

// Show dialog
Get.defaultDialog(
  title: 'Confirm',
  middleText: 'Are you sure?',
  onConfirm: () => controller.delete(),
  onCancel: () => Get.back(),
);
```

## GetX Workers
* **ever:** Runs every time the variable changes.
* **once:** Runs only the first time the variable changes.
* **debounce:** Runs after user stops typing for specified duration.
* **interval:** Ignores changes for specified duration.

```dart
class SearchController extends GetxController {
  final searchText = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    
    // Debounce search - wait 800ms after user stops typing
    debounce(
      searchText,
      (_) => performSearch(),
      time: const Duration(milliseconds: 800),
    );
  }
  
  void performSearch() {
    // Execute search
  }
}
```

