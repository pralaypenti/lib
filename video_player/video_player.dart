//event
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
abstract class VideoEvent {}

class PlayVideo extends VideoEvent {}

class PauseVideo extends VideoEvent {}
//state
class VideoState {
  final bool isPlaying;
  const VideoState(this.isPlaying);
}
//bloc


class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoPlayerController controller;

  VideoBloc(this.controller) : super(VideoState(false)) {
    on<PlayVideo>((event, emit) {
      controller.play();
      emit(VideoState(true));
    });

    on<PauseVideo>((event, emit) {
      controller.pause();
      emit(VideoState(false));
    });
  }
}
//ui


class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      // Replace with actual Pawan Kalyan video clip URL if available
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )..initialize().then((_) {
        setState(() {}); // Refresh UI when ready
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoBloc(_controller),
      child: Scaffold(
        appBar: AppBar(title: Text("Honey Bee Video Player")),
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : CircularProgressIndicator(),
        ),
        floatingActionButton: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                final bloc = context.read<VideoBloc>();
                state.isPlaying ? bloc.add(PauseVideo()) : bloc.add(PlayVideo());
              },
              child: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow),
            );
          },
        ),
      ),
    );
  }
}
