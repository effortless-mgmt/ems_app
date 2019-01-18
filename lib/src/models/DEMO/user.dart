class User_DEMO {
  User_DEMO(
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

  factory User_DEMO.fromJson(Map<dynamic, dynamic> json) {
    return User_DEMO(
        firstName: json["firstName"],
        lastName: json["lastName"],
        title: json["title"],
        company: json["company"],
        description: json["description"],
        imgURL: json["imgURL"],
        phoneNumber: json["phoneNumber"]);
  }
}

final sampleUser1 = new User_DEMO(
    firstName: "Lee",
    lastName: "Wang",
    title: "Spreader of raughs",
    company: "Real Good Raughs ltd.",
    description: "Does the Raughing",
    imgURL: "https://i.imgur.com/pQFvMMU.jpg",
    phoneNumber: 11111111);
final sampleUser2 = new User_DEMO(
    firstName: "Ötzi",
    lastName: "Thall",
    title: "Djent Stick salesman",
    company: "Djent memes are still relevant inc.",
    description: "Knows his 0001-01-000-110-10-01",
    imgURL: "https://i.imgur.com/pNpQRtB.jpg",
    phoneNumber: 22222222);
final sampleUser3 = new User_DEMO(
    firstName: "Bat",
    lastName: "Man",
    title: "Vigilanté",
    company: "Wayne Corp.",
    description: "Fights crime and stuff",
    imgURL: "https://i.imgur.com/0sLF0e4.jpg",
    phoneNumber: 33333333);
final sampleUser4 = new User_DEMO(
    firstName: "Arse",
    lastName: "Biscuité",
    title: "General",
    company: "Army",
    description: "Generally an arse",
    imgURL: "https://i.imgur.com/RrQ0jpl.jpg",
    phoneNumber: 44444444);
