class User {
    User({
        this.userId,
        this.userPhone,
        this.userEmail,
        this.userName,
        this.userCountry,
        this.userCity,
        this.userCityName,
        this.userCountryName,
        this.userPhoto,
        this.userJob,
        this.userWasf,
        this.userType,
        this.userCatName,
        this.userSubName
    });

    String userId;
    String userPhone;
    String userEmail;
    String userName;
    String userCountry;
    String userCity;
    String userCityName;
    String userCountryName;
    String userPhoto;
    String userJob;
    String userWasf;
    String userType;
    String userCatName;
    String userSubName;

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userPhone: json["user_phone"],
        userEmail: json["user_email"],
        userName: json["user_name"],
        userCountry: json["user_country"],
        userCity: json["user_city"],
        userCityName: json["user_city_name"],
        userCountryName: json["user_country_name"],
        userJob: json["user_job"],
        userPhoto: json["user_photo"],
        userWasf: json["user_wasf"],
        userType: json["user_type"],
        userCatName: json["user_cat_name"],
        userSubName: json["user_sub_name"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_phone": userPhone,
        "user_email": userEmail,
        "user_name": userName,
        "user_country": userCountry,
        "user_city": userCity,
        "user_city_name": userCityName,
        "user_country_name": userCountryName,
        "user_photo": userPhoto,
        "user_job": userJob,
        "user_wasf": userWasf,
        "user_type": userType,
        "user_cat_name": userCatName,
        "user_sub_name": userSubName,
    };
}