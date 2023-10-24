class AccountModel {
  String? username;
  String? password;
  String? mail;
  String? mailPassword;
  String? rank;
  String? dob;

  AccountModel({this.username, this.password, this.mail, this.mailPassword, this.rank, this.dob});

  AccountModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    mail = json['mail'];
    mailPassword = json['mailPassword'];
    rank = json['rank'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['mail'] = mail;
    data['mailPassword'] = mailPassword;
    data['rank'] = rank;
    data['dob'] = dob;
    return data;
  }
}
