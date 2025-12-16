import 'package:flutter/material.dart';

class Fashions extends StatelessWidget {
  const Fashions({super.key});

  @override
  Widget build(BuildContext context) {
    return               Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                 SizedBox(height: 50,),
                    Text(
                      'Fashions',
                      style:  TextStyle(
                    

                        fontFamily: 'GreatVibes',
                        fontSize: 70,
               color: Colors.black.withOpacity(0.70), 
                      letterSpacing: -0.8,

                        height: 0.7, 
                     
// يقرب اللي تحته
                      ),
                    ),
               
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                                        
                        'My Life My Style',
                        style: TextStyle(
                          
                          fontSize: 15,
                          height: 0.7,
                          color: Colors.black.withOpacity(0.80), // أخف
                      
                        ),
                      ),
                    ),
                  ],
                ),
              );

             
  }
}