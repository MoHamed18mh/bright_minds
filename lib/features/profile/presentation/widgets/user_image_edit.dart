import 'dart:io';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/utils/app_assets.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserImageEdit extends StatelessWidget {
  const UserImageEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProfileCubit>();

    return Center(
      child: InkWell(
        onTap: () {
          ImagePicker()
              .pickImage(source: ImageSource.gallery)
              .then((value) => cubit.upLoadUserImage(value!));
        },
        child: Stack(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: ClipOval(child: userImage(cubit)),
            ),
            Positioned(
              right: 10,
              bottom: 4,
              child: Icon(
                Icons.camera_alt,
                size: 26,
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget userImage(ProfileCubit cubit) {
    if (cubit.pickedImage != null) {
      return Image.file(
        File(cubit.pickedImage!.path),
        fit: BoxFit.cover,
      );
    } else if (cubit.currentImageUrl != null &&
        cubit.currentImageUrl != ApiKey.imageNull) {
      return CachedNetworkImage(
        imageUrl: cubit.currentImageUrl!,
        fit: BoxFit.cover,
        memCacheHeight: 300,
        placeholder: (context, url) => const ContainerShimmer(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else {
      return Image.asset(
        Assets.assetsImagesUser,
        fit: BoxFit.cover,
      );
    }
  }
}
