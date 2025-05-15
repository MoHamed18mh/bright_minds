import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:bright_minds/core/database/cache_key.dart';
import 'package:bright_minds/core/repository/profile_repo/profile_repo.dart';
import 'package:bright_minds/core/services/service_locator.dart';
import 'package:bright_minds/features/profile/cubit/profile_state.dart';
import 'package:bright_minds/features/profile/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repo;
  ProfileCubit(this.repo) : super(ProfileInitial());

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
    final result = await repo.getUser();
    result.fold(
      (error) => emit(UserFailure(error: error)),
      (model) => emit(UserSuccess(user: model)),
    );
  }

  void prefillFields(UserData user) {
    {
      currentImageUrl = user.imageCover;
      firstNameEditController.text = user.firstName;
      lastNameEditController.text = user.lastName;
      phoneEditEditController.text = user.mobile;
    }
  }

  void upLoadUserImage(XFile image) {
    pickedImage = image;
    emit(UpLoadUserImage());
  }

  Future<void> editUser() async {
    if (editKey.currentState?.validate() != true) return;

    emit(EditUserLoading());
    final result = await repo.editUser(
      firstName: firstNameEditController.text,
      lastName: lastNameEditController.text,
      mobile: phoneEditEditController.text,
      imageFile: pickedImage,
      oldPassword: changePassKey.currentState!.validate()
          ? oldPassController.text
          : null,
      newPassword: changePassKey.currentState!.validate()
          ? newPassController.text
          : null,
      confirmPassword: changePassKey.currentState!.validate()
          ? confirmPassController.text
          : null,
    );
    result.fold(
      (error) => emit(EditUserFailure(error: error)),
      (success) => emit(EditUserSuccess(success: success)),
    );
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

  Future<void> deleteAccount() async {
    emit(DeleteLoading());
    final result = await repo.deleteAccount(userId);
    result.fold(
      (error) {
        emit(DeleteFailure(error: error));
        getUser();
      },
      (_) async {
        await getIt<CacheHelper>().removeData(key: CacheKey.userId);
        await getIt<CacheHelper>().removeData(key: CacheKey.token);
        emit(DeleteSuccess());
      },
    );
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
