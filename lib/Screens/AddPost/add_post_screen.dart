import 'package:flutter/material.dart';
import 'package:do_an/components/custom_loading.dart';
import 'package:get/get.dart';

import '../../Helper/styles.dart';
import '../../components/custom_alter.dart';
import '../../constants.dart';
import '../../controllers/add_post_controller.dart';
import '../../responsive.dart';
import '../../routes.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final controller = Get.put(PostControlelr());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: CustomLoading(
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: kPrimaryLightColor,
                title: Text(
                  'Thêm bài viết mới',
                  style: mikado600.copyWith(color: Colors.black),
                ),
                // leadingWidth: 100,
                // leading: Center(
                //     child: Text(
                //   'Cancel',
                //   textAlign: TextAlign.right,
                //   style: mikado500.copyWith(color: Colors.black),
                // )),
              ),
              body: Responsive(
                mobile: _Body(
                  controller: controller,
                ),
                desktop: Center(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: _Body(
                        controller: controller,
                      )),
                ),
              )),
        ));
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final PostControlelr controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Tiêu đề',
            //   style: mikado500.copyWith(color: Colors.black54),
            //   textAlign: TextAlign.left,
            // ),
            const SizedBox(height: 10),
            // SizedBox(
            //   width: double.infinity,
            //   // height: 50,
            //   child: TextFormField(
            //     controller: controller.titleTextEditingController,
            //     validator: (value) {
            //       return controller.validateTitle(value ?? '');
            //     },
            //     decoration: InputDecoration(
            //         hintText: 'Nhập tiêu đề . . . . . ',
            //         hoverColor: Colors.transparent,
            //         hintStyle:
            //             mikado400.copyWith(color: Colors.grey, fontSize: 14),
            //         fillColor: Colors.white10,
            //         filled: true,
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10))),
            //   ),
            // ),
            // const SizedBox(height: 10),
            Text(
              'Nội dung',
              style: mikado500.copyWith(color: Colors.black54),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
                controller: controller.contentTextEditingController,
                maxLines: 10,
                validator: (value) {
                  return controller.validateContent(value ?? '');
                },
                decoration: InputDecoration(
                    hintText: 'Nhập nội dung . . . . .',
                    hintStyle:
                        mikado400.copyWith(color: Colors.grey, fontSize: 14),
                    fillColor: Colors.white10,
                    filled: true,
                    hoverColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: InkWell(
                onTap: () async {
                  if (controller.formKey.currentState!.validate()) {
                    final res = await controller.addPost(
                        content: controller.contentTextEditingController.text);
                    if (res.isSuccess) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlert(
                                buttonText: 'Về trang chủ',
                                labelText:
                                    'Thêm bài viết thành công thuộc chủ để ${res.data['name']}',
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Get.rootDelegate.toNamed(Routes.HOME);
                                });
                          });
                    }
                  }
                },
                child: Container(
                  width: 140,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.blue),
                      color: kPrimaryLightColor),
                  child: Text(
                    'Thêm',
                    style: mikado500.copyWith(color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
