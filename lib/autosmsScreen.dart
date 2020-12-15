import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'widgets/MyCustomTimer.dart';
import 'services/ApiServices.dart';
import 'controller/otpController.dart';
import 'permissionScreen.dart';

//Signature: rRIYn79l4oL

class AutoSmsScreen extends StatefulWidget {
  AutoSmsScreen({Key key, this.phoneNo}) : super(key: key);

  final String phoneNo;

  @override
  _AutoSmsScreenState createState() => _AutoSmsScreenState();
}

class _AutoSmsScreenState extends State<AutoSmsScreen> {
  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
    print('Entered listen Otp method');
  }

  var _blankFocusNode = FocusNode();

  var phone = ApiService();
  @override
  void initState() {
    super.initState();
    _listenOtp();
  }

  @override
  void dispose() {
    print('Entered dispose method');

    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  final verifyOtp = OtpController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  // margin: EdgeInsets.all(24),
                  child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    ),
                    onPressed: () {
                      exit(0);
                    },
                  )
                ],
              )),
              Text(
                'Verification Code',
                style: TextStyle(fontSize: 24),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Your verification code sent to\n         +${widget.phoneNo}',
                  style: TextStyle(color: Colors.black45),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
                child: Builder(
                  builder: (context) {
                    return PinFieldAutoFill(
                      codeLength: 6,
                      autofocus: false,
                      onCodeChanged: (val) {
                        //  verifyOtp.validation(context, 'Invalid Otp', val, widget.phoneNo,
                        FocusScope.of(context).requestFocus(_blankFocusNode);
                        Future.delayed(Duration(seconds: 1), () {
                       if (val.length == 6) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => PermissionScreen()));
                         
                       }

                        });
                        // _blankFocusNode
                      },
                    );
                  },
                ),
              ),
              MyTimer20(),
              Text(
                'Your verification code detect automatically\n   if not please enter manually',
                key: Key('Verification Text'),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black45),
              ),
              Container(
                height: 150,
                child: FlareActor(
                  'assets/Kia_loading_dot.flr',
                  animation: "Loading",
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
