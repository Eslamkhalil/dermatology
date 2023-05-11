import 'package:dermatology1/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'gmail_pag.dart';
import 'password.dart';
//import 'otp.dart';
import 'register.dart';
import 'layout/profile.dart';
import 'start.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  late String username, login_pass;
  String E_mail = "";

  //final String title;
  final _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _loginFormKey,
        child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/log.png"), fit: BoxFit.fill)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 330.0,
                ),
                SizedBox(
                    width: 430.0,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 30.0,
                          ),
                          SizedBox(
                              width: 300.0,
                              height: 40.0,
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  username = value;
                                  print("username: " + username);
                                },
                                decoration: InputDecoration(
                                    labelText: "Username",
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.green, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    fillColor: Colors.black,
                                    prefixIcon: const Icon(Icons.email)),
                                cursorColor: Colors.black,
                              )),
                        ])),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                    width: 430.0,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 30.0,
                          ),
                          SizedBox(
                              width: 300.0,
                              height: 40.0,
                              child: TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                onChanged: (value) {
                                  login_pass = value;
                                  print("Password: " + login_pass);
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: const Icon(Icons.remove_red_eye),
                                ),
                                cursorColor: Colors.black,
                              )),
                        ])),
                Container(
                    padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                    width: 190.0,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => password()),
                        );
                      },
                      child: const Text("Forget Password?",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 12.5)),
                    )),
                const SizedBox(
                  height: 6.5,
                ),
                SizedBox(
                    width: 430.0,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 108.0,
                          ),
                          SizedBox(
                              width: 150.0,
                              child: MaterialButton(
                                onPressed: () => _handleLoginUser(context),
                                color: const Color.fromRGBO(137, 121, 113, 5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text("login",
                                    style: TextStyle(color: Colors.white)),
                              )),
                        ])),
                const SizedBox(
                  height: 180.0,
                ),
                SizedBox(
                    width: 430.0,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 22.0,
                          ),
                          SizedBox(
                              width: 320.0,
                              height: 40.0,
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen()),
                                  );
                                },
                                color: const Color.fromRGBO(137, 121, 113, 5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text("Register",
                                    style: TextStyle(color: Colors.white)),
                              ))
                        ])),
              ],
            )),
      ),
    );
  }

  Future<void> _handleLoginUser(context) async {
    if (_loginFormKey.currentState!.validate()) {
      final _auth = AuthServices();
      _auth.login(
        context,
        emailController.text.toString().trim(),
        passwordController.text.toString().trim(),
      );
    }
  }
}
