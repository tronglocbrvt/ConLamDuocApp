import 'package:conlamduoc/core/define.dart';
import 'package:conlamduoc/core/helper.dart';
import 'package:conlamduoc/model/user.dart';
import 'package:conlamduoc/widget/avatar_view.dart';
import 'package:conlamduoc/widget/custom_dialog.dart/custom_alert_dialog.dart';
import 'package:conlamduoc/widget/my_date_picker/my_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  final User userInfo;

  ProfilePage({
    @required this.userInfo,
  }) : assert(userInfo != null);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static TextEditingController _usernameController = TextEditingController();
  static TextEditingController _nameController = TextEditingController();
  static TextEditingController _phoneController = TextEditingController();
  static TextEditingController _emailController = TextEditingController();
  static TextEditingController _birthdayController = TextEditingController();
  static Gender _radioValue = Gender.Male;
  static DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.userInfo.username;
    _nameController.text = widget.userInfo.fullName;
    _phoneController.text = widget.userInfo.parentPhone;
    _emailController.text = widget.userInfo.parentEmail;
    _birthdayController.text =
        DateFormat("dd/MM/yyyy").format(widget.userInfo.birthday);
    _radioValue = widget.userInfo.gender;
    _dateTime = null;
  }

  void _updateProfileInfo() {
    // TODO: Code here for updating profile info

    showCustomAlertDialog(
      context,
      title: R.strings.notice,
      content: R.strings.updateProfileSuccessfully,
      firstButtonText: R.strings.ok,
      firstButtonFunction: () => pop(context),
    );
  }

  void _onChangedSearchBox(TextEditingController controller, String data) {
    // TODO: Implement here
  }

  void _onSubmittedSearchBox(TextEditingController controller, String data) {
    if (data.length == 0) return;
    // TODO: Implement here
  }

  void _clearSearchBoxContent(TextEditingController controller) {
    controller.clear();
  }

  void _showBirthdayDateTimePicker(TextEditingController controller) async {
    final DateTime today = new DateTime.now();
    final datePick = await showMyDatePicker(
        context: context,
        initialDate: today,
        firstDate: new DateTime(1900),
        lastDate: today);

    if (datePick != null && datePick != _dateTime) {
      String temp = DateFormat("dd/MM/yyyy").format(datePick);

      // TODO: Update birthday of user => Code here

      setState(() {
        _dateTime = datePick;
        controller.text = temp;
      });
    }
  }

  Widget _buildInputBox(TextEditingController controller, {enable: true}) {
    return Container(
      width: R.appRatio.deviceWidth,
      height: 40,
      decoration: BoxDecoration(
        color: (enable ? Colors.white : R.colors.grayABABAB),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Input box
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: TextField(
                enabled: enable,
                controller: controller,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                onSubmitted: (data) => _onSubmittedSearchBox(controller, data),
                onChanged: (data) => _onChangedSearchBox(controller, data),
                cursorColor: R.colors.strongBlue,
                decoration: InputDecoration(
                  isDense: true,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: R.strings.info,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ),
              ),
            ),
          ),
          // Clear text button
          GestureDetector(
            onTap: () => _clearSearchBoxContent(controller),
            child: Container(
              width: 15,
              height: 15,
              margin: EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: R.colors.strongBlue,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Image.asset(
                R.myIcons.appbarCloseWhiteBold,
                width: 8,
                height: 8,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildWidget = Scaffold(
      backgroundColor: R.colors.appBackground,
      appBar: AppBar(
        backgroundColor: R.colors.appBarBackground,
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.only(left: 10),
          child: Image.asset(R.images.logo),
        ),
        title: FittedBox(
          child: Text(
            R.strings.profile.toUpperCase(),
            textScaleFactor: 1.0,
            style: TextStyle(
              color: R.colors.strongBlue,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => _updateProfileInfo(),
              child: Image.asset(
                R.myIcons.appbarCheckWhiteBold,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              // -------------
              // Avatar
              AvatarView(
                avatarImageURL: widget.userInfo.avatar,
                avatarImageSize: 120,
                enableSquareAvatarImage: false,
                pressAvatarImage: () {
                  // TODO: A function for doing something
                  print("[PROFILE PAGE] Press avatar");
                },
                avatarBoxBorder: Border.all(
                  color: R.colors.oldYellow,
                  width: 2,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              // -------------
              // Fullname
              Text(
                R.strings.fullName,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: R.colors.strongBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildInputBox(_nameController),
              SizedBox(
                height: 25,
              ),
              // -------------
              // Username
              Text(
                R.strings.username,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: R.colors.strongBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildInputBox(_usernameController, enable: false),
              SizedBox(
                height: 25,
              ),
              // -------------
              // Birthday
              Text(
                R.strings.birthday,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: R.colors.strongBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildInputBox(_birthdayController, enable: false),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: GestureDetector(
                      onTap: () =>
                          _showBirthdayDateTimePicker(_birthdayController),
                      child: Image.asset(
                        R.myIcons.calendar,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              // -------------
              // Radio
              Text(
                R.strings.gender,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: R.colors.strongBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: RadioListTile(
                      value: Gender.Male,
                      groupValue: _radioValue,
                      title: Text(
                        R.strings.male,
                        style: TextStyle(fontSize: 14),
                      ),
                      activeColor: R.colors.strongBlue,
                      onChanged: (val) {
                        setState(() {
                          _radioValue = Gender.Male;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: Gender.Female,
                      groupValue: _radioValue,
                      title: Text(
                        R.strings.female,
                        style: TextStyle(fontSize: 14),
                      ),
                      activeColor: R.colors.strongBlue,
                      onChanged: (val) {
                        setState(() {
                          _radioValue = Gender.Female;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              // -------------
              // Parent email
              Text(
                R.strings.parentEmail,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: R.colors.strongBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildInputBox(_emailController),
              SizedBox(
                height: 25,
              ),
              // -------------
              // Parent phone
              Text(
                R.strings.parentPhone,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: R.colors.strongBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildInputBox(_phoneController),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );

    return NotificationListener<OverscrollIndicatorNotification>(
        child: _buildWidget,
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        });
  }
}
