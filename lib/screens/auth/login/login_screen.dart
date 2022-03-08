import 'package:farmer_digital/constants.dart';
import 'package:farmer_digital/screens/auth/authentication_bloc.dart';
import 'package:farmer_digital/screens/auth/confirmSignUp/confirm_sign_up_screen.dart';
import 'package:farmer_digital/screens/auth/login/login_bloc.dart';
import 'package:farmer_digital/screens/auth/resetPassword/reset_password_screen.dart';
import 'package:farmer_digital/screens/dashboard/dashboard_screen.dart';
import 'package:farmer_digital/screens/home/home_screen.dart';
import 'package:farmer_digital/services/helpers.dart';
import 'package:farmer_digital/widgets/loader/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            elevation: 0.0,
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  context.read<LoadingCubit>().hideLoading();
                  if (state.authState == AuthState.authenticated) {
                    pushAndRemoveUntil(context, DashboardScreen(), false);
                  } else if (state.authState == AuthState.noConfirmed) {
                    push(
                        context,
                        ConfirmSignUpScreen(
                          email: state.email!,
                          password: state.password,
                        ));
                  } else {
                    showSnackBar(context,
                        state.message ?? 'Couldn\'t login. Please try again.');
                  }
                },
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is ValidLoginFields) {
                    context.read<LoadingCubit>().showLoading(
                          context,
                          'Logging in, Please wait..',
                          false,
                        );
                    context.read<AuthenticationBloc>().add(
                          LoginWithEmailAndPasswordEvent(
                            email: email!,
                            password: password!,
                          ),
                        );
                  }
                },
              ),
            ],
            child: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) =>
                  current is LoginFailureState && previous != current,
              builder: (context, state) {
                if (state is LoginFailureState) {
                  _validate = AutovalidateMode.onUserInteraction;
                }
                return Form(
                  key: _key,
                  autovalidateMode: _validate,
                  child: ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 32.0,
                          right: 16.0,
                          left: 16.0,
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(colorPrimary),
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 32.0,
                          right: 24.0,
                          left: 24.0,
                        ),
                        child: TextFormField(
                          initialValue: 'milinko.m.dragovic+32@gmail.com',
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.next,
                          validator: validateEmail,
                          onSaved: (String? val) {
                            email = val;
                          },
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: const Color(colorPrimary),
                          decoration: getInputDecoration(
                            hint: 'Email Address',
                            errorColor: Theme.of(context).errorColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, right: 24.0, left: 24.0),
                        child: TextFormField(
                          initialValue: 'Adriano1704',
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: true,
                          validator: validatePassword,
                          onSaved: (String? val) {
                            password = val;
                          },
                          onFieldSubmitted: (password) => context
                              .read<LoginBloc>()
                              .add(ValidateLoginFieldsEvent(_key)),
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                          cursorColor: const Color(colorPrimary),
                          decoration: getInputDecoration(
                              hint: 'Password',
                              errorColor: Theme.of(context).errorColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                          right: 24.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () =>
                                push(context, const ResetPasswordScreen()),
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 40.0, left: 40.0, top: 40),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: const BorderSide(
                                color: Color(colorPrimary),
                              ),
                            ),
                            primary: const Color(colorPrimary),
                          ),
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => context
                              .read<LoginBloc>()
                              .add(ValidateLoginFieldsEvent(_key)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
