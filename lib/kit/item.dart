import 'package:flutter/material.dart';
import 'dashboard.dart';

class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final MenuState state;
  final Function() onTap;
  final Color activeColor;
  final bool active;

  const DashboardItem({
    this.active = false,
    this.activeColor = Colors.blue,
    @required this.onTap,
    @required this.icon,
    @required this.title,
    @required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 57,
            child: Icon(
              icon,
              color: active ? activeColor : null,
            ),
          ),
          if (state != MenuState.mini)
            Expanded(
              child: Container(
                height: 57,
                padding: EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: active ? activeColor : null,
                    fontSize: 16,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
