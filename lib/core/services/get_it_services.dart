import 'package:get_it/get_it.dart';

import 'package:ecommerce_app_project/core/services/data_services.dart';
import 'package:ecommerce_app_project/core/services/firebase_auth_services.dart';
import 'package:ecommerce_app_project/core/services/firestore_services.dart';

import 'package:ecommerce_app_project/features/auth/data/repo/auth_repo_impl.dart';
import 'package:ecommerce_app_project/features/auth/domain/repos/auth_repo.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  // ✅ Services
  getIt.registerSingleton<FirebaseAuthServices>(
    FirebaseAuthServices(),
  );

  getIt.registerSingleton<DatabaseService>(
    FireStoreService(),
  );

  // ✅ Repos
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      firebaseAuthServices: getIt<FirebaseAuthServices>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
}
