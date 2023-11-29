class Security{
  static String jwt ="";

  static void setLoginData(String jwt){
    Security.jwt = jwt;
  }

  static void removeLogin(){
    Security.jwt = "";
  }
  
  static Map<String, String> getJwtAuthHeaders(){
    return <String, String>{'Authorization': 'Bearer '+jwt};
  }
}