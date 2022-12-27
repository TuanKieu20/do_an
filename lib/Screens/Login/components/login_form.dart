import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/custom_alter.dart';
import '../../../constants.dart';
import '../../../controllers/login_controller.dart';
import '../../../routes.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return GetBuilder<LoginController>(builder: (builder) {
      return Form(
        key: controller.keyLogin,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              controller: controller.emailController,
              validator: (value) {
                return controller.validateEmail(value ?? "");
              },
              decoration: const InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                obscureText: true,
                cursorColor: kPrimaryColor,
                controller: controller.passController,
                validator: (value) {
                  return controller.validatePass(value ?? "");
                },
                decoration: const InputDecoration(
                  hintText: "Your password",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.keyLogin.currentState!.validate()) {
                    final res = await controller.login(
                        email: controller.emailController.text,
                        password: controller.passController.text);
                    if (res.isSuccess) {
                      Get.rootDelegate.toNamed(Routes.HOME);
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlert(
                                labelText: res.message,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                });
                          });
                    }
                  } else {
                    logger.e('validate');
                  }
                },
                child: Text(
                  "Login".toUpperCase(),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              press: () {
                Get.rootDelegate.toNamed(Routes.SIGNUP);
              },
            ),
          ],
        ),
      );
    });
  }
}
