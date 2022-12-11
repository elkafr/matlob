
class Ad {
    Ad({
        this.adsId,
        this.adsTitle,
        this.adsUrl,
        this.adsDate,
        this.adsAge,
        this.adsFullDate,
        this.adsVisits,
        this.adsCat,
        this.adsCatName,
        this.adsCatImage,
        this.adsSub,
        this.adsSubCatName,
        this.adsCatUrl,
        this.adsCountry,
        this.adsCountryName,
        this.adsCountryUrl,
        this.adsCityName,
        this.adsMarka,
        this.adsMarkaName,
        this.adsMarkaUrl,
        this.adsType,
        this.adsTypeName,
        this.adsTypeUrl,
        this.adsModel,
        this.adsModelName,
        this.adsModelUrl,
        this.adsUser,
        this.adsUserName,
        this.adsUserUrl,
        this.adsPhoto,
        this.adsPhoto11,
        this.adsPhoto22,
        this.adsPhoto33,
        this.adsPhoto44,
        this.adsDetails,
        this.adsPrice,
        this.adsPhone,
        this.adsRate,
        this.adsAdress,
        this.adsLocation,



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
        this.adsAsasia,
        this.adsAqarType,

        this.adsIsFavorite,
    });

    String adsId;
    String adsTitle;
    String adsUrl;
    String adsDate;
    String adsAge;
    String adsFullDate;
    String adsVisits;
    String adsCat;
    String adsCatName;
    String adsCatImage;
    String adsSub;
    String adsSubCatName;
    String adsCatUrl;
    String adsCountry;
    String adsCountryName;
    String adsCountryUrl;
    String adsCityName;
    String adsMarka;
    String adsMarkaName;
    String adsMarkaUrl;
    String adsType;
    String adsTypeName;
    String adsTypeUrl;
    String adsModel;
    String adsModelName;
    String adsModelUrl;
    String adsUser;
    String adsUserName;
    String adsUserUrl;
    String adsPhoto;
    String adsPhoto11;
    String adsPhoto22;
    String adsPhoto33;
    String adsPhoto44;
    String adsDetails;
    String adsPrice;
    String adsPhone;
    String adsRate;
    String adsAdress;
    String adsLocation;



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
    String adsAqarType;


    int adsIsFavorite;

    factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        adsId: json["ads_id"],
        adsTitle: json["ads_title"],
        adsUrl: json["ads_url"],
        adsDate: json["ads_date"],
        adsAge: json["ads_age"],
        adsFullDate: json["ads_full_date"],
        adsVisits: json["ads_visits"],
        adsCat: json["ads_cat"],
        adsCatName: json["ads_cat_name"],
        adsCatImage: json["ads_cat_image"],
        adsSub: json["ads_sub"],
        adsSubCatName: json["ads_sub_cat_name"],
        adsCatUrl: json["ads_cat_url"],
        adsCountry: json["ads_country"],
        adsCountryName: json["ads_country_name"],
        adsCountryUrl: json["ads_country_url"],
        adsCityName: json["ads_city_name"],
        adsMarka: json["ads_marka"],
        adsMarkaName: json["ads_marka_name"],
        adsMarkaUrl: json["ads_marka_url"],
        adsType: json["ads_type"],
        adsTypeName: json["ads_type_name"],
        adsTypeUrl: json["ads_type_url"],
        adsModel: json["ads_model"],
        adsModelName: json["ads_model_name"],
        adsModelUrl: json["ads_model_url"],
        adsUser: json["ads_user"],
        adsUserName: json["ads_user_name"],
        adsUserUrl: json["ads_user_url"],
        adsPhoto: json["ads_photo"],
        adsPhoto11: json["ads_photo11"],
        adsPhoto22: json["ads_photo22"],
        adsPhoto33: json["ads_photo33"],
        adsPhoto44: json["ads_photo44"],
        adsDetails: json["ads_details"],
        adsPrice: json["ads_price"],
        adsPhone: json["ads_phone"],
        adsRate: json["ads_rate"],
        adsAdress: json["ads_adress"],
        adsLocation: json["ads_location"],





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
        adsAqarType: json["ads_aqarType"],



        adsIsFavorite: json["ads_is_favorite"],
    );

    Map<String, dynamic> toJson() => {
        "ads_id": adsId,
        "ads_title": adsTitle,
        "ads_url": adsUrl,
        "ads_date": adsDate,
        "ads_age": adsAge,
        "ads_full_date": adsFullDate,
        "ads_visits": adsVisits,
        "ads_cat": adsCat,
        "ads_cat_name": adsCatName,
        "ads_cat_image": adsCatImage,
        "ads_sub": adsSub,
        "ads_sub_cat_name": adsSubCatName,
        "ads_cat_url": adsCatUrl,
        "ads_country": adsCountry,
        "ads_country_name": adsCountryName,
        "ads_country_url": adsCountryUrl,
        "ads_city_name": adsCityName,
        "ads_marka": adsMarka,
        "ads_marka_name": adsMarkaName,
        "ads_marka_url": adsMarkaUrl,
        "ads_type": adsType,
        "ads_type_name": adsTypeName,
        "ads_type_url": adsTypeUrl,
        "ads_model": adsModel,
        "ads_model_name": adsModelName,
        "ads_model_url": adsModelUrl,
        "ads_user": adsUser,
        "ads_user_name": adsUserName,
        "ads_user_url": adsUserUrl,
        "ads_photo": adsPhoto,
        "ads_photo11": adsPhoto11,
        "ads_photo22": adsPhoto22,
        "ads_photo33": adsPhoto33,
        "ads_photo44": adsPhoto44,
        "ads_details": adsDetails,
        "ads_price": adsPrice,
        "ads_phone": adsPhone,
        "ads_rate": adsRate,
        "ads_adress": adsAdress,
        "ads_location": adsLocation,


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
        "ads_aqarType": adsAqarType,

        "ads_is_favorite": adsIsFavorite,
    };
}
