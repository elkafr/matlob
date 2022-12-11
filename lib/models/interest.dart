class Interest {
  Interest({
    this.interestId,
    this.interestCat,
    this.interestUser,
  });
  String interestId;
  String interestCat;
  String interestUser;

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    interestId: json["interest_id"],
    interestCat: json["interest_cat"],
    interestUser: json["interest_user"],
  );

  Map<String, dynamic> toJson() => {
    "interest_id": interestId,
    "interest_cat": interestCat,
    "interest_user": interestUser,
  };
}
