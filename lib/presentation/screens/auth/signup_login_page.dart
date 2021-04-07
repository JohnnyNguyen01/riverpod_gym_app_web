import 'package:adonis_web_test/presentation/screens/auth/signup_login_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpLoginPage extends StatelessWidget {
  static const routeName = '/signupLoginPage';

  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => SignUpLoginPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _BuildBackground(),
        _BuildSignUpLoginCard(),
      ],
    );
  }
}

class _BuildBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background.jpeg'),
            ),
          ),
        ),
        Container(
          width: _screenSize.width,
          height: _screenSize.height,
          color: Colors.black26,
        )
      ],
    );
  }
}

class _BuildSignUpLoginCard extends StatefulWidget {
  @override
  __BuildSignUpLoginCardState createState() => __BuildSignUpLoginCardState();
}

class __BuildSignUpLoginCardState extends State<_BuildSignUpLoginCard> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordIsObscured = true;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
        elevation: 8,
        child: Container(
          width: 340,
          height: 340,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Adonis  Athletics Coach",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "Portal",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: 'Username',
                        helperText: 'Enter your username here'),
                    validator: _validateUsername,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _passwordIsObscured,
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      labelText: 'Pasword',
                      helperText: 'Enter your password here',
                      suffixIcon: IconButton(
                          icon: _passwordIsObscured
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: handleChangePasswordVisibility),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 30,
                    width: 320,
                    child: ElevatedButton(
                      onPressed: () => _formKey.currentState.validate()
                          ? context
                              .read(signupLoginScreenController)
                              .handleLoginButton(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context)
                          : () {},
                      child: Text("Login"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(onPressed: () {}, child: Text('Sign Up'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validateUsername(String username) {
    if (username.isEmpty) {
      return 'Please entery your username';
    } else
      return null;
  }

  String _validatePassword(String password) {
    if (password.isEmpty) {
      return "Please enter your password";
    }
    if (password.length < 8) {
      return "Please enter your correct password 8 chars";
    } else
      return null;
  }

  void handleChangePasswordVisibility() {
    setState(() {
      _passwordIsObscured = !_passwordIsObscured;
    });
  }
}
