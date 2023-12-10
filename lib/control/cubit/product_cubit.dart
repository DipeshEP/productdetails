import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:productlist/control/cubit/repository.dart';
import 'package:productlist/model/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial()){
    getData();
  }

    Repo repository=Repo();
    Future getData()async{
      emit(ProductLoading());
      try{
        final response=await repository.fetchData();
        print(response);
        // var name=response.firstName;
        // String lastName=response.lastName;
         List <Product> data=response.products;
        emit(ProductLoaded(data));
      }catch(ex){
        print(ex);
        throw Exception(ex);
      }
    }

}
