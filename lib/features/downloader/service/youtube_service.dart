import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ft_yt_downloader/core/core.dart';
import 'package:ft_yt_downloader/core/failure.dart';
import 'package:ft_yt_downloader/features/downloader/models/youtube_meta_data_model.dart';

final youtubeServiceProvider = Provider<YoutubeServiceImpl>((ref) {
  final youtubeExplode = ref.watch(youtubeExplodeProvider);
  return YoutubeServiceImpl(youtubeExplode: youtubeExplode);
});

//Abstract Interface Class
abstract interface class YoutubeService {
  FutureEither<VideoMetaData> getMetaData(String url);
}

//Concrete Class
class YoutubeServiceImpl implements YoutubeService {
  final YoutubeExplode _youtubeExplode;

  YoutubeServiceImpl({YoutubeExplode? youtubeExplode})
      : _youtubeExplode = youtubeExplode ?? YoutubeExplode();

  @override
  FutureEither<VideoMetaData> getMetaData(String url) async {
    try {
      final video = await _youtubeExplode.videos.get(url);

      final metaData = VideoMetaData(
        thumbnailUrl: video.thumbnails.standardResUrl,
        title: video.title,
        description: video.description,
        channel: video.author,
        duration: video.duration ?? Duration.zero,
        uploadDate: video.uploadDate ?? DateTime.now(),
      );
      return right(metaData);
    } catch (e, stackTrace) {
      return left(Failure(
        message: 'Failed to fetch video metadata',
        code: 500,
        stackTrace: stackTrace,
      ));
    }
  }
}
