
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}


extension PhoneValidator on String {
  bool isValidPhone() {
    if(length == 12 && substring(0,3)=='966'){
      return true;
    }else{
      return false;
    }
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    if(length > 5){
      return true;
    }else{
      return false;
    }
  }
}

extension AgeValidator on DateTime{
  bool isValidAge() {
    if( DateTime.now().year - year > 15 ){
      return true;
    }else{
      return false;
    }
  }
}

extension IDValidator on String{
  bool isValidID() {
    if( length == 10 ){
      return true;
    }else{
      return false;
    }
  }
}