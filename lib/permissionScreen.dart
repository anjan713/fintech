import './widgets/resumeCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'strings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'controller/otpController.dart';

class PermissionScreen extends StatefulWidget {
  PermissionScreen({Key key}) : super(key: key);

  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _otpController = OtpController();
  // final _service = ApiService();

  _launchURL(url) async {
    //  url =this.;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'narla.anjan.16csc@bml.edu.in',
      queryParameters: {'subject': 'Anjan Narla Application'});

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: [
              Spacer(
                flex: 1,
              ),
              Container(
                child: CustomContainer(
                  shapes: true,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              NetworkImage(ApiStrings.profileImage),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Anjan Narla',
                              style: TextStyle(fontSize: 22),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('My Resume'),
                            SizedBox(
                              height: 8,
                            ),
                            RaisedButton(
                              onPressed: () async {
                                // final status =
                                //     await Permission.storage.request();
                                // final status2 =
                                //     await Permission.camera.request();
                                // final status3 =
                                //     await Permission.contacts.request();
                                // final status4 =
                                //     await Permission.location.request();
                                // if (status.isGranted && status2.isGranted && status3.isGranted && status4.isGranted) {
                                //   // permissionGranted();
                                 await _otpController.permissionGranted();
                                
                              },
                              child: Text('Download'),
                              textColor: Colors.white,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 450,
                child: ListView(physics: BouncingScrollPhysics(), children: [
                  SizedBox(
                    height: 30,
                  ),
                  CustomContainer(
                    shapes: true,
                    child: Row(
                      children: [
                        IconButton(
                          iconSize: 50,
                          icon: FaIcon(FontAwesomeIcons.github),
                          onPressed: () {
                            _launchURL(ApiStrings.githubUrl);
                          },
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Github',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomContainer(
                    shapes: true,
                    child: Row(
                      children: [
                        IconButton(
                          iconSize: 50,
                          icon: FaIcon(FontAwesomeIcons.instagram),
                          onPressed: () {
                            _launchURL(ApiStrings.instagramUrl);
                          },
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Instagram Page',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomContainer(
                    shapes: true,
                    child: Container(
                      child: Row(
                        children: [
                          IconButton(
                            iconSize: 50,
                            icon: Icon(Icons.mail),
                            onPressed: () {
                              _launchURL(_emailLaunchUri.toString());
                            },
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomContainer(
                    shapes: true,
                    child: Row(
                      children: [
                        IconButton(
                          iconSize: 50,
                          icon: FaIcon(FontAwesomeIcons.phoneAlt),
                          onPressed: () {
                            _launchURL('tel:+9948441044');
                          },
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Phone',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
