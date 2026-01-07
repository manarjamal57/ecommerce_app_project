import 'package:ecommerce_app_project/features/cart/presentation/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:ecommerce_app_project/core/helper_functions/on_generate_routes.dart';
import 'package:ecommerce_app_project/features/splash/presentation/views/splash_view.dart';
import 'package:ecommerce_app_project/core/services/get_it_services.dart';
import 'package:ecommerce_app_project/core/services/custom_bloc_ob_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ فعّلي الـ Bloc Observer قبل ما تبدأي تستخدمين Cubit/Bloc
  Bloc.observer = CustomBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ حقن الاعتمادات قبل تشغيل التطبيق
  configureDependencies();
runApp(
  ChangeNotifierProvider(
    create: (_) => CartProvider(),
    child: const EcommerceAppProject(),
  ),
);

}

class EcommerceAppProject extends StatelessWidget {
  const EcommerceAppProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
    );
  }
}
