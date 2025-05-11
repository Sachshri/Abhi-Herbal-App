import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_flutter_app/app.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  // Add Widgets Binding
  final WidgetsBinding widgetBinding =
      WidgetsFlutterBinding.ensureInitialized();
  //  Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  // Init Local Storage
  await GetStorage.init();
  //CLoudinary Configuration
  await dotenv.load(fileName: "assets/.env");
  String cloudinaryApiKey = dotenv.env['CLOUDINARY_API_KEY'] ?? "No api key";
  String cloudinaryApiSecret =
      dotenv.env['CLOUDINARY_API_SECRET'] ?? "No api key";
  String cloudinaryCloudName =
      dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? "No api key";
  final cloudinary = Cloudinary.fromStringUrl(
    'cloudinary://$cloudinaryApiKey:$cloudinaryApiSecret@$cloudinaryCloudName',
  );
  cloudinary.config.urlConfig.secure = true;
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) {
    return Get.put(AuthenticationRepository());
  });
  // Initialize Authentication
  runApp(const MyApp());
}
