// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void submit(context) {
    if (formKey.currentState!.validate()) {
      LoginCubit.get(context).userLogin(
          email: emailController.text, password: passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(massage: state.error,state:ToastState.ERROR);
          }
          if(state is LoginSuccessState)
            {
              CacheHelper.setData(key: 'uId', value: state.uid);
              pushAndFinish(context, HomeLayout());
            }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        onTap: () {},
                        onChange: (val) {},
                        onSubmit: (val) => submit(context),
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
                        height: 24,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        onTap: () {},
                        onChange: (val) {},
                        onSubmit: (val) => submit(context),
                        isPassword: LoginCubit.get(context).passState,
                        validate: (String value) {
                          if (value.isEmpty || value == '') {
                            return 'Password Should not be empty.';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.password,
                        suffixPressed: () =>
                            LoginCubit.get(context).changePasswordState(),
                        suffix: LoginCubit.get(context).passIcon,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      state is LoginLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : defaultButton(
                              function: () => submit(context),
                              text: 'login',
                              isUpperCase: true,
                            ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('You don\'t have an account ?'),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: const Text('Register Now')),
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
