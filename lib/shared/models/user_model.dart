import 'package:open_art/core/services/utilities_service.dart';
import 'package:open_art/shared/utils/config.dart';

class UserType {
  UserType({
    this.id,
    this.type,
  });

  int id;
  String type;
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNo,
    this.picture,
    this.title,
    this.createdAt,
    this.email,
    this.middleName,
    this.phoneNo2,
    this.staffNo,
    this.updatedAt,
    this.username,
    this.status,
    this.isLoggedIn,
    this.authToken,
    this.confirmationToken,
    this.cadre,
    this.fingerprint,
    this.department,
    this.serviceCenter,
    this.unit,
    this.userType,
    this.dob,
    this.nin,
    this.gender,
    this.personalEmail,
  });

  factory User.fromJson(dynamic json) {
    if (json == null) {
      return null;
    }

    try {
      final String pictureUrl = (json['picture_path'] as String) == null
          ? ''
          : (json['picture_path'] as String) +
              '?time=${AppConfig.profilePictureTimestamp}';

      return User(
        id: json['id'] as int,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        middleName: json['middle_name'] as String,
        title: json['title'] as String,
        createdAt: UtilitiesService.toDateTime(json['created_at']),
        updatedAt: UtilitiesService.toDateTime(json['updated_at']),
        email: json['email'] as String,
        personalEmail: json['personal_email'] as String,
        nin: json['nin'] as String,
        dob: (json['dob'] != null)
            ? UtilitiesService.toDateTime(json['dob'])
            : UtilitiesService.toDateTime(DateTime.now()),
        picture: pictureUrl,
        username: json['username'] as String,
        staffNo: json['staff_no'] as String,
        gender: json['gender'] as String,
        phoneNo: json['phone_no'] as String,
        phoneNo2: json['phone_no2'] as String,
        status: json['status'] as int,
        isLoggedIn: json['is_logged_in'] == 1,
        authToken: json['auth_token'] as String,
        confirmationToken: json['confirmation_token'] as String,
        fingerprint: json['fingerprint'] as String,
        userType: UserUserTypeModel.fromJson(json['user_type']),
        unit: UserUnitModel.fromJson(json['unit']),
        cadre: UserCadreModel.fromJson(json['cadre']),
        department: UserDepartmentModel.fromJson(json['department']),
        serviceCenter: UserServiceCenterModel.fromJson(
          json['service_centre'],
        ),
      );
    } catch (e) {
      print(e);

      return null;
    }
  }

  void updatePicture() {
    AppConfig.profilePictureTimestamp = DateTime.now().millisecondsSinceEpoch;

    picture = picture == null
        ? ''
        : picture + '?time=${AppConfig.profilePictureTimestamp}';
  }

  int id;
  String title;
  String username;
  String firstName;
  String lastName;
  String middleName;
  String email;
  String personalEmail;
  String staffNo;
  String phoneNo;
  String phoneNo2;
  String picture;
  String gender;
  DateTime dob;
  String nin;
  DateTime createdAt;
  DateTime updatedAt;
  int status;
  bool isLoggedIn;
  String authToken;
  String confirmationToken;
  String fingerprint;
  UserUserTypeModel userType;
  UserCadreModel cadre;
  UserDepartmentModel department;
  UserUnitModel unit;
  UserServiceCenterModel serviceCenter;
}

class UserCadreModel {
  UserCadreModel({
    this.id,
    this.name,
    this.userTypeId,
  });

  factory UserCadreModel.fromJson(dynamic json) {
    if (json == null) {
      return null;
    }

    try {
      return UserCadreModel(
        id: json['id'] as int,
        name: json['name'] as String,
        userTypeId: json['user_type_id'] as int,
      );
    } catch (e) {
      print(e);
      print('Unable to parse User Cadre obj');
      return null;
    }
  }

  int id;
  String name;
  int userTypeId;
}

class UserUserTypeModel {
  const UserUserTypeModel({
    this.id,
    this.type,
  });

  factory UserUserTypeModel.fromJson(dynamic json) {
    return UserUserTypeModel(
      id: json['id'] as int,
      type: json['type'] as String,
    );
  }

  final int id;
  final String type;
}

class UserDepartmentModel {
  UserDepartmentModel({
    this.id,
    this.name,
    this.hospitalId,
    this.hod,
  });

  factory UserDepartmentModel.fromJson(dynamic json) {
    return UserDepartmentModel(
      id: json['id'] as int,
      name: json['name'] as String,
      hospitalId: json['hospital_id'] as int,
      hod: json['hod'] as String,
    );
  }

  int id;
  String name;
  int hospitalId;
  String hod;
}

class UserUnitModel {
  UserUnitModel({
    this.id,
    this.name,
    this.departmentId,
  });

  factory UserUnitModel.fromJson(dynamic json) {
    return UserUnitModel(
      id: json['id'] as int,
      name: json['name'] as String,
      departmentId: json['department_id'] as int,
    );
  }

  int id;
  String name;
  int departmentId;
}

class UserServiceCenterModel {
  const UserServiceCenterModel({
    this.id,
    this.name,
  });

  factory UserServiceCenterModel.fromJson(dynamic json) {
    return UserServiceCenterModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  final int id;
  final String name;
}
