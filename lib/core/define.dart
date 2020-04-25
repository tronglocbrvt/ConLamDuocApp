import 'package:conlamduoc/util/reflector.dart';

const DEFAULT_LENGTH = 30;

// Define error code
const LOGOUT_CODE = 100;
const MAINTENANCE = 101;
const FORCE_UPDATE = 102;

const FIELD_REQUIRED = 1000;
const ACCESS_DENY = 1001;
const UPDATE_FAIL = 1002;
const IMAGE_INVALID = 1003;
const OTP_INVALID = 1004;
const OTP_EXPIRED = 1005;

enum PlatformType {
  Unknown,
  iOS,
  Android,
}

@reflector
enum Gender { Male, Female }
