import 'package:bloc/bloc.dart';
import 'package:farmer_digital/services/helpers.dart';
import 'package:flutter/material.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingInital());

  showLoading(
    BuildContext context,
    String message,
    bool isDismissible,
  ) =>
      showProgress(
        context,
        message,
        isDismissible,
      );

  hideLoading() => hideProgress();
}
