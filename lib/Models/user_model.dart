class UserViewModel {
  String? email;
  String? userId;

  UserViewModel({this.email, this.userId});

  UserViewModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['userId'] = this.userId;

    return data;
  }
}
