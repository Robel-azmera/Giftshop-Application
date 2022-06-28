class CustomerDetailsModel {
  int id;
  String firstName;
  String lastName;
  Billing billing;
  Shipping shipping;

  CustomerDetailsModel({
    this.firstName,
    this.shipping,
    this.billing,
    this.lastName,
  });

  CustomerDetailsModel.fromJSON(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    billing =
        json["billing"] != null ? new Billing.fromJSON(json["billing"]) : null;
    shipping = json["shipping"] != null
        ? new Shipping.fromJSON(json["shipping"])
        : null;
  }
}

class Billing {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;
  String email;
  String phone;

  Billing({
    this.lastName,
    this.firstName,
    this.address1,
    this.address2,
    this.city,
    this.company,
    this.country,
    this.email,
    this.phone,
    this.postcode,
    this.state,
  });

  Billing.fromJSON(Map<String, dynamic> json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    company = json["company"];
    address1 = json["address_1"];
    address2 = json["address_2"];
    city = json["city"];
    postcode = json["postcode"];
    country = json["country"];
    state = json["state"];
    email = json["email"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["company"] = this.company;
    data["address_1"] = this.address1;
    data["address_2"] = this.address2;
    data["city"] = this.city;
    data["postcode"] = this.postcode;
    data["country"] = this.country;
    data["state"] = this.state;
    data["email"] = this.email;
    data["phone"] = this.phone;
    return data;
  }
}

class Shipping {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;
  String note;

  Shipping(
      {this.country,
      this.city,
      this.postcode,
      this.address2,
      this.address1,
      this.company,
      this.lastName,
      this.firstName,
      this.state,
      this.note});

  Shipping.fromJSON(Map<String, dynamic> json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    company = json["company"];
    address1 = json["address_1"];
    address2 = json["address_2"];
    city = json["city"];
    postcode = json["postcode"];
    country = json["country"];
    state = json["state"];

    note = json["note"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["company"] = this.company;
    data["address_1"] = this.address1;
    data["address_2"] = this.address2;
    data["city"] = this.city;
    data["postcode"] = this.postcode;
    data["country"] = this.country;
    data["state"] = this.state;
    data["note"] = this.note;
    return data;
  }
}
