import 'package:brain_rivals/blocs/auth_bloc/auth_bloc.dart';
import 'package:brain_rivals/components/page_title_bar.dart';
import 'package:brain_rivals/components/under_part.dart';
import 'package:brain_rivals/components/upside.dart';
import 'package:brain_rivals/constant.dart';
import 'package:brain_rivals/screens/mobile_layout.dart';
import 'package:brain_rivals/screens/signup_screen.dart';

import 'package:brain_rivals/widgets/rounded_button.dart';

import 'package:brain_rivals/widgets/rounded_input_field.dart';
import 'package:brain_rivals/widgets/rounded_password_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _errorMsg;
  bool signInRequired = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
             if(state is SignInSuccsess) {
					setState(() {
					  signInRequired = false;
					});
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MobileLayout(),));
				} else if(state is SignInProcess) {
					setState(() {
					  signInRequired = true;
					});
				} else if(state is SignInFailure) {
					setState(() {
					  signInRequired = false;
						_errorMsg = 'Invalid email or password';
					});
				}
          },
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  const Upside(
                    imgUrl: "assets/images/login.png",
                  ),
                  const PageTitleBar(title: 'Login to your account'),
                  Padding(
                    padding: const EdgeInsets.only(top: 320.0),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          /*                         const Row(
                                  children: [Text("Welcome to brain rivals")],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "or use your email account",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'OpenSans',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ), */
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                RoundedInputField(controller: emailController, hintText: "Email", icon: Icons.email),
                                RoundedPasswordField(
                                  controller: passwordController,
                                ),
                                switchListTile(),
                                RoundedButton(
                                    text: 'LOGIN',
                                    press: () async {
                                      
                                  context
                                      .read<AuthBloc>()
                                      .add(SignInRequired(emailController.text, passwordController.text));
                                
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                UnderPart(
                                  title: "Don't have an account?",
                                  navigatorText: "Register here",
                                  onTap: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 200,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

switchListTile() {
  return Padding(
    padding: const EdgeInsets.only(left: 50, right: 40),
    child: SwitchListTile(
      dense: true,
      title: const Text(
        'Remember Me',
        style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
      ),
      value: true,
      activeColor: kPrimaryColor,
      onChanged: (val) {},
    ),
  );
}
