import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:new_flutter_app/features/authentication/screens/login/login_screen.dart';
import 'package:new_flutter_app/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:new_flutter_app/features/authentication/screens/password_recovery/forget_password_screen.dart';
import 'package:new_flutter_app/features/authentication/screens/signup/sign_up_screen.dart';
import 'package:new_flutter_app/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:new_flutter_app/features/personalization/screens/address/address.dart';
import 'package:new_flutter_app/features/personalization/screens/profile/profile_screen.dart';
import 'package:new_flutter_app/features/personalization/screens/settings/setting_screen.dart';
import 'package:new_flutter_app/features/shop/screens/cart/cart.dart';
import 'package:new_flutter_app/features/shop/screens/checkout/checkout.dart';
import 'package:new_flutter_app/features/shop/screens/home_screen/home_screen.dart';
import 'package:new_flutter_app/features/shop/screens/order/order.dart';
import 'package:new_flutter_app/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:new_flutter_app/features/shop/screens/store/store_screen.dart';
import 'package:new_flutter_app/features/shop/screens/wishlist/favourite_screen.dart';
import 'package:new_flutter_app/routes/routes.dart';

class AppRoutes {
  static final pages =[
      GetPage(name: CustomRoutes.home,page: ()=>const HomeScreen()),
      GetPage(name: CustomRoutes.store,page: ()=>const StoreScreen()),
      GetPage(name: CustomRoutes.favourites,page: ()=>const FavouriteScreen()),
      GetPage(name: CustomRoutes.settings,page: ()=>const SettingScreen()),
      GetPage(name: CustomRoutes.productReview,page: ()=>const ProductReviewScreen()),
      GetPage(name: CustomRoutes.order,page: ()=>const OrderScreen()),
      GetPage(name: CustomRoutes.checkout,page: ()=>const CheckoutScreen()),
      GetPage(name: CustomRoutes.cart,page: ()=>const CartScreen()),
      GetPage(name: CustomRoutes.signup,page: ()=>const SignUpScreen()),
      GetPage(name: CustomRoutes.login,page: ()=>const LoginScreen()),
      GetPage(name: CustomRoutes.verifyEmail,page: ()=>const VerifyEmailScreen()),
      GetPage(name: CustomRoutes.forgetPassword,page: ()=>const ForgetPasswordScreen()),
      GetPage(name: CustomRoutes.onBoarding,page: ()=>const OnBoardingScreen()),
      GetPage(name: CustomRoutes.userAddress,page: ()=>const UserAddressScreen()),
      GetPage(name: CustomRoutes.userProfile,page: ()=>const ProfileScreen()),
  ];
}
