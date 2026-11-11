import 'package:flutter/material.dart';
import 'package:projek_flutterpertama/container/grid/InstagramPage.dart';
import 'package:projek_flutterpertama/container/list_grid_view/article_list_screen.dart';
import 'package:projek_flutterpertama/pages/about_page.dart';
import 'package:projek_flutterpertama/pages/form_page.dart';
import 'package:projek_flutterpertama/pages/home_page.dart';
import 'package:projek_flutterpertama/pages/input_page.dart';
import 'package:projek_flutterpertama/pages/output_page.dart'; 
import 'package:projek_flutterpertama/pages/eskul_form.dart';
import 'package:projek_flutterpertama/container/grid/GridInstagram.dart';
import 'package:projek_flutterpertama/pages/food_list_page.dart';

class AppRoute {
  static const home = '/';
  static const articleList = '/article-list';
  static const about = '/about';
  static const instagram = '/instagram';
  static const form = '/form';
  static const eskul = '/eskul';
  static const gridInstagram = '/grid-instagram';
  static const foodList = '/food-list';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    articleList: (context) => const ArticleListScreen(),
    about: (context) => const AboutPage(),
    instagram: (context) => const InstagramPage(),
    form: (context) => const BelajarForm(),
    eskul: (context) => const EskulForm(),
    gridInstagram: (context) => const Gridinstagram(),
    foodList: (context) => const FoodListScreen(),
  }; 
}