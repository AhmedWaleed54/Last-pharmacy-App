class Orders {

  int? id;
  String? fname;
  String? lname;
  String? email;
  String? address1;
  String? address2;
  String? city;
  String? state;
  int? zipcode;
  int? phone1;
  int? phone2;

  Orders({this.id,this.fname, this.phone1,this.phone2, this.state,this.city,this.lname,this.email,this.zipcode,this.address1,this.address2});
  Orders.fromJson({required Map <String,dynamic> data})
  {
    id = data['id'];
    fname = data['first_name'].toString();
    lname = data['last_name'].toString();
    phone1 =  int.parse(data['phone1']);
    email = data ['email'];
    zipcode =int.parse(data ['zip_code']);
    phone2 =int.parse(data ['phone2']);
    city=data['city'];
    state=data['state'];
    address1=data['address1'];
    address2=data['address2'];
  }




}