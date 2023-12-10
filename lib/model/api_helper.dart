import 'dart:convert';

import 'package:http/http.dart';
import 'package:productlist/model/product_model.dart';

class ApiHelper{
  static final ApiHelper _apiHelper=ApiHelper.internal();
  factory ApiHelper()=>_apiHelper;
  ApiHelper.internal();

  static const _baseURL='https://dummyjson.com/';

  Future <ProductModel> getRequest(String route)async{
    String url=_baseURL+route;

    try{
      print(",,,,,,,,,,,,,,,,,,,,,,,,,,");
      Response response=await get(Uri.parse(url));
      print('............................');
      print(response.statusCode);
      if(response.statusCode==200|| response.statusCode==201){
        return ProductModel.fromJson(jsonDecode(response.body));
      }else{
        throw Exception();
      }
    }catch(ex){
      print(ex);
      throw Exception(ex);
    }
  }
}