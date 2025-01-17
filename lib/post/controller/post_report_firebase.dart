import 'package:admin_social_network/post/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/post_report.dart';

class PostReportFirebase {
  //lấy list report post
  Stream<List<PostReport>> getListReportPostStream() {
    return FirebaseFirestore.instance
        .collection('reports')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return PostReport.fromJson(doc.data());
      }).toList()
        ..sort((a, b) => a.timeCreateReport.compareTo(b.timeCreateReport)); // Sắp xếp tăng dần theo email
    });
  }



  Stream<Post?>getPostsByPostId(String postId)  {
    try {
      // fetch posts snapshot with this uid
      return FirebaseFirestore.instance
          .collection('posts').where('id', isEqualTo: postId).snapshots()
          .map((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return Post.fromJson(snapshot.docs.first.data());
        } else {
          return null; // Trả về null nếu không tìm thấy post
        }
      });


    } catch (e) {
      throw Exception("Error fetching posts by user: $e");
    }
  }
}