import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dermatology1/layout/profile/profile.dart';
import 'package:dermatology1/model/user.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../utils/progressIndicatorDialog.dart';
import '../../utils/toast.dart';
import '../home_screen.dart';
//import 'package:settings_ui/pages/settings.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.user});
  final UserModel? user;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  CollectionReference notesref = FirebaseFirestore.instance.collection("Users");

  @override
  void initState() {
    nameController.text = widget.user?.fname ?? '';
    phoneController.text = widget.user?.phone ?? '';
    locationController.text = widget.user?.location ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset("assets/back.png").image,
              fit: BoxFit.fill,
            ),
          ),
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                const SizedBox(
                  height: 55,
                ),

                const SizedBox(
                  height: 100,
                ),
                buildTextField("Full Name", "", controller: nameController),
                buildTextField("E-mail", "", controller: phoneController),
                // buildTextField("Password", "", true),
                buildTextField("Location", "", controller: locationController),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          updateShop(context,
                              name: nameController.text,
                              phone: phoneController.text,
                              location: locationController.text,
                              docId: widget.user!.id);
                        }
                      },
                      color: const Color.fromRGBO(137, 121, 113, 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text("save",
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateShop(
    BuildContext context, {
    required String name,
    required String phone,
    required String location,
    required docId,
  }) async {
    final _auth = AuthServices();
    DocumentReference docRef = notesref.doc(docId);

    ProgressIndicatorDialog().show(context);
    await docRef.update(
        {"fname": name, "phone": phone, "location": location}).then((value) {
      // Navigator.of(context).pushNamed("homepage");
      showToast(message: 'Updated', state: ToastStates.success);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }).catchError((e) {
      print("$e");
    });
  }

Widget buildTextField(String labelText, String placeholder,
    {bool isPasswordTextField = false, controller}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextField(
      controller: controller,
      obscureText: isPasswordTextField ? showPassword : false,
      decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    ),
  );
}

}

