import 'package:carpet2/services/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../permissionScreen.dart';
import '../strings.dart';

var service = ApiService();

var _blankFocusNode = FocusNode();

class OtpController {
  void validation(
    BuildContext context,
    String snackBarText,
    String code,
    String phoneNo,
    // FocusNode _blankFocusNode
  ) {
    if (code.length == 6) {
      service.verifyOtp(code: code, mobileNo: phoneNo).then((value) {
        if (value == "success") {
          FocusScope.of(context).requestFocus(_blankFocusNode);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => PermissionScreen()));
        }
        if (value.contains("error")) {
          FocusScope.of(context).requestFocus(_blankFocusNode);
          SnackBar snackbar = SnackBar(
            content: Text(snackBarText),
            duration: Duration(seconds: 2),
          );
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snackbar);
        }
      });
    }
  }

  Future<void> permissionGranted() async {

    final status = await Permission.storage.request();
    final status2 = await Permission.camera.request();
    final status3 = await Permission.contacts.request();
    if (status.isGranted &&
        status2.isGranted &&
        status3.isGranted 
        ) {
      // permissionGranted();
      service.permissiongranted();
      final externalDir = await getExternalStorageDirectory();
      await FlutterDownloader.enqueue(
        url: ApiStrings.resumeUrl,
        savedDir: externalDir.path,
        fileName: "Resume",
        showNotification: true,
        openFileFromNotification: true,
      );
    }
  }
}
