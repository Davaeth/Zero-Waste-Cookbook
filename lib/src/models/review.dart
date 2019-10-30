import 'user.dart';

class Review {
  int id;
  String description;
  int rate;
  User user;

  Review(this.user, this.description, this.rate);
}
