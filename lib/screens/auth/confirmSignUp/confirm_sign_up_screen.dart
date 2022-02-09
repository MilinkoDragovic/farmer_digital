import 'package:farmer_digital/constants.dart';
import 'package:farmer_digital/screens/auth/authentication_bloc.dart';
import 'package:farmer_digital/screens/auth/confirmSignUp/confirm_sign_up_bloc.dart';
import 'package:farmer_digital/screens/auth/login/login_bloc.dart';
import 'package:farmer_digital/screens/home/home_screen.dart';
import 'package:farmer_digital/services/helpers.dart';
import 'package:farmer_digital/widgets/loader/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmSignUpScreen extends StatefulWidget {
  final String? email;
  final String? password;
  const ConfirmSignUpScreen(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State createState() {
    return _ConfirmSignUpScreen();
  }
}

class _ConfirmSignUpScreen extends State<ConfirmSignUpScreen> {
  late String? email, password;
  final GlobalKey<FormState> _key = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String? code;

  @override
  void initState() {
    super.initState();
    email = widget.email;
    password = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfirmSignUpBloc>(
      create: (context) => ConfirmSignUpBloc(),
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
                    pushAndRemoveUntil(
                        context, HomeScreen(user: state.user!), false);
                  } else if (state.authState == AuthState.confirmed) {
                    context.read<AuthenticationBloc>().add(
                          LoginWithEmailAndPasswordEvent(
                            email: email!,
                            password: password!,
                          ),
                        );
                  } else {
                    showSnackBar(
                        context,
                        state.message ??
                            'Couldn\'t verify code. Please try again.');
                  }
                },
              ),
              BlocListener<ConfirmSignUpBloc, ConfirmSignUpState>(
                listener: (context, state) {
                  if (state is ValidConfirmSignUpField) {
                    context.read<LoadingCubit>().showLoading(
                          context,
                          'Verifing code, Please wait..',
                          false,
                        );

                    context.read<AuthenticationBloc>().add(
                          ConfirmSignUpCodeEvent(
                            email: email!,
                            code: code!,
                          ),
                        );
                  }
                },
              ),
            ],
            child: BlocBuilder<ConfirmSignUpBloc, ConfirmSignUpState>(
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
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 32.0,
                          right: 16.0,
                          left: 16.0,
                        ),
                        child: Text(
                          'Verify account: $email',
                          style: const TextStyle(
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
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.next,
                          validator: validateConfirmationCode,
                          onSaved: (String? val) {
                            code = val;
                          },
                          onFieldSubmitted: (code) => context
                              .read<ConfirmSignUpBloc>()
                              .add(ValidateConfirmSignUpFieldsEvent(_key)),
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                          keyboardType: TextInputType.number,
                          cursorColor: const Color(colorPrimary),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            fillColor: Colors.white,
                            hintText: 'Verification code',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                    color: Color(colorPrimary), width: 2.0)),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).errorColor),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).errorColor),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => context
                                  .read<ConfirmSignUpBloc>()
                                  .add(SendConfirmationCodeEvent(
                                      emailAddress: email!)),
                              icon: Icon(Icons.clear),
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
                            'Complete Sign up',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => context
                              .read<ConfirmSignUpBloc>()
                              .add(ValidateConfirmSignUpFieldsEvent(_key)),
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
