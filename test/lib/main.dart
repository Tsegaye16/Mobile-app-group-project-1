import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserRegistration(),
    );
  }
}

class PasswordVisibility extends StatefulWidget {
  final TextEditingController passwordController;

  PasswordVisibility({required this.passwordController});

  @override
  _PasswordVisibilityState createState() => _PasswordVisibilityState();
}

class _PasswordVisibilityState extends State<PasswordVisibility> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          child: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      obscureText: !_isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
    );
  }
}

class UserRegistration extends StatefulWidget {
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();

  void createUser() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, retrieve and use the entered values
      String firstName = firstNameController.text;
      String lastName = lastNameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      String retypePassword = retypePasswordController.text;

      // Perform further actions here
      print('Creating user...');
      print('First Name: $firstName');
      print('Last Name: $lastName');
      print('Email: $email');
      print('Password: $password');
      print('Retype Password: $retypePassword');

      // Clear the form fields
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      passwordController.clear();
      retypePasswordController.clear();

      // Navigate to the confirmation screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            retypePassword: retypePassword,
          ),
        ),
      ).then((value) {
        // Handle any callbacks or actions after returning from the confirmation screen
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Email validation
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.0),
                PasswordVisibility(
                  passwordController: passwordController,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  controller: retypePasswordController,
                  decoration: InputDecoration(labelText: 'Retype Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please retype your password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: createUser,
                  child: Text('Create User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// this is additional functionals other than expectation
class ConfirmationScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String retypePassword;

  ConfirmationScreen({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.retypePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: Center(
        child: Column(
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('Field')),
                DataColumn(label: Text('Value')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('First Name')),
                  DataCell(Text(firstName)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Last Name')),
                  DataCell(Text(lastName)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Email')),
                  DataCell(Text(email)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Password')),
                  DataCell(Text(password)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Retype Password')),
                  DataCell(Text(retypePassword)),
                ]),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      SnackBar(
                        content: Text(
                          'User is created successfully',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    )
                    .closed
                    .then((reason) {
                  if (reason == SnackBarClosedReason.timeout) {
                    Navigator.pop(context);
                  }
                });
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
