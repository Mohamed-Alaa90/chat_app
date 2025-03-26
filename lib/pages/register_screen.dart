import 'package:chat_app/cubit/auth_cubit/register/register_cubit.dart';
import 'package:chat_app/pages/login_screen.dart';
import 'package:chat_app/pages/my_home_page.dart';
import 'package:chat_app/theme/app_text_theme.dart';
import 'package:chat_app/widget/dialog_widget.dart';
import 'package:chat_app/widget/filled_buttom_edit.dart';
import 'package:chat_app/widget/my_text_form_field.dart';
import 'package:chat_app/widget/validate_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = 'RegisterScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
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
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            showErrorDialog(context, state.errorMessage);
          } else if (state is RegisterSuccess) {
            showSuccessDialog(context, () {}, 'تم انشاء الحساب بنجاح');
          }
          Get.offAll(transition: Transition.fade, MyHomePage());
        },
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: Text('Message me', style: AppTextStyles.largeTitle22),
                ),
                SizedBox(height: 45.h),
                Text('Register'.tr, style: AppTextStyles.largeTitle22),
                SizedBox(height: 8.h),
                const Text(
                  'Create an account to continue.',
                  style: AppTextStyles.mediumGreyTitle14,
                ),
                SizedBox(height: 45.h),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: nameController,
                        labelText: 'Name',
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(Icons.person),

                        validator: validateName,
                      ),
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
                      SizedBox(height: 30.h),
                      BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          if (state is RegisterLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff79A3D3),
                              ),
                            );
                          }
                          return FilledButtomEdit(
                            focusNodes: buttonFocusNode,
                            text: 'Register'.tr,
                            color: const Color(0xff79A3D3),
                            size: 16,
                            color1: Colors.white,
                            onClick: () {
                              if (formKey.currentState!.validate()) {
                                context.read<RegisterCubit>().signUp(
                                  emailController.text,
                                  passwordController.text,
                                  nameController.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: AppTextStyles.mediumGreyTitle14,
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Login',
                        style: AppTextStyles.mediumTitleBlue14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
