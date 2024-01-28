import 'package:flutter/material.dart';
import 'package:test_brokr/presentation/screens/login_screen.dart';
import '../../models/costumer.dart';

class RegistroExitosoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset('assets/images/congras_color.png'),
              SizedBox(height: 20),
              Text(
                'Congratulations',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Thank you for completing your details now you can access the platform.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Container(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    // Llevar al login
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff6863fa),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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


