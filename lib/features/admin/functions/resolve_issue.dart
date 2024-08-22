import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> deleteIssue(BuildContext context, String issueId) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  try {
    await FirebaseFirestore.instance
        .collection('issues')
        .doc(issueId)
        .update({'issueStatus': 'Deleted'});
    scaffoldMessenger.showSnackBar(
      const SnackBar(content: Text("Issue deleted successfully")),
    );
  } catch (e) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text("Failed to delete issue: $e")),
    );
  }
}

Future<void> resolveIssue(BuildContext context, String issueId) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  try {
    // Update the issue status to resolved
    await FirebaseFirestore.instance
        .collection('issues')
        .doc(issueId)
        .update({'issueStatus': 'Resolved'});

    // show issue resolved successfully snackbar
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text("Issue resolved successfully!"),
      ),
    );
  } catch (e) {
    // show error message in snackbar
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text("Error resolving issue: $e"),
      ),
    );
  }
}
