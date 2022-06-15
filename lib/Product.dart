class Product {
  final int id;
  final String myAppointmentId;
  final String myDoctorId;
  final String doctorName;
  final String patientName;
  final String channelName;
  final int price;
  final String image;

  static final columns = ["id", "myAppointmentId", "myDoctorId", "doctorName", "patientName", "channelName", "price", "image"];
  Product(
      this.id,
      this.myAppointmentId,
      this.myDoctorId,
      this.doctorName,
      this.patientName,
      this.channelName,
      this.price,
      this.image

      );
  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      data['id'],
      data['myAppointmentId'],
      data['myDoctorId'],
      data['doctorName'],
      data['patientName'],
      data['channelName'],
      data['price'],
      data['image'],
    );
  }
  Map<String, dynamic> toMap() => {
    "id": id,
    "myAppointmentId": myAppointmentId,
    "myDoctorId": myDoctorId,
    "doctorName": doctorName,
    "patientName": patientName,
    "channelName": channelName,
    "price": price,
    "image": image
  };
}