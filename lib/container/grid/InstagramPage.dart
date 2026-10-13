
import 'package:flutter/material.dart';

class InstagramPage extends StatelessWidget {
  const InstagramPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stories = [
      {'name': 'Cerita Anda', 'image': 'https://picsum.photos/100?1'},
      {'name': 'joko_dev', 'image': 'https://picsum.photos/100?2'},
      {'name': 'flutter_id', 'image': 'https://picsum.photos/100?3'},
      {'name': 'siti_code', 'image': 'https://picsum.photos/100?4'},
      {'name': 'bandung_code', 'image': 'https://picsum.photos/100?5'},
      {'name': 'ui_ux_indo', 'image': 'https://picsum.photos/100?6'},
    ];

    final List<Map<String, String>> posts = [
      {
        'username': 'flutter_id',
        'avatar': 'https://picsum.photos/100?3',
        'postImage': 'https://picsum.photos/500/400?1',
        'caption': 'Belajar membuat layout Flutter itu seru banget! 🚀',
      },
      {
        'username': 'joko_dev',
        'avatar': 'https://picsum.photos/100?2',
        'postImage': 'https://picsum.photos/500/400?2',
        'caption': 'Ngoding santai sore hari di Bandung. ☕',
      },
      {
        'username': 'ui_ux_indo',
        'avatar': 'https://picsum.photos/100?6',
        'postImage': 'https://picsum.photos/500/400?3',
        'caption': 'Tips desain UI/UX untuk aplikasi mobile.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Instagram',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          // Story Instagram
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.orange,
                              Colors.yellow,
                            ],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(story['image']!),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        story['name']!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const Divider(height: 1),

          // Daftar postingan
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header postingan
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(post['avatar']!),
                    ),
                    title: Text(
                      post['username']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(Icons.more_vert),
                  ),

                  // Gambar postingan
                  Image.network(
                    post['postImage']!,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 300,
                        child: Center(
                          child: Icon(Icons.broken_image, size: 50),
                        ),
                      );
                    },
                  ),

                  // Tombol like, komentar, dan share
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.chat_bubble_outline),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {},
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  // Caption postingan
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '${post['username']} ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: post['caption']),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
