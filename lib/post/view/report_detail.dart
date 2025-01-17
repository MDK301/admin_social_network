// hien thi bai viet bi report.
// neu 1 bai viet bi report nhieu lan, list danh sách người report và khiếu nại của họ.
//tại đây xóa bài viết bi report.
import 'package:admin_social_network/post/controller/post_report_firebase.dart';
import 'package:admin_social_network/post/model/post_report.dart';
import 'package:admin_social_network/user/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../user/controller/user_manager_firebase.dart';
import '../model/post_model.dart';

class ReportDetail extends StatefulWidget {
  final PostReport report;

  const ReportDetail({super.key, required this.report});

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  //tên nguoi report
  //ten postOwner
  //Post Detail
  ProfileManager profileManager = ProfileManager();
  PostReportFirebase postInfo = PostReportFirebase();

  @override
  Widget build(BuildContext context) {
    final postreport = PostReportFirebase();

    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: (){

            }, child: const Text("Remove")),

            TextButton(onPressed: (){

            }, child: const Text("Delete Post")),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("ID: ${widget.report.id}"),
              Text("Post ID: ${widget.report.postId}"),
              //post
              StreamBuilder<Post?>(
                  stream: postInfo.getPostsByPostId(widget.report.postId),
                  builder: (context, snapshot) {
                    return ExpansionTile(
                      //ten reporter
                      title: Text("Post Title: ${snapshot.data?.text}"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    "Likes count: ${snapshot.data?.likes.length}"),
                                Image.network(snapshot.data!.imageUrl),
                                Text("uid: ${snapshot.data?.userName}"),
                              ]),
                        )
                      ],
                    );
                  }),

              //reporter
              StreamBuilder<ProfileUser?>(
                  stream:
                      profileManager.getUserProfile(widget.report.userReportId),
                  builder: (context, snapshot) {
                    return ExpansionTile(
                      //ten reporter
                      title: Text("Reporter: ${snapshot.data?.name}"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("email: ${snapshot.data?.email}"),
                                Text("uid: ${snapshot.data?.uid}"),
                              ]),
                        )
                      ],
                    );
                  }),
              //post owner
              StreamBuilder<ProfileUser?>(
                  stream:
                      profileManager.getUserProfile(widget.report.postOwnerId),
                  builder: (context, snapshot) {
                    return ExpansionTile(
                      //ten reporter
                      title: Text("Post Owner: ${snapshot.data?.name}"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("email: ${snapshot.data?.email}"),
                                Text("uid: ${snapshot.data?.uid}"),
                              ]),
                        )
                      ],
                    );
                  }),
              //report content
              Text("Report Content: ${widget.report.reportContent}"),
            ],
          ),
        ));
  }
}
