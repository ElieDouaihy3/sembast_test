class MobileAppData {
  String? id,label,typeLabel,description,icon;
  Map? subItems;

  MobileAppData({
    this.id,
    this.label,
    this.typeLabel,
    this.description,
    this.icon,
    this.subItems
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ID'          : id             ,
      'Label'       : label          ,
      'TypeLabel'   : typeLabel      ,
      'Description' : description    ,
      'Icon'        : icon           ,
    };
    return map;
  }

  MobileAppData.fromMap(Map<String, dynamic> map) {
    id           = map['ID']["\$"];
    label        = map['Label']["\$"];
    typeLabel    = map['TypeLabel']["\$"];
    description  = map['Description']["\$"];
    icon         = map['Icon']["\$"];
    subItems     = map['SubItems'];
  }
}