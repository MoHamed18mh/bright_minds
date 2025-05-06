import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:bright_minds/core/database/cache_key.dart';
import 'package:bright_minds/core/functions/upload_imgae_to_api.dart';
import 'package:bright_minds/core/services/service_locator.dart';
import 'package:bright_minds/features/profile/cubit/profile_state.dart';
import 'package:bright_minds/features/profile/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ApiConsumer api;

  ProfileCubit(this.api) : super(ProfileInitial());

  /// get user id from store
  final userId = getIt<CacheHelper>().getData(key: CacheKey.userId);

  /// current data about user
  String? currentImageUrl;

  /// image var
  XFile? pickedImage;

  /// edit keys
  GlobalKey<FormState> editKey = GlobalKey<FormState>();
  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();
  TextEditingController phoneEditEditController = TextEditingController();

  /// change password
  GlobalKey<FormState> changePassKey = GlobalKey<FormState>();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  Future<void> getUser() async {
    emit(UserLoading());
    try {
      final response = await api.get(EndPoint.getUser(userId));
      final userModel = UserModel.fromJson(response);

      emit(UserSuccess(user: userModel));
    } on ServerException catch (e) {
      emit(UserFailure(error: e.errorModel.error));
    } catch (e) {
      emit(UserFailure(error: e.toString()));
    }
  }

  /// prefill function
  void prefillFields(UserData currentUser) {
    {
      currentImageUrl = currentUser.imageCover;
      final parts = currentUser.displayName.trim().split(' ');
      if (parts.isNotEmpty) {
        firstNameEditController.text = parts[0];
        lastNameEditController.text =
            parts.length > 1 ? parts.sublist(1).join(' ') : '';
      }
      phoneEditEditController.text = currentUser.mobile;
    }
  }

  /// upload image
  void upLoadUserImage(XFile image) {
    pickedImage = image;
    emit(UpLoadUserImage());
  }

  /// edit User profil
  Future<void> editUser() async {
    emit(EditUserLoading());
    try {
      await api.put(
        EndPoint.putUserEdit,
        data: {
          ApiKey.rFirstName: firstNameEditController.text.trim(),
          ApiKey.rLastName: lastNameEditController.text.trim(),
          ApiKey.rMobile: phoneEditEditController.text.trim(),
          if (pickedImage != null)
            ApiKey.rImage: await uploadImageToApi(pickedImage!),
        },
        isFormData: true,
      );
      if (changePassKey.currentState!.validate()) {
        await api.put(
          EndPoint.putChangePass,
          data: {
            ApiKey.oldPass: oldPassController.text.trim(),
            ApiKey.newPass: newPassController.text.trim(),
            ApiKey.confirmPass: confirmPassController.text.trim(),
          },
        );
      }
      emit(EditUserSuccess());
    } on ServerException catch (e) {
      emit(EditUserFailure(error: e.errorModel.errors.toString()));
    } catch (e) {
      emit(EditUserFailure(error: e.toString()));
    }
  }

  /// Toggles between visible/not
  void toggleMenu() {
    if (state is MenueVisible) {
      emit(MenueNotVisible());
    } else {
      emit(MenueVisible());
    }
  }

  Future<void> logOut() async {
    emit(LogOutLoading());
    try {
      await getIt<CacheHelper>().removeData(key: CacheKey.userId);
      await getIt<CacheHelper>().removeData(key: CacheKey.token);
      emit(LogOutSuccess());
    } catch (e) {
      emit(LogOutFailure(error: e.toString()));
      getUser();
    }
  }

  Future<void> deletAccount() async {
    emit(DeleteLoading());
    try {
      await api.delete(EndPoint.deletAccount(
          await getIt<CacheHelper>().getData(key: CacheKey.userId)));
      await getIt<CacheHelper>().removeData(key: CacheKey.userId);
      await getIt<CacheHelper>().removeData(key: CacheKey.token);

      emit(DeleteSuccess());
    } on ServerException catch (e) {
      emit(DeleteFailure(error: e.errorModel.error));
      getUser();
    } catch (e) {
      emit(DeleteFailure(error: e.toString()));
      getUser();
    }
  }

  @override
  Future<void> close() {
    oldPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    firstNameEditController.dispose();
    lastNameEditController.dispose();
    phoneEditEditController.dispose();
    return super.close();
  }
}
