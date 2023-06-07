import 'package:flutter/material.dart';

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
                //####################
                //Please implement on pressed button
                //#################################

              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
