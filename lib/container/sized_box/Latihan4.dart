import 'package:flutter/material.dart';

class Latihan4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 16, 97, 189),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
              )
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://imgs.search.brave.com/Hjq6sPYipQKcPB0ltTmomY05YN2j9Gpirx7egAMMeoo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMjIz/MjU5MjUwMi9waG90/by9iYWhsaWwtbGFo/YWRhbGlhLW1pbmlz/dGVyLW9mLWVuZXJn/eS1hbmQtbWluZXJh/bC1yZXNvdXJjZXMt/YW5kLWNoYWlycGVy/c29uLW9mLXRoZS1n/b2xrYXItcGFydHku/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PXJPRlc4NFdEWUZH/NmtiMzQwb3hLcm9B/QkxZNl9vMjZmVVZf/WllHaWdsbE09",
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Rudy Gunawan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "XII RPL 1",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.notifications,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Color(0xFFD4AF37),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "tetap semangat",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Ayo belajar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "click me",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F2C59),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}