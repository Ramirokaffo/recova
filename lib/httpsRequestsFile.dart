import 'dart:core';

import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.Dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:projet_flutter2/RoutesFile.dart';
import 'package:projet_flutter2/ConstantFile.dart';
import 'package:projet_flutter2/LocalBdManagerFile.dart';

class ObjectEntity {
  late int id;

  late int objectType;

  late String categorie;

  late String objectOrOwnerName;

  late String loseOrNowSide;

  late int holderId;

  late int userRemarqueObject;

  late String holderLoseOrOwnerNumber;

  late String objectStatus;

  late String objectNumber;

  late String objectName;

  late String objectDescription;

  late String recouvrementMoy;

  late String image;

  late String proofImage;

  late String otherType;
}

Future getAllObjectType({String? precision}) async {
  ListObjectType.clear();
  late Map<String ,dynamic> jsonResponse;
  var url = Uri.http(uri, getObjectTypeRoute);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    jsonResponse = await convert.jsonDecode(response.body) as Map<String ,dynamic>;
    // print(jsonResponse["today"]);
    if (precision == null) {
      for (var ligne in jsonResponse["principal"]) {
        ListObjectType.add(DropdownMenuItem(
          value: ligne["type"],
          child: Text(
            ligne["type"]!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ));
      }
      return ListObjectType;
    } else if (precision == "simple") {
      // List<dynamic> listObjectType2 = [];
      // ListObjectType.length
      // print(jsonResponse["today"].length);
      // print(jsonResponse["today"][0]["image"]);
      if (jsonResponse["today"].length == 1 && jsonResponse["today"][0]["image"] == "None") {
      } else {
        jsonResponse["today"].map((e) {
          var listpath = e["image"]["image"].toString().split("/");
          e["image"]["image"] = "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/${e['image']['type']}";
        }).toList();
      }
      print("j'arive ici la");

      jsonResponse["all"].map((e) {
          var listpath = e["image"]["image"].toString().split("/");
      e["image"]["image"] = "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/${e['image']['type']}";
    }).toList();
      jsonResponse["principal"].map((e) {
          var listpath = e["image"]["image"].toString().split("/");
      e["image"]["image"] = "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/${e['image']['type']}";
    }).toList();
      jsonResponse["other"].map((e) {
          var listpath = e["image"]["image"].toString().split("/");
      e["image"]["image"] = "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/${e['image']['type']}";
    }).toList();
      jsonResponse["region"].map((e) {
          var listpath = e["image"]["image"].toString().split("/");
      e["image"]["image"] = "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/${e['image']['type']}";
    }).toList();
      // print("j'arive ici");
      // for (var ligne in jsonResponse["all"] + jsonResponse["principal"] + jsonResponse["other"]) {
      //   var listpath = ligne["image"]["image"].toString().split("/");
      //   ligne["image"]["image"] = "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/${ligne['image']['type']}";
      //   listObjectType2.add(ligne);
      // }
      return jsonResponse;
    }
  }
  return jsonResponse;
}

Future userGetOnwerObjectSave() async {
  var url = Uri.http(uri, userGetOnwerObjectSaveRoute);
  var response = await http.get(url, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  });
  if (response.statusCode == 200) {
    userObjectSaveList =
        await convert.jsonDecode(response.body) as List<dynamic>;
  }
  return userObjectSaveList;
}

Future userGetOnwerObjectTransaction(String categorie) async {
  var url = Uri.http(uri, "$userGetOnwerObjectTransactionRoute/$categorie");
  var response = await http.get(url, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  });
  if (response.statusCode == 200) {
    userObjectSaveList =
        await convert.jsonDecode(response.body) as List<dynamic>;
    for (var ligne in userObjectSaveList) {
      var listpath = ligne["image"].toString().split("/");
      ligne["image"] =
          "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/${ligne["nowSide"] != null ? "R" : "P"}";
    }
  }
  return userObjectSaveList;
}

Future userGetPendingTransaction(String categorie) async {
  var url = Uri.http(uri, "$userGetPendingTransactionRoute/$categorie");
  var response = await http.get(url, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  });
  if (response.statusCode == 200) {
    userObjectSaveList =
        await convert.jsonDecode(response.body) as List<dynamic>;
    for (var ligne in userObjectSaveList) {
      var listpath = ligne["image"].toString().split("/");
      ligne["image"] =
          "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/${ligne["nowSide"] != null ? "R" : "P"}";
    }
  }
  return userObjectSaveList;
}

