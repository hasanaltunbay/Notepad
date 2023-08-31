
class Nots{

  String not_id;
  String not_baslik;
  String not_Altbaslik;
  String not_icerik;

  Nots(this.not_id, this.not_baslik, this.not_Altbaslik, this.not_icerik);
  
  factory Nots.fromJson(String key,Map<dynamic,dynamic> json){
    return Nots(key, json["not_baslik"] as String, json["not_Altbaslik"] as String, json["not_icerik"] as String);

  }
}