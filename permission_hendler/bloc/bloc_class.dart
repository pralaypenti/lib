import 'package:bloc_stm/permission_hendler/events/events_class.dart';
import 'package:bloc_stm/permission_hendler/state/state_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<RequestCameraPermission>((event, emit) async {
      // inside your bloc event handler
      if (Platform.isAndroid) {
        final status = await Permission.camera.request();

        if (status.isGranted) {
          emit(PermissionGranted());
        } else {
          emit(PermissionDenied());
        }
      } else {
        emit(PermissionDenied()); 
      }
    });
  }
}
