import 'package:brain_rivals/blocs/auth_bloc/auth_bloc.dart';
import 'package:brain_rivals/components/page_title_bar.dart';
import 'package:brain_rivals/components/under_part.dart';
import 'package:brain_rivals/components/upside.dart';
import 'package:brain_rivals/screens/login_screen.dart';
import 'package:brain_rivals/screens/mobile_layout.dart';

import 'package:brain_rivals/widgets/rounded_button.dart';
import 'package:brain_rivals/widgets/rounded_input_field.dart';
import 'package:brain_rivals/widgets/rounded_password_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signUpRequired = false;

  @override
  void dispose() {
    // Bellek sızıntısını önlemek için controller'ları dispose edin
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
            if(state is SignUpSuccsess) {
					setState(() {
					  signUpRequired = false;

					});
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MobileLayout(),));
				} else if(state is SignUpProcess) {
					setState(() {
					  signUpRequired = true;
					});
				} else if(state is SignUpFailure) {
					return;
				} 
          },
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  const Upside(
                    imgUrl: "assets/images/register.png",
                  ),
                  const Column(
                    children: [
                      PageTitleBar(title: 'Create New Account'),
                    ],
                  ),
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
                          /*  const Row(
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
                                RoundedInputField(controller: nameController, hintText: "Name", icon: Icons.person),
                                RoundedPasswordField(
                                  controller: passwordController,
                                ),
                                RoundedButton(
                                    text: 'REGISTER',
                                    press: () async {
                                     MyUser myUser = MyUser.empty;
                                      myUser = myUser.copyWith(
                                      email: emailController.text,
                                      name: nameController.text,
                                    );
                                      setState(() {
                                      context.read<AuthBloc>().add(SignUpRequired(myUser, passwordController.text));
                                    });

                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                UnderPart(
                                  title: "Already have an account?",
                                  navigatorText: "Login here",
                                  onTap: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                                  },
                                ),
                                const SizedBox(
                                  height: 200,
                                ),
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
