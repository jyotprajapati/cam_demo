import 'dart:io';

import 'package:alemeno/services/notifications_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  FirebaseStorageService();

  Future<String> uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final reference = FirebaseStorage.instance.ref().child(fileName);
    final uploadTask = await reference.putFile(image);
    String downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  /// Generic file upload for any [file]
  Future<String> upload({required File file}) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference =
          FirebaseStorage.instance.ref().child("/meal-pics").child(fileName);
      final uploadTask = await reference.putFile(file);
      String downloadUrl = await uploadTask.ref.getDownloadURL();
      uploadSuccessNotification();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  uploadSuccessNotification() {
    NotificationService().showNotification(
        title: "Upload Successful",
        notificationMessage: "Your image has been uploaded successfully");
  }
}
