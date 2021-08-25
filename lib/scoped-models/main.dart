import 'package:gebeta_food/scoped-models/all_models.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with AllModels, UserModel, RestaurantModel, ItemModel{
}