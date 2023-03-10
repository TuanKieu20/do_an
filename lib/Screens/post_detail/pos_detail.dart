import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/styles.dart';
import '../../constants.dart';
import '../../controllers/home_controller.dart';
import '../../routes.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postItem = Get.arguments;
    final homecontroller = Get.find<HomeController>();
    final posts = homecontroller.listPost;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        leading: IconButton(
            onPressed: () {
              Get.rootDelegate.toNamed(Routes.HOME);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            )),
        title: Text(
          'Bài viết mới',
          style: mikado600.copyWith(),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nội dung bài viết',
                    style:
                        mikado700.copyWith(color: Colors.black, fontSize: 30),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      posts[homecontroller.indexPost()].content ?? "",
                      style:
                          mikado400.copyWith(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
