import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:get/get.dart';

import '../../../Helper/styles.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/custom_alter.dart';
import '../../../constants.dart';
import '../../../controllers/login_controller.dart';
import '../../../controllers/register_controller.dart';
import '../../../routes.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.keySignUp,
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
              controller: controller.passController,
              cursorColor: kPrimaryColor,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    controller: controller.nameController,
                    validator: (value) {
                      return controller.validateName(value ?? "");
                    },
                    decoration: const InputDecoration(
                      hintText: "Name",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
                const Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                    )),
                Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        showMaterialNumberPicker(
                          context: context,
                          title: 'Pick Your Age',
                          maxNumber: 100,
                          minNumber: 14,
                          selectedNumber: 21,
                          onChanged: (value) {
                            controller.changeAge(value.toString());
                          },
                          onConfirmed: () {
                            controller.update();
                          },
                        );
                      },
                      child: GetBuilder<RegisterController>(builder: (builder) {
                        return Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(999999)),
                          child: Text(
                            controller.age() == '' ? 'Age' : controller.age(),
                            style: mikado600.copyWith(color: kPrimaryColor),
                          ),
                        );
                      }),
                    )),
              ],
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              if (controller.keySignUp.currentState!.validate()) {
                final res = await controller.signUp(
                    email: controller.emailController.text,
                    password: controller.passController.text,
                    name: controller.nameController.text,
                    age: int.parse('${controller.age}'));
                logger.e(res.data);
                if (res.isSuccess) {
                  logger.e(res.isSuccess);
                  final loginController = Get.find<LoginController>();

                  loginController.emailController.text =
                      controller.emailController.text;
                  loginController.passController.text =
                      controller.passController.text;
                  Get.rootDelegate.toNamed(Routes.LOGIN);
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
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return LoginScreen();
              //     },
              //   ),
              // );
              Get.rootDelegate.toNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
    );
  }
}
