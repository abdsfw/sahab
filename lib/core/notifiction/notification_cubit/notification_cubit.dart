import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/notifiction/notification_repo.dart';
import 'package:sahab_project/core/notifiction/notification_services.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  NotificationCubit get(context) => BlocProvider.of(context);

  Future<void> sendNotificationToken() async {
    emit(NotificationLoading());
    var result = await NotificationRepo().sendToken({
      "token": await NotificationServices().getDeviceToken(),
      "user_id": await CacheHelper.getData(key: Constant.kUserId)
    });
    result.fold((error) {
      debugPrint('error.errMassage: ${error.errMassage} ${error.statusCode}');
      emit(NotificationFailure(errMessage: error.errMassage));
    }, (send) {
      emit(NotificationSuccess());
    });
  }
}
