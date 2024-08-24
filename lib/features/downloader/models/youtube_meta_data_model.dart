import 'dart:convert';

class VideoMetaData {
  final String title;
  final String description;
  final String channel;
  final Duration duration;
  final DateTime uploadDate;
  final String thumbnailUrl; // Added thumbnail URL field

  VideoMetaData({
    required this.title,
    required this.description,
    required this.channel,
    required this.duration,
    required this.uploadDate,
    required this.thumbnailUrl, // Include thumbnail URL in constructor
  });

  VideoMetaData copyWith({
    String? title,
    String? description,
    String? channel,
    Duration? duration,
    DateTime? uploadDate,
    String? thumbnailUrl, // Include thumbnail URL in copyWith
  }) {
    return VideoMetaData(
      title: title ?? this.title,
      description: description ?? this.description,
      channel: channel ?? this.channel,
      duration: duration ?? this.duration,
      uploadDate: uploadDate ?? this.uploadDate,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl, // Update thumbnail URL
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'channel': channel,
      'duration': _durationToMap(duration),
      'uploadDate': uploadDate.millisecondsSinceEpoch,
      'thumbnailUrl': thumbnailUrl, // Add thumbnail URL to map
    };
  }

  factory VideoMetaData.fromMap(Map<String, dynamic> map) {
    return VideoMetaData(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      channel: map['channel'] ?? '',
      duration: _durationFromMap(map['duration']) ?? Duration.zero,
      uploadDate: DateTime.fromMillisecondsSinceEpoch(map['uploadDate'] ?? 0),
      thumbnailUrl: map['thumbnailUrl'] ?? '', // Extract thumbnail URL from map
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoMetaData.fromJson(String source) =>
      VideoMetaData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VideoMetaData(title: $title, description: $description, channel: $channel, duration: $duration, uploadDate: $uploadDate, thumbnailUrl: $thumbnailUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VideoMetaData &&
        other.title == title &&
        other.description == description &&
        other.channel == channel &&
        other.duration == duration &&
        other.uploadDate == uploadDate &&
        other.thumbnailUrl == thumbnailUrl; // Compare thumbnail URL
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        channel.hashCode ^
        duration.hashCode ^
        uploadDate.hashCode ^
        thumbnailUrl.hashCode; // Include thumbnail URL in hashCode
  }

  // Helper methods for Duration
  static Map<String, dynamic> _durationToMap(Duration duration) {
    return {
      'inSeconds': duration.inSeconds,
    };
  }

  static Duration? _durationFromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return Duration(seconds: map['inSeconds'] ?? 0);
  }
}
