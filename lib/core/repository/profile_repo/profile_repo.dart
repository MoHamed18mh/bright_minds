import 'package:dartz/dartz.dart';
import 'package:bright_minds/features/profile/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileRepo {
  Future<Either<String, UserModel>> getUser();

  Future<Either<String, String>> editUser({
    required String firstName,
    required String lastName,
    required String mobile,
    XFile? imageFile,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
  });

  Future<Either<String, void>> deleteAccount(String userId);
}
