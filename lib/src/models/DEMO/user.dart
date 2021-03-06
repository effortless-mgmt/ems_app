class UserDEMO {
  UserDEMO(
      {this.firstName,
      this.lastName,
      this.title,
      this.company,
      this.description,
      this.imgURL,
      this.phoneNumber});

  final String firstName;
  final String lastName;
  final String title;
  final String company;
  final String description;
  final String imgURL;
  final int phoneNumber;

  factory UserDEMO.fromJson(Map<dynamic, dynamic> json) {
    return UserDEMO(
        firstName: json["firstName"],
        lastName: json["lastName"],
        title: json["title"],
        company: json["company"],
        description: json["description"],
        imgURL: json["imgURL"],
        phoneNumber: json["phoneNumber"]);
  }
}

final sampleUser1 = new UserDEMO(
    firstName: "Lee",
    lastName: "Wang",
    title: "Supervisor",
    company: "Real Good Raughs ltd.",
    description: "Does the Raughing",
    imgURL: "https://i.imgur.com/pQFvMMU.jpg",
    phoneNumber: 11111111);
final sampleUser2 = new UserDEMO(
    firstName: "Ötzi",
    lastName: "Thall",
    title: "Supervisor",
    company: "Djent memes are still relevant inc.",
    description: "Knows his 0001-01-000-110-10-01",
    imgURL: "https://i.imgur.com/pNpQRtB.jpg",
    phoneNumber: 22222222);
final sampleUser3 = new UserDEMO(
    firstName: "Bat",
    lastName: "Man",
    title: "Warehouse Manager",
    company: "Wayne Corp.",
    description: "Fights crime and stuff",
    imgURL: "https://i.imgur.com/0sLF0e4.jpg",
    phoneNumber: 33333333);
final sampleUser4 = new UserDEMO(
    firstName: "Arse",
    lastName: "Biscuité",
    title: "Secretary",
    company: "Army",
    description: "Generally an arse",
    imgURL: "https://i.imgur.com/RrQ0jpl.jpg",
    phoneNumber: 44444444);
