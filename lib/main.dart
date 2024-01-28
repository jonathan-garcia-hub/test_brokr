import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_brokr/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:test_brokr/viewmodels/login_viewmodel.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          // Otros providers según sea necesario
        ],
        child: SplashScreen(), // Puedes reemplazar HomeScreen con tu widget principal
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
