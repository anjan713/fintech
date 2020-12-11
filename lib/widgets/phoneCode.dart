import 'package:flutter/material.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

Widget areaCode() {
  return TextField(
      readOnly: true,
      focusNode: AlwaysDisabledFocusNode(),
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        labelText: '+91',
        contentPadding: EdgeInsets.all(0),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
}


showOverlay(BuildContext context,bool keyboardactive) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          
              top: keyboardactive
                  ? MediaQuery.of(context).size.height / 2
                  : MediaQuery.of(context).size.height / 1.2,
              right: MediaQuery.of(context).size.width / 3,
              child: Material(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    color: Colors.black,
                    child: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 16,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Please enter vaild number',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    )),
              ),
            ));
    overlayState.insert(overlayEntry);

    await Future.delayed(Duration(seconds: 2));

    overlayEntry.remove();
  }


  // void validation(BuildContext context, String snackBarText,String code) {
  //   if (code.length == 6) {
  //     phone
  //           .verifyOtp(code: code, mobileNo: widget.phoneNo)
  //           .then((value) {
  //         if (value == "success") {
  //           FocusScope.of(context)
  //               .requestFocus(_blankFocusNode);
  //           Navigator.of(context).push(MaterialPageRoute(
  //               builder: (_) => PermissionScreen()));
  //         }
  //         if (value.contains("error") ) {
  //           FocusScope.of(context)
  //               .requestFocus(_blankFocusNode);
  //           SnackBar snackbar = SnackBar(
  //             content: Text(snackBarText),
  //             duration: Duration(seconds: 2),
  //           );
  //           Scaffold.of(context).hideCurrentSnackBar();
  //           Scaffold.of(context).showSnackBar(snackbar);
  //         }
  //       });
  //   }