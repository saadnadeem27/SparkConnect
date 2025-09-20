import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/controllers/navigation_controller.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const SparkConnectApp());
}

class SparkConnectApp extends StatelessWidget {
  const SparkConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SparkConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(NavigationController());
      }),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
