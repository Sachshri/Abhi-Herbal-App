import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/features/shop/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. Try again in few minutes';
      }
      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      if (result.docs.isEmpty) {
        //"No orders found for user: $userId");
        return [];
      }

      return result.docs.map((doc) {
        //"Fetched order: ${doc.data()}"); // Debugging
        return OrderModel.fromSnapshot(doc);
      }).toList();
      // return result.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    } catch (e) {
      //" Error /n error Error eroro${e.toString()}");
      throw 'Something went wrong fetching Order Information. Try again later in few minutes.';
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving order information. Try again later.';
    }
  }
}
