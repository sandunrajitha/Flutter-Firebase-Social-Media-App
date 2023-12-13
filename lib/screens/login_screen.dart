import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttergram/resources/auth_methods.dart';
import 'package:fluttergram/utils/colors.dart';
import 'package:fluttergram/utils/utils.dart';
import 'package:fluttergram/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void signinUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signinUser(
        email: _emailController.text, password: _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(context, res);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              // logo image
              SvgPicture.asset('assets/logo.svg',
                  colorFilter:
                      const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                  height: 64),
              const SizedBox(height: 64),
              // email address text field
              TextInputField(
                  textEditingController: _emailController,
                  hintText: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 24,
              ),
              // password text field
              TextInputField(
                textEditingController: _passwordController,
                hintText: 'Enter Your Password',
                textInputType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(
                height: 24,
              ),
              // login button
              InkWell(
                onTap: signinUser,
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        color: blueColor),
                    child: _isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: primaryColor))
                        : const Text('Sign in')),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),

              // Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text('Don\'t have an account?'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
