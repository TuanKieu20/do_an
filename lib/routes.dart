import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/AddPost/add_post_screen.dart';
import 'Screens/Home/home_screen.dart';
import 'Screens/Login/login_screen.dart';
import 'Screens/Signup/signup_screen.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'Screens/post_detail/pos_detail.dart';

abstract class Routes {
  static const WELCOME = '/';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const HOME = '/home';
  static const ADD_POST = '/add_post';
  static const POST_DETAIL = '/post_detail';
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.WELCOME,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const SignUpScreen(),
    ),
    GetPage(name: Routes.ADD_POST, page: () => const AddPostScreen()),
    GetPage(name: Routes.POST_DETAIL, page: () => const PostDetail())
  ];
}

class AppRouterDelegate extends GetDelegate {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) => route.didPop(result),
      pages: currentConfiguration != null
          ? [currentConfiguration!.currentPage!]
          : [GetNavConfig.fromRoute(Routes.WELCOME)!.currentPage!],
    );
  }
}
