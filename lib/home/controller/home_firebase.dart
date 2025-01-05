import 'package:firebase_auth/firebase_auth.dart';

void logout() async {
  try {
    // Gọi hàm signOut của FirebaseAuth để đăng xuất
    await FirebaseAuth.instance.signOut();
    print("Đăng xuất thành công.");
  } catch (e) {
    throw Exception('Đây không phải là Email của Admin');

  }
}
