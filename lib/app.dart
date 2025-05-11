
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:new_flutter_app/bindings/general_bindings.dart';
import 'package:new_flutter_app/routes/app_routes.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      themeMode: ThemeMode.system,
      theme: CustomAppTheme.lightTheme,
      darkTheme: CustomAppTheme.darkTheme,
      getPages:AppRoutes.pages,
      home: const Scaffold(
        backgroundColor: ColorConstants.primary,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white,),
        ),
      ),
    );
  }
}