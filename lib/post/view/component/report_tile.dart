import 'package:admin_social_network/post/model/post_report.dart';
import 'package:admin_social_network/post/view/report_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReportTile extends StatefulWidget {
  final PostReport postReport;

  const ReportTile({super.key, required this.postReport});

  @override
  State<ReportTile> createState() => _ReportTileState();
}

class _ReportTileState extends State<ReportTile> {
  //dinh dạng cho cái time
  String _formatTimestamp(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just Now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //emil
      title: Text(
        "Report ID: ${widget.postReport.id}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle:Text(widget.postReport.reportContent ?? '',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.grey)),
      trailing:  Text(
        "Date Create: ${_formatTimestamp(widget.postReport.timeCreateReport)}",
        style: const TextStyle(color: Colors.black,fontSize: 13),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReportDetail(report:widget.postReport,)),
        );
      },
    );
  }
}
