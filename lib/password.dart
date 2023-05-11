import 'package:flutter/material.dart';

import 'main.dart';

void main() => runApp(password());

class password extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // A widget which will be started on application startup
      home: new_pass_pag(title: 'Flutter Demo Home Page'),
    );
  }
}

String new_password = "", temp = "";

class new_pass_pag extends StatelessWidget {
  final String title;
  const new_pass_pag({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/password.png"),
                    fit: BoxFit.fill)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 380.0,
              ),
              Container(
                  width: 350.0,
                  height: 40.0,
                  padding: EdgeInsets.fromLTRB(35.0, 0, 10.0, 0),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (pass) {
                      new_password = pass;
                      print(new_password);
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "New Password",
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0)),
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                    cursorColor: Colors.black,
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                  width: 280.0,
                  child: MaterialButton(
                    onPressed: () {},
                    child:
                        Text(temp, style: TextStyle(color: Colors.redAccent)),
                  )),
              SizedBox(
                height: 45.0,
              ),
              Container(
                  width: 430.0,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 108.0,
                        ),
                        Container(
                            width: 150.0,
                            child: MaterialButton(
                              onPressed: () {
                                if (new_password != "") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                  );
                                } else {
                                  temp = "Please Enter the Password !";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => password()),
                                  );
                                }
                              },
                              color: Color.fromRGBO(137, 121, 113, 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text("SAVE",
                                  style: TextStyle(color: Colors.white)),
                            )),
                      ])),
            ])));
  }
}
