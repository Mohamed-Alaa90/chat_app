import 'package:chat_app/cubit/auth_cubit/login/login_cubit.dart';
import 'package:chat_app/pages/my_home_page.dart';
import 'package:chat_app/pages/register_screen.dart';
import 'package:chat_app/theme/app_text_theme.dart';
import 'package:chat_app/widget/dialog_widget.dart';
import 'package:chat_app/widget/filled_buttom_edit.dart';
import 'package:chat_app/widget/my_text_form_field.dart';
import 'package:chat_app/widget/validate_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static const String route = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode buttonFocusNode = FocusNode();

  bool isLoading = false;
  bool obscurePassword = true;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            showErrorDialog(context, state.errorMessage);
          }
          if (state is LoginSucsses) {
            showSuccessDialog(context, () {
              Get.off(transition: Transition.rightToLeftWithFade, MyHomePage());
            }, 'تم تسجيل الدخول بنجاح');
          }
        },
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Message me'.tr,
                    style: AppTextStyles.largeTitle22,
                  ),
                ),
                SizedBox(height: 45.h),
                Text('Login'.tr, style: AppTextStyles.largeTitle22),
                SizedBox(height: 8.h),
                Text(
                  'Please login to find what you want..'.tr,
                  style: AppTextStyles.mediumGreyTitle14,
                ),
                SizedBox(height: 45.h),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: emailController,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email),
                        validator: validateEmail,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        labelText: 'password',
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(Icons.password),
                        validator: validatePassword,
                        obscureText: obscurePassword,
                        onSuffixTap: togglePasswordVisibility,
                        suffixIcon: Icon(
                          obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?'.tr,
                            style: AppTextStyles.mediumTitleBlue14,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account?'.tr,
                            style: AppTextStyles.mediumGreyTitle14,
                          ),
                          TextButton(
                            onPressed:
                                () => Get.to(
                                  () => const RegisterScreen(),
                                  transition: Transition.rightToLeftWithFade,
                                ),
                            child: Text(
                              'Register'.tr,
                              style: AppTextStyles.mediumTitleBlue14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff79A3D3),
                              ),
                            );
                          }
                          return FilledButtomEdit(
                            focusNodes: buttonFocusNode,
                            text: 'Login'.tr,
                            color: const Color(0xff79A3D3),
                            size: 16,
                            color1: Colors.white,
                            onClick: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginCubit>().signIn(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
