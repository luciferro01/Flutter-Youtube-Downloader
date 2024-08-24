import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ft_yt_downloader/core/core.dart';

final youtubeServiceProvider = Provider<YoutubeServiceImpl>((ref) {
  return YoutubeServiceImpl();
});

abstract interface class YoutubeService {
  FutureEither<String> getMetaData({required String url});
}

class YoutubeServiceImpl implements YoutubeService {
  @override
  FutureEither<String> getMetaData({required String url}) {
    // TODO: implement getMetaData
    throw UnimplementedError();
  }
}