Future<List<SelectedListItem>> newGetAllObjectType({String? precision}) async {
  newListObjectType.clear();
  late List<dynamic> jsonResponse;
  var url = Uri.http(uri, getPrincipalObjectTypeRoute);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    try {
      jsonResponse = await convert.jsonDecode(response.body) as List<dynamic>;

    } catch (e) {
    }
    if (precision == null) {
      for (var ligne in jsonResponse) {
        newListObjectType
            .add(SelectedListItem(name: ligne["type"], value: ligne["type"]));
      }
      return newListObjectType;
    }
  }
  return [];
}

Future getOneUserDataById() async {
  late List<dynamic> jsonResponse;
  var url = Uri.http(uri, getOneUserDataByIdRoute);
  var response = await http.get(url, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  });
  // print(response.body);
  // print(await localBdSelectSetting("token"));
  if (response.statusCode == 200) {
    jsonResponse = await convert.jsonDecode(response.body) as List<dynamic>;
    oneUserDataDico = await jsonResponse[0];
    // print("oneUserDataDico :  $oneUserDataDico");
    return jsonResponse[0];
  }
}

Future saveUserObjectData(
    {required String objectType, required String objectNumber}) async {
  late List<dynamic> jsonResponse;
  var url = Uri.http(uri, saveUserObjectDataRoute);
  var response = await http.post(url, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  }, body: {
    "objectType": objectType,
    "objectNumber": objectNumber
  });
  if (response.statusCode == 201) {
    jsonResponse = await convert.jsonDecode(response.body) as List<dynamic>;
    oneUserDataDico = await jsonResponse[0];
    return jsonResponse[0];
  }
}

Future userUpdsateAccount({required Map<String, dynamic> dataMap}) async {
  var url = Uri.http(uri, userUpdsateAccountRoute);
  var response = await http.post(url,
      headers: {
        "authorization": "Bearer ${await localBdSelectSetting("token")}"
      },
      body: dataMap);
  var jsonResponse =
      await convert.jsonDecode(response.body) as Map<String, dynamic>;
  return jsonResponse;
}

Future userDeleteInAccount({required String culumnName}) async {
  var url = Uri.http(uri, userDeleteInAccountRoute);
  var response = await http.delete(url, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  }, body: {
    "culumnName": culumnName
  });
  // print(response.body);
  // print(response.statusCode);
  var jsonResponse =
      await convert.jsonDecode(response.body) as Map<String, dynamic>;
  return jsonResponse;
}

Future<List> selectListObjectsWithRoute(
    String route, List<dynamic> owntypeList) async {
  owntypeList.clear();
  var url = Uri.http(uri, route);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    owntypeList = await convert.jsonDecode(response.body) as List<dynamic>;
    // print(owntypeList);
  }
  return owntypeList;
}

Future userDeleteOwnTransaction({required int id, required String categorie}) async {
  var url = Uri.http(uri, "$userDeleteOwnTransactionRoute$id/$categorie");
  var response = await http.delete(url, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  });
  var jsonResponse =
      await convert.jsonDecode(response.body) as Map<String, dynamic>;
  return jsonResponse;
}

Future uploadImagePicker(String imagesPath, String imageName) async {
  var dio = Dio();
  dio.options
    ..baseUrl = "http://$uri"
    ..connectTimeout = 5000 //5s
    ..receiveTimeout = 5000
    ..validateStatus = (int? status) {
      return status != null && status > 0;
    }
    ..headers = {
      HttpHeaders.userAgentHeader: 'dio',
      'common-header': 'xx',
    };
  dio.interceptors
    ..add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // return handler.resolve( Response(data:"xxx"));
        // return handler.reject( DioError(message: "eh"));
        return handler.next(options);
      },
    ))
    ..add(LogInterceptor(responseBody: false)); //Open log;

  // var response = await dio.get(uri);

  // Download a file
  // response = await dio.download(
  //   'https://www.google.com/',
  //   './example/xx.html',
  //   queryParameters: {'a': 1},
  //   onReceiveProgress: (received, total) {
  //     if (total != -1) {
  //       print('$received,$total');
  //     }
  //   },
  // );

  // Create a FormData
  var formData = FormData.fromMap({
    'age': 25,
    'file': await MultipartFile.fromFile(
      imagesPath,
      filename: imageName,
    )
  });

  // Send FormData
  var response = await dio.post('/user/upload', data: formData);
  // print(response.data);

  // String name = 'Demo Title';
  // String desc = 'Ma super description :)';
  // var imageFile = File(images);
  // List<int> imageBytes = imageFile.readAsBytesSync();
  // String image = base64Encode(imageBytes);
  //
  // var url = Uri.http(uri, 'user/upload');
  // Map<String, String> headers = {
  //   "Authorization": "Bearer  ${await localBdSelectSetting('token')}"
  // };
  //
  // Map<String, dynamic> json = {
  //   "title": name,
  //   "name": name,
  //   "description": desc,
  //   "image": image,
  //   "type": "base64"
  // };

  // final response = await http.post(url, headers: headers, body: json);
  // print("response: ${response.body}");
  // if (response.statusCode != 200) {
  //   return null;
  // }
}

