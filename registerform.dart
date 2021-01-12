import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'textfield_import.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(RegisterForm());
}

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'My Beauty',
      home: MyHomePage(),
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool boolColorSelected = false;
  bool boolShopOk = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collClients =
      FirebaseFirestore.instance.collection('clients');
  CollectionReference collShops =
      FirebaseFirestore.instance.collection('shops');
  Color _selectedColorA;
  Color _selectedColorB;
  Color _selectedColorCbA;
  Color _selectedColorCbB;
  String _selectedValueA;
  String _selectedValueB;
  String _username, _email, _password = "";

  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerPasswordOk = TextEditingController();
  final _controllerScroll = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final _height = 100.0;

  //_MyHomePageState() {}

  @override
  Widget build(BuildContext context) {
    updateValues();
    animateToIndex(i) => _controllerScroll.animateTo(_height * i,
        duration: Duration(microseconds: 800), curve: Curves.fastOutSlowIn);

    Widget buttonAddData() {
      return CupertinoButton.filled(
          child: Text(
            'CADASTRE-ME',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          //  Action event
          onPressed: () {
            //  Highlight CupertinoPage if shop not selected
            if (_selectedValueA != 'a' && _selectedValueB != 'b') {
              setState(() {
                boolColorSelected = true;
              });
              // Scroll to top if shop not selected and show Toast Message
              animateToIndex(0);
              toastMessage('Voce precisa escolher\no tipo da sua conta ... ');
            } else {
              setState(() {
                boolColorSelected = false;
                boolShopOk = true;
              });
            }
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              if (boolShopOk == true) {
                if (_selectedValueA == 'a') {
                  updateShops(_email, _username, _password);
                }
                if (_selectedValueB == 'b') {
                  updateClient(_email, _username, _password);
                }

                setState(() {
                  _controllerEmail.clear();
                  _controllerName.clear();
                  _controllerPassword.clear();
                  _controllerPasswordOk.clear();
                });
              }
            }
          }
          // },
          );
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _controllerScroll,
          children: [
            SizedBox(height: 5),
            // Title text
            Container(
                alignment: Alignment.center,
                child: Text('Crie sua conta',
                    style: TextStyle(
                        fontFamily: 'LovelyCoffee',
                        fontSize: 40,
                        //fontWeight: FontWeight.bold,
                        color: Colors.black)),
                margin: const EdgeInsets.all(15)),
            SizedBox(height: 5),
            // Segmented Control
            Container(
              margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: boolColorSelected ? Colors.red : Colors.orange,
                    width: 2.5,
                  )),
              child: CupertinoSegmentedControl(
                borderColor: Colors.transparent,
                unselectedColor: Colors.transparent,
                children: {
                  'a': Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(color: _selectedColorA),
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          child: FittedBox(
                            child: Image.asset(
                              'images/owner.png',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Tenho um negócio',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _selectedColorCbA,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              width: 32,
                              height: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  'b': Container(
                    decoration: BoxDecoration(color: _selectedColorB),
                    margin: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                    padding: EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          width: 130,
                          child: FittedBox(
                            child: Image.asset(
                              'images/client.png',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Sou cliente',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _selectedColorCbB,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              width: 32,
                              height: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    _selectedValueA = value;
                    _selectedValueB = value;
                  });
                },
              ),
            ),
            SizedBox(height: 15),
            // Name
            Container(
              child: AppTextField(
                controller: _controllerName,
                helpText: '4 letras ou mais',
                labelText: 'Nome completo',
                prefixIcon: Icons.person,
                textCapitalization: TextCapitalization.words,
                hintText: 'p.ex. John Doe / Ninja Cabelos',
                textInputType: TextInputType.text,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Campo não pode estar vaxio';
                  } else if (text.length < 4) {
                    return 'Preencher com, \nmínimo, 4 caracteres';
                  }
                  return null;
                },
                onSaved: (name) => _username = name,
              ),
            ),
            // Email
            Container(
              child: Material(
                child: AppTextField(
                  controller: _controllerEmail,
                  hintText: 'e.g abc@gmail.com',
                  helpText: 'Seu e-mail de contato',
                  textInputType: TextInputType.emailAddress,
                  labelText: 'E-Mail',
                  prefixIcon: Icons.person,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  validator: (email) => EmailValidator.validate(email)
                      ? null
                      : "Endereço de e-mail inválido",
                  onSaved: (email) => _email = email,
                ),
              ),
            ),
            // Password
            Container(
              child: AppTextField(
                controller: _controllerPassword,
                helpText: 'Letras, números e maiúsculos, min. 6 caract.',
                hintText: 'p.ex. Joao22',
                labelText: 'Senha',
                isPassword: true,
                prefixIcon: Icons.security,
                textCapitalization: TextCapitalization.none,
                textInputType: TextInputType.text,
                validator: (name) {
                  Pattern pattern =
                      r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)(?=.*[A-Z])[0-9a-zA-Z]{6,}$';
                  //at least one letter, at least one number, one uppercase, longer than six charaters
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(name)) {
                    return 'Senha inválida';
                  } else
                    return null;
                },
              ),
            ),
            // Confrm  password
            Container(
              child: AppTextField(
                controller: _controllerPasswordOk,
                helpText: 'Repita a senha',
                labelText: 'Senha',
                isPassword: true,
                textCapitalization: TextCapitalization.none,
                prefixIcon: Icons.security,
                validator: (text) {
                  if (text.isEmpty) {
                    return 'Preencha este campo';
                  } else if (_controllerPassword.text !=
                      _controllerPasswordOk.text) {
                    return 'Senhas não conferem';
                  }
                  return null;
                },
                onSaved: (password) => _password = password,
              ),
            ),
            //  Submit buttton
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buttonAddData(),
                ],
              ),
              padding: EdgeInsets.fromLTRB(25, 15, 40, 100),
            ),
          ],
        ),
        //  ),
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.blue,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        fontSize: 16.0);
  }

  void updateValues() {
    _selectedValueA == 'a'
        ? _selectedColorA = Colors.lightBlue
        : _selectedColorA = Colors.blue[50];

    _selectedValueB == 'b'
        ? _selectedColorB = Colors.lightBlue
        : _selectedColorB = Colors.blue[50];

    _selectedValueA == 'a'
        ? _selectedColorCbA = Colors.green
        : _selectedColorCbA = Colors.blue[50];

    _selectedValueB == 'b'
        ? _selectedColorCbB = Colors.green
        : _selectedColorCbB = Colors.blue[50];
  }

  Future<void> updateClient(String email, String username, String password) {
    return collClients
        .doc(_controllerName.text)
        .set({'email': _email, 'name': _username, 'password': _password})
        .then((value) => toastMessage(
            "Cliente adcionado:\nUsername: $_username\nEmail: $_email\nPassword: $_password"))
        .catchError((error) => print("Failed to update client: $error"));
  }

  Future<void> updateShops(String email, String username, String password) {
    return collShops
        .doc(_controllerName.text)
        .set({'email': _email, 'name': _username, 'password': _password})
        .then((value) => toastMessage(
            "Negócio adicionado:\nUsername: $_username\nEmail: $_email\nPassword: $_password"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
