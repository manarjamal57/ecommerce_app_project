import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
    
        SizedBox(
          width: 42,
          height: 42,
          child: ClipOval(
            child: Image.network(
              'https://i.pravatar.cc/150?img=3',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}