import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final youtubeExplodeProvider = Provider<YoutubeExplode>((ref) {
  return YoutubeExplode();
});
