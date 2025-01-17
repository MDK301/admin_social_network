// hien thi bai viet bi report.
// neu 1 bai viet bi report nhieu lan, list danh sách người report và khiếu nại của họ.
//tại đây xóa bài viết bi report.
import 'package:admin_social_network/post/controller/post_report_firebase.dart';
import 'package:admin_social_network/post/view/component/report_tile.dart';
import 'package:flutter/material.dart';

class AllReportPost extends StatelessWidget {
  const AllReportPost({super.key});

  @override
  Widget build(BuildContext context) {
    final postreport = PostReportFirebase();

    return Scaffold(
      appBar: AppBar(
        title: Text("ALL REPORT POST"),
      ),
      body: StreamBuilder(
          stream: postreport.getListReportPostStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final report = snapshot.data!;
              return ListView.builder(
                  itemCount: report.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        //trang tri for each box
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(color: Colors.grey, width: 1.0), // Khung viền
                          borderRadius: BorderRadius.circular(12.0), // Bo góc (tuỳ chọn)
                        ),
                        child: ReportTile(postReport: report[index]),

                      ),
                    );
                  });
            }
            return Container();
          }),
    );
  }
}
