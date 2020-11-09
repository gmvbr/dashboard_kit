import 'package:flutter/material.dart';
import 'dashboard.dart';

class DashboardLogo extends StatelessWidget {
  final IconData icon;
  final String title;
  final MenuState state;

  const DashboardLogo({
    @required this.icon,
    @required this.title,
    @required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        if (state != MenuState.mini)
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
      ],
    );
  }
}
