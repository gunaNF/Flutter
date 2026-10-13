import 'package:flutter/material.dart';
import 'package:projek_flutterpertama/container/list_grid_view/article_list_screen.dart';

class NavigatorWidget extends StatelessWidget {
  const NavigatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const ArticleListScreen();
                },
              ),
            );
          },
          child: const Text('Go to Article List'),
        ),
      ],
    );
  }
}