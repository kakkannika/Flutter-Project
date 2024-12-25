import 'package:e_learning_app/G_DOPI/screen/Dashboard/home_tap.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[300]!,Colors.blue[900]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    
                ),
            ),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 10,
                                        offset:const Offset(0, 5),
                                    ),
                                ],
                            ),
                            padding:const  EdgeInsets.all(20),
                            child: Image.asset(
                                'assets/images/logo.png',
                                height: 100,
                                width: 100,

                            ),
                        ),
                       const SizedBox(height: 20),
                      const  Text(
                        "G-DOPI",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                        ),
                       ),
                      const SizedBox(height: 10),
                     const  Text(
                        "Welcom to G-DOPI",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                        ),
                      ),
                     const SizedBox(height: 10),
                     Padding(
                        padding:const  EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                            "Join G_DOPI to help you achieve your goals and become an oustanding student.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                            ),
                        ),

                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                            onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                ),
                            ),
                            
                             child: Text(
                                "GET START",
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                ),
                        ))
                    ],
                ),
            ),
        ),
    );
  }
}