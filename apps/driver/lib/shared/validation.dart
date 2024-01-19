import 'package:phone_number/phone_number.dart';

const _regionInfo = RegionInfo(name: 'Indonesia', code: "ID", prefix: 62);
Future<PhoneNumber> e164PhoneNumber(String phoneNumber) async {
  return await PhoneNumberUtil().parse(
    phoneNumber,
    regionCode: _regionInfo.code,
  );
}

Future<bool> validatePhoneNumber(String phoneNumber) async {
  return await PhoneNumberUtil().validate(
    phoneNumber,
    regionCode: _regionInfo.code,
  );
}
