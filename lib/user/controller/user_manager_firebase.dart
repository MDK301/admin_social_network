import 'package:admin_social_network/user/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileManager {
   Stream<List<ProfileUser>> getProfileUserStream() {
    return FirebaseFirestore.instance
        .collection('user')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProfileUser.fromJson(doc.data());
      }).toList()
        ..sort((a, b) => b.email.compareTo(a.email));
    });
  }
}
