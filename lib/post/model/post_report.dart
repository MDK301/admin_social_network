import 'package:cloud_firestore/cloud_firestore.dart';

import 'comment_model.dart';

class PostReport {
  final String id;
  final String userReportId;
  final String postId;
  final String postOwnerId;
  final String reportContent;
  final DateTime timeCreateReport;

  PostReport({
    required this.id,
    required this.userReportId,
    required this.postId,
    required this.postOwnerId,
    required this.reportContent,
    required this.timeCreateReport,
  });

  PostReport copyWith({String? imageUrl}) {
    return PostReport(
      id: id,
      userReportId: userReportId,
      postId: postId,
      postOwnerId: postOwnerId,
      reportContent: reportContent,
      timeCreateReport: timeCreateReport,
    );
  }
// convert post -> json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userReportId': userReportId,
      'postId': postId,
      'postOwnerId': postOwnerId,
      'reportContent': reportContent,
      'timeCreateReport': Timestamp.fromDate(timeCreateReport),

    };
  }

// convert json -> post
  factory PostReport.fromJson(Map<String, dynamic> json) {

    // prepare comments
    final List<Comment> comments = (json['comments'] as List<dynamic>?)
        ?.map((commentJson) => Comment.fromJson(commentJson))
        .toList() ??
        [];

    return PostReport(
      id: json['id'],
      userReportId: json['userReportId'],
      postId: json['postId'],
      postOwnerId: json['postOwnerId'],
      reportContent: json['reportContent'],
      timeCreateReport: (json['timeCreateReport'] as Timestamp).toDate(),
    );
  }

}