Future<bool> imageDownloadViaLink(String link) async {
  try {
    // Saved with this method.
    var imageId = await ImageDownloader.downloadImage(link);
    if (imageId == null) {
      return false;
    } else {
      return true;
    }

    // Below is a method of obtaining saved image information.
    // var fileName = await ImageDownloader.findName(imageId);
    // var path = await ImageDownloader.findPath(imageId);
    // var size = await ImageDownloader.findByteSize(imageId);
    // var mimeType = await ImageDownloader.findMimeType(imageId);
  } on PlatformException catch (error) {
    print(error);
    return false;
  }
}

Future homePageGetAllObject(String categorie, String region, {String precision = "all"}) async {
  // print(categorie);
  late List<dynamic> jsonResponse;
  var url = Uri.http(uri, "$getAllRecoverAndLoseObjectRoute/$categorie/$region/$precision");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    jsonResponse = await convert.jsonDecode(response.body) as List<dynamic>;
    // print("Voici cette liste ici: $jsonResponse");
    // initialValue = jsonResponse;
    for (var ligne in jsonResponse) {
      var listpath = ligne["image"].toString().split("/");
      ligne["image"] =
          "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/$categorie";
    }
    return jsonResponse;
  }
}

Future recoverChangeNRtoR(
    int objectId, String newStatus, String categorie) async {
  var url = Uri.http(uri, "$recoverChangeNRtoRRoute/$categorie");
  var response = await http.post(url, body: {
    "id": "$objectId"
  }, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  });
  var jsonResponse =
      await convert.jsonDecode(response.body) as Map<String, dynamic>;
  return jsonResponse;
}

Future <String> userCountryCodeCheck() async {
  List<RegionInfo> regions = await PhoneNumberUtil().allSupportedRegions();
  String userCountryCodes = await PhoneNumberUtil().carrierRegionCode();
  print("userCountryCodes: ${userCountryCodes}");
  var code = regions.singleWhere((element) =>
      element.code.toString().toUpperCase() ==
      userCountryCodes.toString().toUpperCase());
  userCountryCode = "+${code.prefix}";
  return "+${code.prefix}";
}

Future getAllSearchObject(String searchInput) async {
  late List<dynamic> jsonResponse;
  late String categorie;
  var url = Uri.http(uri, "$objectSearchRoute/$searchInput");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    jsonResponse = await convert.jsonDecode(response.body) as List<dynamic>;
    for (var ligne in jsonResponse) {
      var listpath = ligne["image"].toString().split("/");
      if (ligne["loseSide"] != Null) {
        categorie = "P";
      } else {
        print("La categorie c'est Retrouvée");
        categorie = "R";
      }
      ligne["image"] =
          "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/$categorie";
      print(jsonResponse);
    }
    return jsonResponse;
  }
}

Future<List> selectOwnTypeObjects(
    String type, String categorie, String region) async {
  List<dynamic> ownObjectListe = [];

  var url = Uri.http(uri, "$selectObjectByTypeRoute$type/$categorie/$region");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    ownObjectListe = await convert.jsonDecode(response.body) as List<dynamic>;
    for (var ligne in ownObjectListe) {
      var listpath = ligne["image"].toString().split("/");
      ligne["image"] =
          "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/$categorie";
    }
    return ownObjectListe;
  } else {
    return ownObjectListe;
  }
}

Future getRightLosePriceByObjectId(int itemId) async {
  var url = Uri.http(uri, getRightLosePriceByObjectIdRoute + itemId.toString());
  var response = await http.get(url, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  });
  if (response.statusCode == 200) {
    var ownItemList =
        await convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(ownItemList);
    return ownItemList;
  } else {
    return ownItemList;
  }
}

