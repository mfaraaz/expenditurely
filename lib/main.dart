import 'package:expenditurely/model/task_data.dart';
import 'package:expenditurely/screens/dashboard_screen.dart';
import 'package:expenditurely/screens/launcher_screen.dart';
import 'package:expenditurely/screens/login_screen.dart';
import 'package:expenditurely/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => LauncherScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/dashboard': (context) => DashboardScreen(),
        },
      ),
    );
//        home: LauncherScreen());
  }
}
//

//MaterialApp(
//initialRoute: '/',
//routes: {
//'/': (context) => LauncherScreen(),
//'/login': (context) => LoginScreen(),
//'/register': (context) => RegisterScreen(),
//},
//);
