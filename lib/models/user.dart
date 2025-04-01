
class User {
  String bornDate;
  late String fullName;
  final String email;
  final String secondName;
  final String firstName;
  final int hours;
  final int? id;
  final String idNumber;
  final int? type;
  final String lastName;
  final  String? password;
  final String phone;
  final int? section;
  final int? team;
  final String? remember_token;
  final String? created_at;
  String? teamName ;
  String? sectionName;
  String? updated_at;

  User(
      {
        this.type,
        this.id,
        this.sectionName,
        required this.firstName,
        required this.secondName,
        required this.lastName,
        required this.bornDate,
        required this.idNumber,
        required this.phone,
        required this.email,
        required this.password,
        required this.hours,
        this.team ,
        this.section,
        this.teamName,
        this.updated_at,
        this.remember_token,
        this.created_at,
      }) {
    if( team != null && team! > 0  ){
      teamName = 'الفريق ${team!}';
    }
    fullName = '$firstName $secondName $lastName';
  }

  static User static() => User(
      firstName: 'مصطفى',
      email: 'Mustafa@gmail.com',
      secondName: 'احمد',
      lastName: 'احمد',
      phone: '000000000',
      idNumber: '06010101010',
      bornDate: DateTime(2000).toString(),
      teamName: '',
      remember_token: '',
      team: 1,
      password: '',
      section: 1,
      hours: 1
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      type: json['type'],
      bornDate: json['bornDate'],
      created_at: json['created_at'],
      email: json['email'],
      secondName: json['fatherName'],
      firstName: json['firstName'],
      sectionName: json['section_name'],
      hours: json['hours'],
      id: json['id'],
      idNumber: json['idNumber'],
      lastName: json['lastName'],
      password: json['password'],
      phone: json['phone'],
      remember_token: json['remember_token'],
      section: json['section'],
      team:json['team'] ,
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['bornDate'] = bornDate;
    data['email'] = email;
    data['fatherName'] = secondName;
    data['firstName'] = firstName;
    //data['hours'] = hours;
    //data['id'] = id;
    data['idNumber'] = idNumber;
    data['lastName'] = lastName;
    data['password'] = password;
    data['phone'] = phone;
    //data['section'] = section;
    //data['team'] = team;
    return data;
  }


}



