import 'package:realm/realm.dart';

part 'category_realm_entity.realm.dart'; // thêm tên file vào đây để Realm biết file này là part của file nào

@RealmModel()
class _CategoryRealmEntity {
  // tên class phải viết thường và bắt đầu bằng _ vì realm bắt buộc phải có
  @PrimaryKey()
  late ObjectId id;
  late String name;
  late int? iconCodePoint; // để lưu icon trong flutter. Icons
  late String backgroundColorHex; // color hex string vì nó không thể lưu được class colors trực tiếp
  late String iconColorHex;
}
