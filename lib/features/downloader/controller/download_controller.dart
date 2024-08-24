// lib/features/video/state/video_meta_data_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ft_yt_downloader/features/downloader/models/youtube_meta_data_model.dart';
import 'package:ft_yt_downloader/features/downloader/service/youtube_service.dart';

class DownloadControllerNotifier
    extends StateNotifier<AsyncValue<VideoMetaData?>> {
  final YoutubeServiceImpl _youtubeService;

  DownloadControllerNotifier(this._youtubeService)
      : super(const AsyncValue.data(null));

  Future<void> fetchVideoMetaData(String url) async {
    state = const AsyncValue.loading();
    final result = await _youtubeService.getMetaData(url);
    result.match(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (metaData) {
        state = AsyncValue.data(metaData);
      },
    );
  }
}

final downloadControllerProvider =
    StateNotifierProvider<DownloadControllerNotifier, AsyncValue>((ref) {
  final youtubeService = ref.watch(youtubeServiceProvider);
  return DownloadControllerNotifier(youtubeService);
});
