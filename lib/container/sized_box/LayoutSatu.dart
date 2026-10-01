import 'package:flutter/material.dart';

class LayoutSatu extends StatelessWidget {
  const LayoutSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
      height: 72,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [ BoxShadow(color: Colors.black,blurRadius: 6,)],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://imgs.search.brave.com/Hjq6sPYipQKcPB0ltTmomY05YN2j9Gpirx7egAMMeoo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMjIz/MjU5MjUwMi9waG90/by9iYWhsaWwtbGFo/YWRhbGlhLW1pbmlz/dGVyLW9mLWVuZXJn/eS1hbmQtbWluZXJh/bC1yZXNvdXJjZXMt/YW5kLWNoYWlycGVy/c29uLW9mLXRoZS1n/b2xrYXItcGFydHku/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PXJPRlc4NFdEWUZH/NmtiMzQwb3hLcm9B/QkxZNl9vMjZmVVZf/WllHaWdsbE09"),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rudy Gunawan"),
                SizedBox(height: 4),
                Text("XII RPL 1"),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}