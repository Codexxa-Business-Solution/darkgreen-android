import 'package:flutter/material.dart';

class AutoHideAlertDialog extends StatefulWidget {
  @override
  _AutoHideAlertDialogState createState() => _AutoHideAlertDialogState();
}

class _AutoHideAlertDialogState extends State<AutoHideAlertDialog> {
  bool _isDialogVisible = false;

  void _showAutoHideDialog() {
    setState(() {
      _isDialogVisible = true;
    });

    // Hide the dialog after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isDialogVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto-hide Alert Dialog'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showAutoHideDialog,
          child: Text('Show Auto-hide Dialog'),
        ),
      ),
      // Show the dialog if it's visible
      floatingActionButton: _isDialogVisible
          ? AlertDialog(
        title: Text('Auto-hide Alert Dialog'),
        content: Text('This dialog will disappear after 3 seconds.'),
      )
          : null,
    );
  }
}
