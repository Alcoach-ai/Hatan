

enum StateEvent {
  current('الحالية' , 1) , next('التالية' , 3) , previous('السابقة' , 2) , all('الكل',0);
  final String value;
  final int id;
  const StateEvent(this.value , this.id);
}

class Effectiveness {
  String? certificateImage;
  String? certificateName;
  String created_at;
  String date;
  String goals;
  bool isRegistration  =false;
  int hours;
  int id;
  String name;
  String place;
  String time;
  String updated_at;
  late StateEvent state ;

  Effectiveness(
      {
        required this.certificateImage,
        required this.certificateName,
        required this.created_at,
        required this.date,
        required this.goals,
        required this.hours,
        required this.id,
        required this.name,
        required this.place,
        required this.time,
        required this.updated_at
      });

  static Effectiveness static() => Effectiveness(date: '1-1-2000', place: 'اللاذقية- قرب مجمع افاميا', goals: 'مرافقة دار الايتام في رحلة سياحية', id: 24, hours: 4, name: 'رحلة سياحية', certificateName: '', created_at: '', updated_at: '', certificateImage: '', time: '' );



  factory Effectiveness.fromJson(Map<String, dynamic> json) {
    return Effectiveness(
      certificateImage: json['certificateImage'],
      certificateName: json['certificateName'],
      created_at: json['created_at'],
      date: json['date'],
      goals: json['goals'],
      hours: json['hours'],
      id: json['id'],
      name: json['name'],
      place: json['place'],
      time: json['time'],
      updated_at: json['updated_at'],
    );
  }

}