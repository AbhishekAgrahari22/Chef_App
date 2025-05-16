import 'package:chef_app/Authentication/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Creatempin extends StatefulWidget {
  const Creatempin({super.key});

  @override
  State<Creatempin> createState() => _CreateMpinState();
}

class _CreateMpinState extends State<Creatempin> {
  String mpin = "";
  String confirmMpin = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        titleSpacing: 0,
        centerTitle: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white),
        ),
        title: Text(
          "Create Mpin",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2E2E2E),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Your MPIN",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Set a 4-digit MPIN to secure your account.",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              const SizedBox(height: 30),

              Text("Enter MPIN", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              PinCodeTextField(
                appContext: context,
                length: 4,
                obscureText: true,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Color(0xFF3E3E3E),
                  selectedFillColor: Color(0xFF3E3E3E),
                  inactiveFillColor: Color(0xFF2E2E2E),
                  inactiveColor: Colors.white30,
                  selectedColor: Colors.white,
                  activeColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                onChanged: (value) {
                  setState(() => mpin = value);
                },
              ),

              const SizedBox(height: 20),
              Text("Confirm MPIN", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              PinCodeTextField(
                appContext: context,
                length: 4,
                obscureText: true,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Color(0xFF3E3E3E),
                  selectedFillColor: Color(0xFF3E3E3E),
                  inactiveFillColor: Color(0xFF2E2E2E),
                  inactiveColor: Colors.white30,
                  selectedColor: Colors.white,
                  activeColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                onChanged: (value) {
                  setState(() => confirmMpin = value);
                },
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (mpin.length == 4 && mpin == confirmMpin) {
                      print("MPIN Set: $mpin");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "MPINs do not match or are incomplete.",
                          ),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
