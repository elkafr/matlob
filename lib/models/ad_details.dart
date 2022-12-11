class AdDetails {
    AdDetails({
        this.adsId,
        this.adsPhone,
        this.adsWhatsapp,
        this.adsTitle,
        this.checkAddFav,
        this.checkAddFollow,
        this.adsDetails,
        this.adsStar,
        this.adsPrice,
        this.adsUrl,
        this.adsDate,
        this.adsFullDate,
        this.adsVisits,
        this.adsAge,
        this.adsGender,
        this.adsComments,
        this.adsRelated,
        this.adsCat,
        this.adsSub,
        this.adsCatName,
        this.adsCatImage,
        this.adsCatPhone,
        this.adsCatAddress,
        this.adsCatUrl,
        this.adsCountry,
        this.adsCountryName,
        this.adsCountryUrl,
        this.adsCity,
        this.adsCityName,
        this.adsCityUrl,
        this.adsUser,
        this.adsUserName,
        this.adsUserPhone,
        this.adsUserPhoto,
        this.adsUserUrl,
        this.adsMainPhoto,
        this.photos,
        this.adsOwner,
        this.userDetails,
        this.adsRate,
        this.adsDays,
        this.adsIsFavorite,



        this.adsAdress,
        this.adsMarka,
        this.adsType,
        this.adsModel,
        this.adsVideo,
        this.adsDesc,
        this.adsSale,
        this.adsMapx,
        this.adsMapy,
        this.adsDuration,
        this.adsStars,
        this.adsItemsNumber,
        this.adsDoorsNumber,
        this.adsArea,
        this.adsStreet,
        this.adsQa3at,
        this.adsMwaqef,
        this.adsFace,
        this.adsAsanser,
        this.adsMshb,
        this.adsShopsNumber,
        this.adsBathNumbers,
        this.adsHallNumbers,
        this.adsKithchenNumber,
        this.adsCarPath,
        this.adsHoosh,
        this.adsRshashat,
        this.adsBeer,
        this.adsMsbh,
        this.adsMl2b,
        this.adsSellType,
        this.adsCarState,
        this.adsQeerType,
        this.adsWqoodType,
        this.adsDblFound,
        this.adsMmsha,
        this.adsRoomNumbers,
        this.adsLocation,
        this.adsAsasia,


    });

    String adsId;
    String adsPhone;
    String adsWhatsapp;
    String adsTitle;
    int checkAddFav;
    int checkAddFollow;
    String adsDetails;
    dynamic adsStar;
    String adsPrice;
    String adsUrl;
    String adsDate;
    String adsFullDate;
    String adsVisits;
    String adsAge;
    String adsGender;
    List<dynamic> adsComments;
    List<dynamic> adsRelated;
    String adsCat;
    String adsSub;
    String adsCatName;
    String adsCatImage;
    dynamic adsCatPhone;
    dynamic adsCatAddress;
    String adsCatUrl;
    String adsCountry;
    String adsCountryName;
    String adsCountryUrl;
    String adsCity;
    String adsCityName;
    String adsCityUrl;
    String adsUser;
    String adsUserName;
    String adsUserPhone;
    String adsUserPhoto;
    String adsUserUrl;
    String adsMainPhoto;
    List<Photo> photos;
    String adsOwner;
    List<UserDetail> userDetails;
    int adsRate;
    String adsAdress;
    dynamic adsDays;
    String adsLocation;
    int adsIsFavorite;





    String adsMarka;
    String adsType;
    String adsModel;
    String adsVideo;
    String adsDesc;
    String adsSale;
    String adsMapx;
    String adsMapy;
    String adsDuration;
    String adsStars;
    String adsGuarantee;
    String adsItemsNumber;
    String adsDoorsNumber;
    String adsArea;
    String adsStreet;
    String adsQa3at;
    String adsMwaqef;
    String adsFace;
    String adsAsanser;
    String adsMshb;
    String adsShopsNumber;
    String adsBathNumbers;
    String adsHallNumbers;
    String adsKithchenNumber;
    String adsCarPath;
    String adsHoosh;
    String adsRshashat;
    String adsBeer;
    String adsMsbh;
    String adsMl2b;
    String adsSellType;
    String adsCarState;
    String adsQeerType;
    String adsWqoodType;
    String adsDblFound;
    String adsMmsha;
    String adsRoomNumbers;
    String adsAsasia;







    factory AdDetails.fromJson(Map<String, dynamic> json) => AdDetails(
        adsId: json["ads_id"],
        adsPhone: json["ads_phone"],
        adsWhatsapp: json["ads_whatsapp"],
        adsTitle: json["ads_title"],
        checkAddFav: json["check_add_fav"],
        checkAddFollow: json["check_add_follow"],
        adsDetails: json["ads_details"],
        adsStar: json["ads_star"],
        adsPrice: json["ads_price"],
        adsUrl: json["ads_url"],
        adsDate: json["ads_date"],
        adsFullDate: json["ads_full_date"],
        adsVisits: json["ads_visits"],
        adsAge: json["ads_age"],
        adsGender: json["ads_gender"],
        adsComments: List<dynamic>.from(json["ads_comments"].map((x) => x)),
        adsRelated: List<dynamic>.from(json["ads_related_ads"].map((x) => x)),
        adsCat: json["ads_cat"],
        adsSub: json["ads_sub"],
        adsCatName: json["ads_cat_name"],
        adsCatImage: json["ads_cat_image"],
        adsCatPhone: json["ads_cat_phone"],
        adsCatAddress: json["ads_cat_address"],
        adsCatUrl: json["ads_cat_url"],
        adsCountry: json["ads_country"],
        adsCountryName: json["ads_country_name"],
        adsCountryUrl: json["ads_country_url"],
        adsCity: json["ads_city"],
        adsCityName: json["ads_city_name"],
        adsCityUrl: json["ads_city_url"],
        adsUser: json["ads_user"],
        adsUserName: json["ads_user_name"],
        adsUserPhone: json["ads_user_phone"],
        adsUserPhoto: json["ads_user_photo"],
        adsUserUrl: json["ads_user_url"],
        adsMainPhoto: json["ads_main_photo"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        adsOwner: json["ads_owner"],
        userDetails: List<UserDetail>.from(json["user_details"].map((x) => UserDetail.fromJson(x))),
        adsRate: json["ads_rate"],
        adsAdress: json["ads_adress"],
        adsDays: json["ads_days"],
        adsLocation: json["ads_location"],
        adsIsFavorite: json["ads_is_favorite"],




        adsMarka: json["ads_marka"],
        adsType: json["ads_type"],
        adsModel: json["ads_model"],
        adsVideo: json["ads_video"],
        adsDesc: json["ads_desc"],
        adsSale: json["ads_sale"],
        adsMapx: json["ads_mapx"],
        adsMapy: json["ads_mapy"],
        adsDuration: json["ads_duration"],
        adsStars: json["ads_stars"],
        adsItemsNumber: json["ads_itemsNumber"],
        adsDoorsNumber: json["ads_doorsNumber"],
        adsArea: json["ads_area"],
        adsStreet: json["ads_street"],
        adsQa3at: json["ads_qa3at"],
        adsMwaqef: json["ads_mwaqef"],
        adsFace: json["ads_face"],
        adsAsanser: json["ads_asanser"],
        adsMshb: json["ads_mshb"],
        adsShopsNumber: json["ads_shopsNumber"],
        adsBathNumbers: json["ads_bathNumbers"],
        adsHallNumbers: json["ads_hallNumbers"],
        adsKithchenNumber: json["ads_kithchenNumber"],
        adsCarPath: json["ads_carPath"],
        adsHoosh: json["ads_hoosh"],
        adsRshashat: json["ads_rshashat"],
        adsBeer: json["ads_beer"],
        adsMsbh: json["ads_msbh"],
        adsMl2b: json["ads_ml2b"],
        adsSellType: json["ads_sellType"],
        adsCarState: json["ads_carState"],
        adsQeerType: json["ads_qeerType"],
        adsWqoodType: json["ads_wqoodType"],
        adsDblFound: json["ads_dblFound"],
        adsMmsha: json["ads_mmsha"],
        adsRoomNumbers: json["ads_roomNumbers"],
        adsAsasia: json["ads_asasia"],



    );

    Map<String, dynamic> toJson() => {
        "ads_adress": adsAdress,
        "ads_phone": adsPhone,
        "ads_whatsapp": adsWhatsapp,
        "ads_title": adsTitle,
        "check_add_fav": checkAddFav,
        "check_add_follow": checkAddFollow,
        "ads_details": adsDetails,
        "ads_star": adsStar,
        "ads_price": adsPrice,
        "ads_url": adsUrl,
        "ads_date": adsDate,
        "ads_full_date": adsFullDate,
        "ads_visits": adsVisits,
        "ads_age": adsAge,
        "ads_gender": adsGender,
        "ads_comments": List<dynamic>.from(adsComments.map((x) => x)),
        "ads_related_ads": List<dynamic>.from(adsRelated.map((x) => x)),
        "ads_cat": adsCat,
        "ads_sub": adsSub,
        "ads_cat_name": adsCatName,
        "ads_cat_image": adsCatImage,
        "ads_cat_phone": adsCatPhone,
        "ads_cat_address": adsCatAddress,
        "ads_cat_url": adsCatUrl,
        "ads_country": adsCountry,
        "ads_country_name": adsCountryName,
        "ads_country_url": adsCountryUrl,
        "ads_city": adsCity,
        "ads_city_name": adsCityName,
        "ads_city_url": adsCityUrl,
        "ads_user": adsUser,
        "ads_user_name": adsUserName,
        "ads_user_phone": adsUserPhone,
        "ads_user_photo": adsUserPhoto,
        "ads_user_url": adsUserUrl,
        "ads_main_photo": adsMainPhoto,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "ads_owner": adsOwner,
        "user_details": List<dynamic>.from(userDetails.map((x) => x.toJson())),
        "ads_rate": adsRate,
        "ads_adress": adsAdress,
        "ads_days": adsDays,
        "ads_location": adsLocation,
        "ads_is_favorite": adsIsFavorite,



        "ads_marka": adsMarka,
        "ads_type": adsType,
        "ads_model": adsModel,
        "ads_video": adsVideo,
        "ads_desc": adsDesc,
        "ads_sale": adsSale,
        "ads_mapx": adsMapx,
        "ads_mapy": adsMapy,
        "ads_duration": adsDuration,
        "ads_stars": adsStars,
        "ads_itemsNumber": adsItemsNumber,
        "ads_doorsNumber": adsDoorsNumber,
        "ads_area": adsArea,
        "ads_street": adsStreet,
        "ads_qa3at": adsQa3at,
        "ads_mwaqef": adsMwaqef,
        "ads_face": adsFace,
        "ads_asanser": adsAsanser,
        "ads_mshb": adsMshb,
        "ads_mwaqef": adsMwaqef,
        "ads_shopsNumber": adsShopsNumber,
        "ads_bathNumbers": adsBathNumbers,
        "ads_hallNumbers": adsHallNumbers,
        "ads_kithchenNumber": adsKithchenNumber,
        "ads_carPath": adsCarPath,
        "ads_hoosh": adsHoosh,
        "ads_rshashat": adsRshashat,
        "ads_beer": adsBeer,
        "ads_msbh": adsMsbh,
        "ads_ml2b": adsMl2b,
        "ads_sellType": adsSellType,
        "ads_carState": adsCarState,
        "ads_qeerType": adsQeerType,
        "ads_wqoodType": adsWqoodType,
        "ads_dblFound": adsDblFound,
        "ads_mmsha": adsMmsha,
        "ads_roomNumbers": adsRoomNumbers,
        "ads_asasia": adsAsasia,
    };
}

class Photo {
    Photo({
        this.id,
        this.photo,
    });

    String id;
    String photo;

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
    };
}

class UserDetail {
    UserDetail({
        this.id,
        this.name,
        this.phone,
        this.numberOfAds,
        this.userImage,
    });

    String id;
    String name;
    String phone;
    int numberOfAds;
    String userImage;

    factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        numberOfAds: json["number of ads"],
        userImage: json["user_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "number of ads": numberOfAds,
        "user_image": userImage,
    };
}
