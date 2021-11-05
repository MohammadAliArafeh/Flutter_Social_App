import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/register/cubit/cubit.dart';
import 'package:social_app/modules/register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterCreateUserSuccessState){
            pushAndFinish(context, HomeLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.text,
                        onTap: () {},
                        onChange: (val) {},
                        onSubmit: (val) {},
                        validate: (String value) {
                          if (value.isEmpty || value == '') {
                            return 'Your Name Should not be empty.';
                          }
                          return null;
                        },
                        label: 'Full-Name',
                        prefix: Icons.supervised_user_circle,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        onTap: () {},
                        onChange: (val) {},
                        onSubmit: (val) {},
                        validate: (String value) {
                          if (value.isEmpty || value == '') {
                            return 'Your Phone Number Should not be empty.';
                          }
                          return null;
                        },
                        label: 'Phone Number',
                        prefix: Icons.phone_android_outlined,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        onTap: () {},
                        onChange: (val) {},
                        onSubmit: (val) {},
                        validate: (String value) {
                          if (value.isEmpty || value == '') {
                            return 'E-Mail Should not be empty.';
                          }
                          return null;
                        },
                        label: 'E-Mail',
                        prefix: Icons.email,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        onTap: () {},
                        onChange: (val) {},
                        onSubmit: (val) {},
                        isPassword: RegisterCubit.get(context).passState,
                        validate: (String value) {
                          if (value.isEmpty || value == '') {
                            return 'Password Should not be empty.';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.password,
                        suffixPressed: RegisterCubit.get(context).changePasswordState,
                        suffix: RegisterCubit.get(context).passIcon,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      defaultFormField(
                        controller: confirmPasswordController,
                        type: TextInputType.visiblePassword,
                        onTap: () {},
                        onChange: (val) {},
                        onSubmit: (val) {},
                        isPassword: RegisterCubit.get(context).passState,
                        validate: (String value) {
                          if (value.isEmpty || value == '') {
                            return 'Password Should not be empty.';
                          } else if (value.toString() !=
                              passwordController.text) {
                            return 'Password not confirmed';
                          }
                          return null;
                        },
                        label: 'Confirm Password',
                        prefix: Icons.password,
                        suffixPressed: RegisterCubit.get(context).changePasswordState,
                        suffix: RegisterCubit.get(context).passIcon,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      state is RegisterCreateUserSuccessState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              },
                              text: 'register',
                              isUpperCase: true,
                            ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('I already have an account...'),
                          TextButton(
                              onPressed: () {
                                pushAndFinish(context, LoginScreen());
                              },
                              child: const Text('Login')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