Future<List> selectOwnObjectsById(int itemId, String categorie) async {
  var url = Uri.http(uri, "$selectObjectByIdRoute$itemId/$categorie");
  var response = await http.get(url, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  });
  if (response.statusCode == 200) {
    ownItemList = await convert.jsonDecode(response.body) as List<dynamic>;
    for (var ligne in ownItemList) {
      var listpath = ligne["image"].toString().split("/");
      ligne["image"] =
          "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/$categorie";
    }
    return ownItemList;
  } else {
    return ownItemList;
  }
}

Future<List> getobjectTypeCategorieById(int itemId) async {
  var url = Uri.http(uri, getobjectTypeCategorieByIdRoute + itemId.toString());
  var response = await http.get(url, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  });
  if (response.statusCode == 200) {
    ownItemList = await convert.jsonDecode(response.body) as List<dynamic>;
    return ownItemList;
  } else {
    return ownItemList;
  }
}

Future<List> getAllOtherTypeObject() async {
  List<dynamic> OtherTypeObjectList = [];
  var url = Uri.http(uri, getAllOtherTypeObjectRoute);
  var response = await http.get(url, headers: {
    "authorization": "Bearer ${await localBdSelectSetting("token")}"
  });
  if (response.statusCode == 200) {
    var OtherTypeObjectList =
        await convert.jsonDecode(response.body) as List<dynamic>;
    return OtherTypeObjectList;
  } else {
    return OtherTypeObjectList;
  }
}

Future sendRecoverOrLoseThingData(
    {String? imagesPath,
    String? imageName,
    String? objectType,
    String? otherType,
    String? categorie,
    String? loseOrNowSide,
    String? holderLoseOrOwnerNumber,
    String? objectNumber,
    String? objectOrOwnerName,
    String? objectDescription}) async {
  late Map<String, dynamic> mapData;
  var dio = Dio();
  dio.options
    ..baseUrl = "http://$uri"
    ..connectTimeout = 5000 //5s
    ..receiveTimeout = 5000
    ..validateStatus = (int? status) {
      return status != null && status > 0;
    }
    ..headers = {
      HttpHeaders.userAgentHeader: 'dio',
      'common-header': 'xx',
      "authorization": "Bearer ${await localBdSelectSetting("token")}"
    };
  dio.interceptors
    ..add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
    ))
    ..add(LogInterceptor(responseBody: false)); //Open log;

  if (categorie! == "P") {
    mapData = {
      'objectType': objectType,
      'otherType': otherType,
      'loseSide': loseOrNowSide,
      'ownerNumber': holderLoseOrOwnerNumber,
      'objectNumber': objectNumber,
      'objectName': objectOrOwnerName,
      "objectDescription": objectDescription
    };
  } else {
    mapData = {
      'objectType': objectType,
      'otherType': otherType,
      'nowSide': loseOrNowSide,
      'holderNumber': holderLoseOrOwnerNumber,
      'objectNumber': objectNumber,
      'objectName': objectOrOwnerName,
      "objectDescription": objectDescription
    };
  }
  if (imagesPath!.isNotEmpty) {
    mapData["file"] = (await MultipartFile.fromFile(
      imagesPath,
      filename: imageName,
    ));
  }
  var formData = FormData.fromMap(mapData);
  var response =
      await dio.post("$recoverOrLoseObjectRoute/$categorie", data: formData);
  return (response.data) as Map<String, dynamic>;
}

Future sendProofOwnerImage(
    {required String imagesPath,
    required String imageName,
    required int objectId,
    required String categorie}) async {
  var dio = Dio();
  dio.options
    ..baseUrl = "http://$uri"
    ..connectTimeout = 5000 //5s
    ..receiveTimeout = 5000
    ..validateStatus = (int? status) {
      return status != null && status > 0;
    }
    ..headers = {
      HttpHeaders.userAgentHeader: 'dio',
      'common-header': 'xx',
      "authorization": "Bearer ${await localBdSelectSetting("token")}"
    };
  dio.interceptors
    ..add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
    ))
    ..add(LogInterceptor(responseBody: false));

  var formData = FormData.fromMap({
    "id": objectId,
    "file": await MultipartFile.fromFile(
      imagesPath,
      filename: imageName,
    )
  });

  var response =
      await dio.post("$sendProofOwnerImageRoute/$categorie", data: formData);
  print(response.data);

  return response.data;
}
