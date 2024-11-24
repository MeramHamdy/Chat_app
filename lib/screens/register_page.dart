import 'package:chat_app/%20widgets/custom_button.dart';
import 'package:chat_app/colors.dart';
import 'package:chat_app/helper/show_snak_bar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../ widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  //static is specific of class not obj
  static String id = 'registerPage';

  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool isLoading = false;

  //GlobalKey() -->constructor
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 140,
                ),
                Center(
                  child: Text(
                    "Scholar Chat",
                    style: TextStyle(fontSize: 32, color: primary2),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                Row(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(fontSize: 22, color: primary2),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  hintText: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  obscureText: true,
                  hintText: 'Passsword',
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoading = true;
                      //update ui to appear loading
                      setState(() {});
                      try {
                        // var auth = FirebaseAuth.instance;
                        //! not null
                        await registerUser();
                        showSnackBar(context, 'success');
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'weak password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'email already exists');
                        }
                      } catch (e) {
                        showSnackBar(context, 'there was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  txt: "Register",
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already have an account",
                      style: TextStyle(color: primary2),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "  Login",
                          style: TextStyle(color: logo),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
