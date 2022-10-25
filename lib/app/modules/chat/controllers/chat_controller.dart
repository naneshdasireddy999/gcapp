import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mygetxchat/app/modules/chat/services/remote_services.dart';

class ChatController extends GetxController {
  final count = 0.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>>? fetchmessages() {
    return RemoteServices.fetchmessages();
  }

  Future<void> addmessages(String m) async {
    await RemoteServices.addmessages(m);
  }

  @override
  void onInit() {
    fetchmessages();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
