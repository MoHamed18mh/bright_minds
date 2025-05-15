import 'package:bright_minds/core/repository/profile_repo/profile_repo.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:dartz/dartz.dart';
import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:bright_minds/core/functions/upload_imgae_to_api.dart';
import 'package:bright_minds/features/profile/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiConsumer api;
  ProfileRepoImpl({required this.api});

  @override
  Future<Either<String, UserModel>> getUser() async {
    try {
      final response = await api.get(EndPoint.getUser);
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> editUser({
    required String firstName,
    required String lastName,
    required String mobile,
    XFile? imageFile,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
  }) async {
    try {
      final data = <String, dynamic>{
        ApiKey.rFirstName: firstName.trim(),
        ApiKey.rLastName: lastName.trim(),
        ApiKey.rMobile: mobile.trim(),
      };
      if (imageFile != null) {
        data[ApiKey.rImage] = await uploadImageToApi(imageFile);
      }

      // edit user
      await api.put(
        EndPoint.putUserEdit,
        data: data,
        isFormData: true,
      );

      // change password
      if (oldPassword != null &&
          newPassword != null &&
          confirmPassword != null) {
        await api.put(
          EndPoint.putChangePass,
          data: {
            ApiKey.oldPass: oldPassword.trim(),
            ApiKey.newPass: newPassword.trim(),
            ApiKey.confirmPass: confirmPassword.trim(),
          },
        );
      }
      return const Right(AppStrings.done);
    } on ServerException catch (e) {
      return Left(e.errorModel.errors.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteAccount(String userId) async {
    try {
      await api.delete(EndPoint.deletAccount(userId));
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
