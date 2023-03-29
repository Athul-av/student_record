import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/Model/db/functions/db_functions.dart';
import 'package:student_manager/Model/db/model/student_model.dart';
import 'package:student_manager/Controller/provider/student_provider.dart';
import 'package:student_manager/View/Home%20Screen/home_screen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return StudentProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return StudentDb();
          },
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.indigo, 
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white10,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}