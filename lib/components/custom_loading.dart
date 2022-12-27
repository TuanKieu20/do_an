import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/loading_controller.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({Key? key, required this.child, this.tapDismiss = false})
      : super(key: key);
  final Widget child;
  final bool tapDismiss;

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {
  final _loadingController = Get.put(LoadingController());

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          widget.child,
          GetX<LoadingController>(
            builder: (builder) {
              return _loadingController.showLoading()
                  ? GestureDetector(
                      onTap: () {
                        if (widget.tapDismiss) {
                          _loadingController.changeShowLoading(false);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.grey.withOpacity(0.7),
                        child: Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            )),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

showLoadingOverlay() {
  Get.find<LoadingController>().changeShowLoading(true);
}

hideLoadingOverlay() {
  Get.find<LoadingController>().changeShowLoading(false);
}
