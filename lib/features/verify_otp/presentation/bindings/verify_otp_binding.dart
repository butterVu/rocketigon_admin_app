import 'package:get/get.dart';

import '../../data/datasources/otp_remote_data_source.dart';
import '../../data/repositories/otp_repository_impl.dart';
import '../../domain/entities/verify_otp_arguments.dart';
import '../../domain/repositories/otp_repository.dart';
import '../../domain/usecases/resend_otp_use_case.dart';
import '../../domain/usecases/verify_otp_use_case.dart';
import '../controllers/verify_otp_controller.dart';

/// Registers the dependencies of the OTP verification screen.
///
/// The route must be opened with [VerifyOtpArguments] as `arguments`.
class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    final arguments = Get.arguments;
    if (arguments is! VerifyOtpArguments) {
      throw ArgumentError.value(
        arguments,
        'Get.arguments',
        'VerifyOtpView requires VerifyOtpArguments',
      );
    }
    Get.lazyPut<OtpRemoteDataSource>(
      () => ApiOtpRemoteDataSource(client: Get.find()),
    );
    Get.lazyPut<OtpRepository>(
      () => OtpRepositoryImpl(
        remoteDataSource: Get.find(),
        tokenStorage: Get.find(),
      ),
    );
    Get.lazyPut(() => VerifyOtpUseCase(repository: Get.find()));
    Get.lazyPut(() => ResendOtpUseCase(repository: Get.find()));
    Get.lazyPut(
      () => VerifyOtpController(
        arguments: arguments,
        verifyOtpUseCase: Get.find(),
        resendOtpUseCase: Get.find(),
      ),
    );
  }
}
