import 'package:phone_number/phone_number.dart';

Future<PhoneNumber> phoneE16(String phone) async {
  const region = RegionInfo(name: "Indonesia", code: "ID", prefix: 62);
  return await PhoneNumberUtil().parse(phone, regionCode: region.code);
}
