import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:login/pages/download_page/download_page.dart';
import 'package:login/pages/lead_page/lead_button_page.dart';
import 'package:login/pages/lead_page/lead_page.dart';

import 'package:provider/provider.dart';
import 'package:login/pages/pages.dart';

import 'package:login/services/sevices.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  void onsubmit(String name) {}
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailvalitator = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  late Future _futureAlbum;

  String _name = '';
  String _pass = '';

  bool hidepassword = true;

  Future<void> _submit() async {
    // validate all the form field
    if (formkey.currentState!.validate()) {
      // on success

      widget.onsubmit(_name);

      _emailvalitator.clear();
      _password.clear();

      setState(() {
        _futureAlbum = createAlbum(
            Provider.of<Id>(context, listen: false).id, _name, _pass);
      });
      var result = await _futureAlbum;

      print(result[0]);
      print(result[1]);

      Provider.of<Id>(context, listen: false).transferId1(result[0]);
      Provider.of<Id>(context, listen: false).transferId2(result[1]);
      if (result[0] != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => LeadButton()));

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text("Login Successfully "),
          ));
      } else {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text("Un Successful"),
          ));
      }
    }
  }

  @override
  void dispose() {
    _emailvalitator.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 16, 51, 80),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/I1.jpg"), fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 16, 51, 80),
                        radius: 40,
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 16, 51, 80),
                            borderRadius: BorderRadius.circular(30)),
                        height: MediaQuery.of(context).size.height / 2.3,
                        // width: MediaQuery.of(context).size.width / 1.2,
                        child: Form(
                          key: formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Log IN',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(Icons.login)
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailvalitator,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.blueGrey,
                                      border: OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.email)),
                                      hintText: "Registered email"),
                                  autofillHints: [AutofillHints.email],
                                  validator: (email) => email != null &&
                                          !EmailValidator.validate(email)
                                      ? 'enter valid email'
                                      : null,
                                  onChanged: (email) => setState(() {
                                    _name = email;
                                  }),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: _password,
                                  obscureText: hidepassword,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.blueGrey,
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            hidepassword = !hidepassword;
                                          });
                                        },
                                        icon: hidepassword
                                            ? Icon(
                                                Icons.visibility_off,
                                              )
                                            : Icon(
                                                Icons.visibility,
                                              )),
                                  ),
                                  validator: (pass) =>
                                      pass != null && pass.isEmpty
                                          ? 'enter correct password'
                                          : null,
                                  onChanged: (pass) => setState(() {
                                    _pass = pass;
                                  }),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 14,
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    onPressed:
                                        _name.isNotEmpty ? _submit : null,
                                    child: const Text(
                                      'Log-In',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Colors.blueGrey),
                                    ),
                                  )),
                            ],
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
