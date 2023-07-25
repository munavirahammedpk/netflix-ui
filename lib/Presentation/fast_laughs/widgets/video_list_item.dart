import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/Domain/downloads/models/downloads_response/downloads_response.dart';
import 'package:netflix/Presentation/fast_laughs/widgets/video_actions.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/strings.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../Application/fast_laugh/fast_laugh_bloc.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final DownloadsResultData movieData;

  const VideoListItemInheritedWidget(
      {required this.widget, required this.movieData, super.key})
      : super(child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;

  VideoListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(
          videoUrl: videoUrl,
          onStateChanged: (bool) {},
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.black.withOpacity(.7),
                  onPressed: (() {}),
                  child: const Icon(
                    Icons.volume_off_sharp,
                    size: 30,
                    color: whiteColor,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage: posterPath == null
                              ? null
                              : NetworkImage(
                                  '$imageBaseUrl$posterPath',
                                )),
                    ),
                    ValueListenableBuilder(
                        valueListenable: likedVideoIdsNotifier,
                        builder: (context, newLikedIds, _) {
                          final _index = index;
                          if (newLikedIds.contains(_index)) {
                            return GestureDetector(
                              onTap: () {
                                likedVideoIdsNotifier.value.remove(_index);
                                likedVideoIdsNotifier.notifyListeners();
                                // BlocProvider.of<FastLaughBloc>(context)
                                //     .add(UnLikeVideo(id: _index));
                              },
                              child: const VideoActionswidget(
                                  icon: Icons.favorite, title: 'Liked'),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                likedVideoIdsNotifier.value.add(_index);
                                likedVideoIdsNotifier.notifyListeners();
                              },
                              child: const VideoActionswidget(
                                  icon: Icons.emoji_emotions, title: 'LOL'),
                            );
                          }
                        }),
                    const VideoActionswidget(icon: Icons.add, title: 'My List'),
                    GestureDetector(
                        onTap: () {
                          final movieName =
                              VideoListItemInheritedWidget.of(context)!
                                  .movieData
                                  .title;
                          Share.share('$movieName');
                        },
                        child: const VideoActionswidget(
                            icon: Icons.share, title: 'Share')),
                    const VideoActionswidget(
                        icon: Icons.play_arrow, title: 'Play'),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.onStateChanged,
  });

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.play();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
