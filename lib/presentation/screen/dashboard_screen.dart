import 'package:flutter/material.dart';
import 'package:ums/domain/entity/auth_entity.dart';

class DashboardScreen extends StatefulWidget {
  final AuthEntity userEntity;

  const DashboardScreen({super.key, required this.userEntity});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text('Welcome, ${widget.userEntity.username}!'),
            Text('Your email: ${widget.userEntity.email}'),
            const Spacer(),
          ],
        ),
      )
    );
  }
}
