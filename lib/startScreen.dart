import 'autosmsScreen.dart';
import 'widgets/phoneCode.dart';
import 'package:flutter/material.dart';
import 'services/ApiServices.dart';
import 'package:sms_autofill/sms_autofill.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with TickerProviderStateMixin {
  var phone = ApiService();

  Animation<Offset> animation;
  Animation textAnimation;
  AnimationController _controller;

  //to start animation
  bool firstClick = false;
  // opening text opacity value
  bool _opentextopacity = false;

  //when TextEditingController gets clicked
  bool _numberClick = false;

  //to validate mobile number
  bool _validate = false;

  //keyboard is on
  bool keyboardactive = false;
  TextEditingController _phoneController = TextEditingController();

  Alignment childAlignment = Alignment.bottomCenter;
  Alignment secondAlignment = Alignment.center;

  var _blankFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    getSignature();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = TweenSequence([
      TweenSequenceItem<Offset>(
        tween: Tween(
          begin: Offset(0, 0),
          end: Offset(-2, -3),
        ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 1,
      ),
      TweenSequenceItem(
          tween: Tween<Offset>(begin: Offset(-2, -3), end: Offset(-2, -3.5))
              .chain(CurveTween(curve: Curves.bounceOut)),
          weight: 0.1),
    ]).animate(_controller);

    textAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Interval(
          0,
          0.4,
          curve: Curves.decelerate,
        ),
        parent: _controller));
  }

  void pushContainerUp() {
    if (!_numberClick) {
      _numberClick = !_numberClick;
    }
    childAlignment = keyboardactive ? Alignment.center : Alignment.bottomCenter;
    secondAlignment = keyboardactive ? Alignment.topLeft : Alignment.center;
  }


  String signature;

  Future<void> getSignature() async {
    signature = await SmsAutoFill().getAppSignature;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
                  child: Stack(
            children: [
              Container(
                color: Colors.pink,
              ),
              if (!_numberClick)
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: AnimatedBuilder(
                    animation: _controller.view,
                    builder: (context, _) {
                      return SlideTransition(
                        position: animation,
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 5.0,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/redCarpetLogo.jpg'),
                            ), ),),);},), ),
              if (!_numberClick) openingText(),
              if (!firstClick)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    key: Key('Start Button'),
                    color: Colors.lightGreen,
                    onPressed: () {
                      _controller.forward();
                      setState(() {
                        firstClick = !firstClick;
                        _opentextopacity = !_opentextopacity;
                      });
                    },
                    child: Text('Lets Start'),
                  ),
                ),
              if (firstClick) bottomContainer(),
            ],
          ),
        ),
    );
  }

  Widget openingText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedOpacity(
        opacity: _opentextopacity ? 1.0 : 0.0,
        duration: Duration(seconds: 2),
        child: Text(
          ' Sign In with\n your phone\n number',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  //Bottom Container starts
  Widget bottomContainer() {
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 16),
      curve: Curves.easeOut,
      duration: Duration(
        milliseconds: 900,
      ),
      width: double.infinity,
      // height: 400,
      height: double.infinity,
      padding: EdgeInsets.all(8),
      alignment: childAlignment,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 1),
            alignment: secondAlignment,
            curve: Curves.decelerate,
            child: Opacity(
              opacity: _numberClick ? 1.0 : 0.0,
              child: Text(
                'Enter mobile number',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            height: 60,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      child: areaCode(),
                    )),
                Expanded(
                  flex: 6,
                  child: Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: TextFormField(
                      key: Key('Phone Field'),
                      style: TextStyle(color: Colors.white),
                      controller: _phoneController,
                      onTap: () {
                        setState(() {
                          keyboardactive = true;
                          pushContainerUp();
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText:
                            _numberClick ? '9123456789' : 'Enter mobile number',
                        contentPadding: EdgeInsets.all(0),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      cursorColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 30),
            child: Text(
              'We will send you One Time Password on this number',
                    key: Key('Otp Message'),
              textAlign: TextAlign.left,
              style: TextStyle(
                
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          FlatButton(
            key: Key('Verify Button'),
            onPressed: () {
              setState(() {
                _phoneController.text.isEmpty ||
                        _phoneController.text.length != 10
                    ? _validate = true
                    : _validate = false;
                if (_validate) {
                  showOverlay(context,keyboardactive);
                }
                if (!_validate) {
                  FocusScope.of(context).requestFocus(_blankFocusNode);
                  print('signature $signature');
                  phone.sendOtp(
                    _phoneController.text,
                  );
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AutoSmsScreen(
                            phoneNo: _phoneController.text,
                          )));
                }
              });
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text('VERIFY'),
            textColor: Colors.pink,
            color: Colors.white,
            minWidth: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
