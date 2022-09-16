import 'package:flutter/material.dart';
import 'package:nandorocha_histologia/core/viewmodels/hitolomap_model.dart';
import 'package:nandorocha_histologia/view/screens/histolomap_screen.dart';
import 'package:nandorocha_histologia/view/screens/home_menu_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HistoloMapModel>(
          create: (context) => HistoloMapModel(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeMenuScreen(),
        // home: HistoloMapScreen(),
      ),
    );
  }
}
