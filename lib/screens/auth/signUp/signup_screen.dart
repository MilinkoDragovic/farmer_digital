import 'package:farmer_digital/constants.dart';
import 'package:farmer_digital/screens/auth/authentication_bloc.dart';
import 'package:farmer_digital/screens/auth/signUp/sign_up_bloc.dart';
import 'package:farmer_digital/screens/auth/welcome/welcome_screen.dart';
import 'package:farmer_digital/screens/home/home_screen.dart';
import 'package:farmer_digital/services/helpers.dart';
import 'package:farmer_digital/widgets/loader/loading_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String? firstName,
      lastName,
      emailAddress,
      mobileNumber,
      password,
      confirmPassword;
  AutovalidateMode _validate = AutovalidateMode.disabled;
  final GlobalKey<FormState> _key = GlobalKey();
  bool acceptTOU = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                context.read<LoadingCubit>().hideLoading();
                if (state.authState == AuthState.authenticated) {
                  pushAndRemoveUntil(
                    context,
                    HomeScreen(
                      user: state.user!,
                    ),
                    false,
                  );
                } else {
                  showSnackBar(context,
                      state.message ?? 'Could\'t sign up. Please try again.');
                }
              },
            ),
            BlocListener<SignUpBloc, SignUpState>(listener: (context, state) {
              if (state is ValidFields) {
                context.read<LoadingCubit>().showLoading(
                      context,
                      'Creating new account. Please wait...',
                      false,
                    );
                context.read<AuthenticationBloc>().add(
                      SignupWithEmailAndPasswordEvent(
                        emailAddress: emailAddress!,
                        password: password!,
                        mobileNumber: mobileNumber!,
                        firstName: firstName!,
                        lastName: lastName!,
                      ),
                    );
              } else if (state is SignUpFailureState) {
                showSnackBar(context, state.errorMessage);
              }
            }),
          ],
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  push(context, WelcomeScreen());
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: BlocBuilder<SignUpBloc, SignUpState>(
                buildWhen: (previous, current) =>
                    current is SignUpFailureState && previous != current,
                builder: (context, state) {
                  if (state is SignUpFailureState) {
                    _validate = AutovalidateMode.onUserInteraction;
                  }

                  return Form(
                    key: _key,
                    autovalidateMode: _validate,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Create new Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            right: 8.0,
                            left: 8.0,
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            validator: validateName,
                            onSaved: (String? val) {
                              firstName = val;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: getInputDecoration(
                              hint: 'First Name',
                              errorColor: Theme.of(context).errorColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            right: 8.0,
                            left: 8.0,
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            validator: validateName,
                            onSaved: (String? val) {
                              lastName = val;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: getInputDecoration(
                                hint: 'Last Name',
                                errorColor: Theme.of(context).errorColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            right: 8.0,
                            left: 8.0,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: validateEmail,
                            onSaved: (String? val) {
                              emailAddress = val;
                            },
                            decoration: getInputDecoration(
                                hint: 'Email',
                                errorColor: Theme.of(context).errorColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            right: 8.0,
                            left: 8.0,
                          ),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            onSaved: (String? val) {
                              mobileNumber = val;
                            },
                            decoration: getInputDecoration(
                                hint: 'Mobile Number',
                                errorColor: Theme.of(context).errorColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            right: 8.0,
                            left: 8.0,
                          ),
                          child: TextFormField(
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            controller: _passwordController,
                            validator: validatePassword,
                            onSaved: (String? val) {
                              password = val;
                            },
                            style: const TextStyle(height: 0.8, fontSize: 18.0),
                            cursorColor: const Color(colorPrimary),
                            decoration: getInputDecoration(
                                hint: 'Password',
                                errorColor: Theme.of(context).errorColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            right: 8.0,
                            left: 8.0,
                          ),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) =>
                                context.read<SignUpBloc>().add(
                                      ValidateFieldsEvent(
                                        _key,
                                        acceptTermsOfUse: acceptTOU,
                                      ),
                                    ),
                            obscureText: true,
                            validator: (val) => validateConfirmPassword(
                                _passwordController.text, val),
                            onSaved: (String? val) {
                              confirmPassword = val;
                            },
                            style: const TextStyle(height: 0.8, fontSize: 18.0),
                            cursorColor: const Color(colorPrimary),
                            decoration: getInputDecoration(
                              hint: 'Confirm Password',
                              errorColor: Theme.of(context).errorColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ListTile(
                          trailing: BlocBuilder<SignUpBloc, SignUpState>(
                              buildWhen: (previous, current) =>
                                  current is TermsOfUseToggleState &&
                                  previous != current,
                              builder: (context, state) {
                                if (state is TermsOfUseToggleState) {
                                  acceptTOU = state.termsOfUseAccepted;
                                }

                                return Checkbox(
                                  onChanged: (value) =>
                                      context.read<SignUpBloc>().add(
                                            ToggleTermsOfUseCheckboxEvent(
                                              termsOfUseAccepted: value!,
                                            ),
                                          ),
                                  activeColor: const Color(colorPrimary),
                                  value: acceptTOU,
                                );
                              }),
                          title: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text:
                                      'By creating an account you agree to our\n',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                TextSpan(
                                  style:
                                      const TextStyle(color: Colors.blueAccent),
                                  text: 'Terms of Use of the Farmer Digital',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (await canLaunch(TERMS_OF_USE)) {
                                        await launch(
                                          TERMS_OF_USE,
                                          forceSafariVC: false,
                                        );
                                      }
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 40.0, left: 40.0, top: 40.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(colorPrimary),
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: const BorderSide(
                                  color: Color(colorPrimary),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () => context.read<SignUpBloc>().add(
                                  ValidateFieldsEvent(
                                    _key,
                                    acceptTermsOfUse: acceptTOU,
                                  ),
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
