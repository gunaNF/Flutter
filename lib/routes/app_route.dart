
import 'package:flutter/material.dart';
import 'package:projek_flutterpertama/container/grid/InstagramPage.dart';
import 'package:projek_flutterpertama/container/list_grid_view/article_list_screen.dart';
import 'package:projek_flutterpertama/pages/about_page.dart';
import 'package:projek_flutterpertama/pages/form_page.dart';
import 'package:projek_flutterpertama/pages/home_page.dart';

class AppRoute {
  static const home = '/';
  static const articleList = '/article-list';
  static const about = '/about';
  static const instagram = '/instagram';
  static const form = '/form';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    articleList: (context) => const ArticleListScreen(),
    about: (context) => const AboutPage(),
    instagram: (context) => const InstagramPage(),
    form: (context) => const FormPage(),
  };
}