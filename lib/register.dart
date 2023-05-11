import 'package:dermatology1/login_screen.dart';
import 'package:dermatology1/services/auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'layout/profile/profile.dart';

// late String country_id;
// List<String> country = [
//   "America",
//   "Brazil",
//   "Canada",
//   "India",
//   "Mongalia",
//   "USA",
//   "China",
//   "Russia",
//   "Germany"
// ];

late String f_name, l_name, E_Mail, phone, pass, confirm_pass;

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _registerFormKey = GlobalKey<FormState>();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _registerFormKey,
          child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/reg.png"), fit: BoxFit.fill)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 320.0,
                    ),
                    SizedBox(
                        width: 430.0,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 15.0,
                              ),
                              SizedBox(
                                  width: 160.0,
                                  height: 35.0,
                                  child: TextFormField(
                                    controller: fnameController,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      f_name = value;
                                      print("First Name: " + f_name);
                                    },
                                    decoration: InputDecoration(
                                        labelText: "First Name",
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.green,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(25.0)),
                                        fillColor: Colors.black,
                                        prefixIcon: const Icon(Icons.person)),
                                    cursorColor: Colors.black,
                                  )),
                              const SizedBox(
                                width: 10.0,
                              ),
                              SizedBox(
                                  width: 160.0,
                                  height: 35.0,
                                  child: TextFormField(
                                    controller: lnameController,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      l_name = value;
                                      print("Last Name: " + l_name);
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Last Name",
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 118, 122, 118),
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(25.0)),
                                        fillColor: Colors.black,
                                        prefixIcon: const Icon(Icons.person)),
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
                                width: 15.0,
                              ),
                              SizedBox(
                                  width: 330.0,
                                  height: 35.0,
                                  child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      E_Mail = value;
                                      print("E Mail" + E_Mail);
                                    },
                                    decoration: InputDecoration(
                                        labelText: "E-Mail",
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.green,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(25.0)),
                                        fillColor: Colors.black,
                                        prefixIcon: const Icon(Icons.mail)),
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
                                width: 15.0,
                              ),
                              SizedBox(
                                  width: 330.0,
                                  height: 35.0,
                                  child: TextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      phone = value;
                                      print("phone: " + phone);
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Phone",
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.green,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(25.0)),
                                        fillColor: Colors.black,
                                        prefixIcon: const Icon(Icons.phone)),
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
                                width: 15.0,
                              ),
                              SizedBox(
                                  width: 330.0,
                                  height: 35.0,
                                  child: TextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    onChanged: (value) {
                                      pass = value;
                                      print("Password: " + pass);
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
                                      suffixIcon:
                                          const Icon(Icons.remove_red_eye),
                                    ),
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
                                width: 15.0,
                              ),
                              SizedBox(
                                  width: 330.0,
                                  height: 35.0,
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    onChanged: (value) {
                                      confirm_pass = value;
                                      print(
                                          "Confirm Password: " + confirm_pass);
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: "Confirm Password",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.green, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0)),
                                      fillColor: Colors.white,
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon:
                                          const Icon(Icons.remove_red_eye),
                                    ),
                                    cursorColor: Colors.black,
                                  )),
                            ])),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const SizedBox(
                      height: 15.0,
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
                                  height: 35.0,
                                  child: MaterialButton(
                                    onPressed: ()=> _handleRegisterUser(context),
                                    color:
                                        const Color.fromRGBO(137, 121, 113, 5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Text("CREATE AN ACCOUNT",
                                        style: TextStyle(color: Colors.white)),
                                  ))
                            ])),
                  ])),
        ));
        
  }
Future<void> _handleRegisterUser(context) async {
    if (_registerFormKey.currentState!.validate()) {
      final _auth = AuthServices();
      _auth.createUser(
        context: context,
        email: emailController.text.toString().trim(),
        password: passwordController.text.toString().trim(),
        fname: fnameController.text.toString().trim(),
        lname: lnameController.text.toString().trim(),
        phone: phoneController.text.toString().trim(),
      );
    }
  }
  
}
