import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_class.dart';
import '../events/events_class.dart';
import '../state/state_class.dart';

class PermissionHandlerView extends StatelessWidget {
  const PermissionHandlerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Background Refresh Permission")),
      body: Center(
        child: BlocBuilder<PermissionBloc, PermissionState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<PermissionBloc>()
                        .add(RequestCameraPermission());
                  },
                  child: const Text("Request Background Refresh Permission"),
                ),
                const SizedBox(height: 20),
                if (state is PermissionGranted)
                  const Text("Permission Granted ✅")
                else if (state is PermissionDenied)
                  const Text("Permission Denied ❌")
                else if (state is PermissionInitial)
                  const Text("Press the button to request permission"),
              ],
            );
          },
        ),
      ),
    );
  }
}
