import 'dart:convert';

class Customer {
  String status;
  String message;
  Data data;

  Customer({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Customer.fromRawJson(String str) => Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  CustomerClass customer;
  String token;

  Data({
    required this.customer,
    required this.token,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customer: CustomerClass.fromJson(json["customer"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "customer": customer.toJson(),
    "token": token,
  };
}

class CustomerClass {
  int id;
  String stripeId;
  String name;
  String lastName;
  String email;
  String phoneCode;
  String phone;
  String birthdate;
  String idCountry;
  dynamic street;
  dynamic city;
  dynamic state;
  dynamic zipCode;
  dynamic avatar;
  String os;
  String socialAuth;
  String language;
  String fcmToken;
  String type;
  String completedProfile;
  String verifiedAsBroker;
  String verifiedAsHost;
  String verifiedAsAffiliate;
  dynamic additionalData;
  String verifiedIdentity;
  dynamic rejectionReason;
  String status;
  String createdAt;
  String updatedAt;

  CustomerClass({
    required this.id,
    required this.stripeId,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phoneCode,
    required this.phone,
    required this.birthdate,
    required this.idCountry,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.avatar,
    required this.os,
    required this.socialAuth,
    required this.language,
    required this.fcmToken,
    required this.type,
    required this.completedProfile,
    required this.verifiedAsBroker,
    required this.verifiedAsHost,
    required this.verifiedAsAffiliate,
    required this.additionalData,
    required this.verifiedIdentity,
    required this.rejectionReason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomerClass.fromRawJson(String str) => CustomerClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerClass.fromJson(Map<String, dynamic> json) => CustomerClass(
    id: json["id"],
    stripeId: json["stripe_id"],
    name: json["name"],
    lastName: json["last_name"],
    email: json["email"],
    phoneCode: json["phone_code"],
    phone: json["phone"],
    birthdate: json["birthdate"],
    idCountry: json["id_country"],
    street: json["street"],
    city: json["city"],
    state: json["state"],
    zipCode: json["zip_code"],
    avatar: json["avatar"],
    os: json["os"],
    socialAuth: json["social_auth"],
    language: json["language"],
    fcmToken: json["fcm_token"],
    type: json["type"],
    completedProfile: json["completed_profile"],
    verifiedAsBroker: json["verified_as_broker"],
    verifiedAsHost: json["verified_as_host"],
    verifiedAsAffiliate: json["verified_as_affiliate"],
    additionalData: json["additional_data"],
    verifiedIdentity: json["verified_identity"],
    rejectionReason: json["rejection_reason"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stripe_id": stripeId,
    "name": name,
    "last_name": lastName,
    "email": email,
    "phone_code": phoneCode,
    "phone": phone,
    "birthdate": birthdate,
    "id_country": idCountry,
    "street": street,
    "city": city,
    "state": state,
    "zip_code": zipCode,
    "avatar": avatar,
    "os": os,
    "social_auth": socialAuth,
    "language": language,
    "fcm_token": fcmToken,
    "type": type,
    "completed_profile": completedProfile,
    "verified_as_broker": verifiedAsBroker,
    "verified_as_host": verifiedAsHost,
    "verified_as_affiliate": verifiedAsAffiliate,
    "additional_data": additionalData,
    "verified_identity": verifiedIdentity,
    "rejection_reason": rejectionReason,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
