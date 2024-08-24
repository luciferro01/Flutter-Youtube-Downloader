import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ft_yt_downloader/features/downloader/controller/download_controller.dart';

class DownloadScreen extends ConsumerWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlController = TextEditingController();
    final videoMetaData = ref.watch(downloadControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Video Downloader'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field for the YouTube URL
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: 'YouTube Video URL',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final url = urlController.text;
                    if (url.isNotEmpty) {
                      ref
                          .read(downloadControllerProvider.notifier)
                          .fetchVideoMetaData(url);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Display loading indicator, error, or video metadata
            videoMetaData.when(
              data: (metaData) {
                if (metaData == null) {
                  return const Text('No data available. Please enter a URL.');
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display video thumbnail
                    CachedNetworkImage(
                      imageUrl: metaData.thumbnailUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    // Display video details
                    Text(
                      'Title: ${metaData.title}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Channel: ${metaData.channel}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Duration: ${metaData.duration.inMinutes}:${metaData.duration.inSeconds % 60}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Upload Date: ${metaData.uploadDate}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16.0),
                    // Accordion for description
                    ExpansionTile(
                      title: const Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.sizeOf(context).height * 0.3),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                metaData.description,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Text('Error: $error'),
            ),
          ],
        ),
      ),
    );
  }
}
