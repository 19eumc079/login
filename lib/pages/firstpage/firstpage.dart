import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/pages/pages.dart';
import 'package:http/http.dart' as http;
import 'package:login/services/fetch_company_service.dart';
import 'package:login/services/provider.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPage();

  // void onSubmit(String name) {}
}

class _FirstPage extends State<FirstPage> {
  final _formKey = GlobalKey<FormState>();
  final _Textfield = TextEditingController(text: 'jio');

  // declare a variable to keep track of the input text
  // String _name = '';

  void _submit() async {
    // validate all the
    //form field

    if (_formKey.currentState!.validate()) {
      // on success
      // widget.onSubmit(_Textfield.text);
      // var c = _name;

      var result = await fetchAlbum(_Textfield.text);

      if (result != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
        Provider.of<Id>(context, listen: false).transferId(result);

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text("Successfully enter the login page"),
          ));
      } else {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text("Wrong Company Name"),
          ));
      }

      _Textfield.clear();
    }
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
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/I1.jpg"), fit: BoxFit.cover),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: _Textfield,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Can\'t be empty';
                                }
                                if (text.length < 1) {
                                  return 'Too short';
                                }

                                return null;
                              },
                              // update the state variable when the text changes
                              onChanged: (text) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter your company name",
                                  label: Text("Enter your Company name")),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 14,
                            width: MediaQuery.of(context).size.width / 2.8,

                            child: ElevatedButton(
                              onPressed:
                                  _Textfield.text.isNotEmpty ? _submit : null,
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 16, 51, 80),
                              ),
                              child: Text('Enter'),
                            ),

                            // By default, show a loading spinner.
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
