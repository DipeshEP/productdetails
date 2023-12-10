import 'package:http/http.dart';
import 'package:productlist/model/api_helper.dart';

import '../../model/product_model.dart';

class Repo{
  Future<ProductModel> fetchData()async{
    const route='products';
    var response=await ApiHelper.internal().getRequest(route);
    return response;
  }
}