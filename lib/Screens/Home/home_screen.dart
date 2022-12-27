import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Helper/helper.dart';
import '../../Helper/styles.dart';
import '../../constants.dart';
import '../../controllers/home_controller.dart';
import '../../models/category.dart';
import '../../models/response_model.dart';
import '../../responsive.dart';
import '../../routes.dart';
import 'components/sliver_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final loginController = Get.find<LoginController>();
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(builder: (buider) {
        return FutureBuilder<ResponseModel>(
            future: controller.getCategories(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                return Responsive(
                    mobile: Stack(
                      children: [
                        SizedBox(
                          width: Get.width,
                          height: Get.height,
                          child: NestedScrollView(
                            headerSliverBuilder: (context, innerBoxIsScrolled) {
                              return [
                                SliverToBoxAdapter(
                                  child: Center(
                                    child: Container(
                                      constraints:
                                          BoxConstraints(maxWidth: Get.width),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Header(controller: controller),
                                          const SizedBox(height: 20),
                                          Text('Tin  Tức  Nổi  Bật',
                                              style: mikado900.copyWith(
                                                  fontSize: 28,
                                                  color:
                                                      const Color(0xff333333))),
                                          const SizedBox(height: 30),
                                          NewPopular(controller: controller),
                                          const SizedBox(height: 30),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SliverPersistentHeader(
                                  pinned: true,
                                  delegate: SliverAppBarDelegate(
                                    minHeight: 50,
                                    maxHeight: 70,
                                    child: Container(
                                      // margin: const EdgeInsets.only(bottom: 70),
                                      color: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: TabBar(
                                        controller: controller.tabController,
                                        isScrollable: true,
                                        labelStyle: mikado500.copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .backgroundColor),
                                        indicatorColor: kPrimaryColor,
                                        labelColor: kPrimaryColor,
                                        unselectedLabelColor:
                                            kPrimaryLightColor,
                                        tabs: <Widget>[
                                          for (var item
                                              in controller.listCategories)
                                            Tab(
                                              text: item.name,
                                            )
                                        ],
                                        onTap: ((value) async {
                                          await controller
                                              .getPosts((value + 1).toString());
                                          // logger.i(value);
                                          // logger.e(item);
                                        }),
                                      ),
                                    ),
                                  ),
                                )
                              ];
                            },
                            body: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: controller.tabController,
                              children: <Widget>[
                                for (var item in controller.listCategories)
                                  TabBodyView(item: item)
                                // Text('jahsgdjhas')
                              ],
                            ),
                          ),
                        ),
                        const ButtonAddPost(),
                      ],
                    ),
                    desktop: Stack(
                      alignment: Alignment.center,
                      children: [
                        Background(child: Container()),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          child: Stack(
                            children: [
                              NestedScrollView(
                                headerSliverBuilder:
                                    (context, innerBoxIsScrolled) {
                                  return [
                                    SliverToBoxAdapter(
                                      child: Center(
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: Get.width),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 28),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Header(controller: controller),
                                              const SizedBox(height: 20),
                                              Text('Tin  Tức  Nổi  Bật',
                                                  style: mikado900.copyWith(
                                                      fontSize: 28,
                                                      color: const Color(
                                                          0xff333333))),
                                              const SizedBox(height: 30),
                                              NewPopular(
                                                  controller: controller),
                                              const SizedBox(height: 30),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SliverPersistentHeader(
                                      pinned: true,
                                      delegate: SliverAppBarDelegate(
                                        minHeight: 50,
                                        maxHeight: 70,
                                        child: Container(
                                          color: Colors.black,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: TabBar(
                                            controller:
                                                controller.tabController,
                                            isScrollable: true,
                                            labelStyle: mikado500.copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .backgroundColor),
                                            indicatorColor: kPrimaryColor,
                                            labelColor: kPrimaryColor,
                                            unselectedLabelColor:
                                                kPrimaryLightColor,
                                            tabs: <Widget>[
                                              for (var item
                                                  in controller.listCategories)
                                                Tab(
                                                  text: item.name,
                                                )
                                            ],
                                            onTap: ((value) async {
                                              await controller.getPosts(
                                                  (value + 1).toString());
                                              // controller.listPost([]);
                                              // logger.e(item);
                                            }),
                                          ),
                                        ),
                                      ),
                                    )
                                  ];
                                },
                                body: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: controller.tabController,
                                  children: <Widget>[
                                    for (var item in controller.listCategories)
                                      TabBodyView(item: item)
                                    // Text('asdas')
                                  ],
                                ),
                              ),
                              const ButtonAddPost(),
                            ],
                          ),
                        ),
                      ],
                    ));
              }
            });
      }),
    );
  }
}

class ButtonAddPost extends StatelessWidget {
  const ButtonAddPost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      right: 30,
      child: Container(
        width: 40,
        height: 40,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            Get.rootDelegate.toNamed(Routes.ADD_POST);
          },
          child: const Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TabBodyView extends StatelessWidget {
  const TabBodyView({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Category item;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return GetX<HomeController>(builder: (builder) {
      return ListView.builder(
        itemCount: controller.listPost.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              logger.d(controller.listPost[index].content);
              Get.rootDelegate.toNamed(Routes.POST_DETAIL,
                  arguments: {'item': controller.listPost[index]});
              controller.changeIndex(index);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                // Text(
                //   item.name!,
                //   style: TextStyle(color: Colors.black),
                // ),
                Container(
                  width: double.infinity,
                  height: 230,
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          opacity: 0.3,
                          image: NetworkImage('assets/images/demo.jpeg'),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // item.category!.name ?? "",
                        "Bài viết mới",
                        maxLines: 2,
                        style: mikado700.copyWith(
                            color: Colors.white, fontSize: 21),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.user.name ?? '',
                            maxLines: 2,
                            style: mikado700.copyWith(
                                color: Colors.white, fontSize: 21),
                          ),
                          Text(
                            Helper.getDateTime(
                                controller.listPost[index].createdAt ?? ""),
                            maxLines: 2,
                            style: mikado700.copyWith(
                                color: Colors.white, fontSize: 21),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99999),
            child: Image.network(
              'assets/images/demo_avatar.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // const Spacer(),
        Flexible(
          flex: 3,
          child: Text(
            'Xin Chào ${controller.user.name}',
            style: mikado500.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('assets/images/login_01.jpeg'),
                  fit: BoxFit.cover)),
        );
      },
    );
  }
}

class NewPopular extends StatelessWidget {
  const NewPopular({Key? key, required this.controller}) : super(key: key);
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(40)),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    'assets/images/00CO2PERFUME-superJumbo.webp',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )),
            Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Biến không khí thành nước hoa',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: mikado600.copyWith(
                            fontSize: 20, color: Colors.black54),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(99999),
                            child: Image.network(
                              'assets/images/demo_avatar.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            controller.user.name.toString(),
                            style: mikado400.copyWith(color: Colors.grey),
                          ),
                          const Spacer(),
                          Text(
                            DateFormat('yyyy-MM-dd hh:mm')
                                .format(DateTime.now()),
                            style: mikado400.copyWith(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
