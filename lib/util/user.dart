class User {
  User(
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

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        title: json["title"],
        company: json["company"],
        description: json["description"],
        imgURL: json["imgURL"],
        phoneNumber: json["phoneNumber"]);
  }
}

final sampleUser1 = new User(
    firstName: "Lee",
    lastName: "Wang",
    title: "Spreader of raughs",
    company: "Real Good Raughs ltd.",
    description: "Does the Raughing",
    imgURL: "https://i.imgur.com/pQFvMMU.jpg",
    phoneNumber: 12345678);
final sampleUser2 = new User(
    firstName: "Ötzi",
    lastName: "Thall",
    title: "Djent Stick salesman",
    company: "Djent memes are still relevant inc.",
    description: "Knows his 0001-01-000-110-10-01",
    imgURL: "https://i.imgur.com/pNpQRtB.jpg",
    phoneNumber: 12345678);
final sampleUser3 = new User(
    firstName: "Bat",
    lastName: "Man",
    title: "Vigilanté",
    company: "Wayne Corp.",
    description: "Fights crime and stuff",
    imgURL: "https://i.imgur.com/0sLF0e4.jpg",
    phoneNumber: 12345678);
final sampleUser4 = new User(
    firstName: "Arse",
    lastName: "Biscuité",
    title: "General",
    company: "Army",
    description: "Generally an arse",
    imgURL: "https://i.imgur.com/RrQ0jpl.jpg",
    phoneNumber: 12345678);
