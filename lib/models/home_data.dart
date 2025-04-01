class HomeData {
    String bornDate;
    String created_at;
    String email;
    int eventsCount;
    String fatherName;
    String firstName;
    int hours;
    int id;
    String idNumber;
    String lastName;
    String? password;
    String phone;
    int? section;
    int? team;
    String? teamName;
    String? sectionName;

    int type;
    String updated_at;
    late String name;

  HomeData(
      {required this.bornDate,
          this.sectionName,
      required this.created_at,
      required this.email,
      required this.eventsCount,
      required this.fatherName,
      required this.firstName,
      required this.hours,
      required this.id,
      required this.idNumber,
      required this.lastName,
          this.password,
      required this.phone,
      required this.section,
      required this.team,
      required this.type,
      required this.updated_at}){
      if( team != null && team! > 0 ){
          teamName = 'الفريق ${team!}';
      }else{
          teamName = null;
      }

      name = '$firstName $fatherName $lastName';
  }


  factory HomeData.fromJson(Map<String, dynamic> json) {
        return HomeData(
            bornDate: json['bornDate'], 
            created_at: json['created_at'], 
            email: json['email'], 
            eventsCount: json['eventsCount'], 
            fatherName: json['fatherName'], 
            firstName: json['firstName'], 
            sectionName: json['section_name'],
            hours: json['hours'],
            id: json['id'], 
            idNumber: json['idNumber'], 
            lastName: json['lastName'], 
            password: json['password'], 
            phone: json['phone'], 
            section: json['section'],
            team: json['team'], 
            type: json['type'], 
            updated_at: json['updated_at'], 
        );
    }


}