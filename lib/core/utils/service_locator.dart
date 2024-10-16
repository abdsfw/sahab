import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sahab_project/core/utils/api_service.dart';
import 'package:sahab_project/feature/Bookings/data/repo/booking_repo.dart';
import 'package:sahab_project/feature/Bookings/data/repo/booking_repo_impl.dart';
import 'package:sahab_project/feature/account/data/repo/account_repo.dart';
import 'package:sahab_project/feature/account/data/repo/account_repo_impl.dart';
import 'package:sahab_project/feature/add_edit_post/data/repo/add_edit_post_repo.dart';
import 'package:sahab_project/feature/add_edit_post/data/repo/add_edit_post_repo_impl.dart';
import 'package:sahab_project/feature/auth/data/repositories/auth_repo.dart';
import 'package:sahab_project/feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:sahab_project/feature/categories/data/repo/category_repo.dart';
import 'package:sahab_project/feature/categories/data/repo/category_repo_impl.dart';
import 'package:sahab_project/feature/checkout/data/repo/checkout_repo.dart';
import 'package:sahab_project/feature/checkout/data/repo/checkout_repo_impl.dart';
import 'package:sahab_project/feature/home/data/repo/home_repo.dart';
import 'package:sahab_project/feature/home/data/repo/home_repo_impl.dart';
import 'package:sahab_project/feature/places/data/repo/place_repo.dart';
import 'package:sahab_project/feature/places/data/repo/place_repo_impl.dart';
import 'package:sahab_project/feature/reservations/data/repo/reservation_repo.dart';
import 'package:sahab_project/feature/reservations/data/repo/reservation_repo_impl.dart';
import 'package:sahab_project/feature/serach/data/repo/search_repo.dart';
import 'package:sahab_project/feature/serach/data/repo/search_repo_impl.dart';
import 'package:sahab_project/feature/services/data/repo/services_repo.dart';
import 'package:sahab_project/feature/services/data/repo/services_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: "https://caa9-89-39-104-194.ngrok-free.app/api",
      ),
    ),
  );

  getIt.registerSingleton<ApiService>(
    ApiService(
      getIt.get<Dio>(),
    ),
  );

  getIt.registerSingleton<AuthRepo>(AuthRepoImpl());
  getIt.registerSingleton<AddEditPostRepo>(AddEditPostRepoImpl());
  getIt.registerSingleton<CategoryRepo>(CategoryRepoImpl());
  getIt.registerSingleton<PlaceRepo>(PlaceRepoImpl());
  getIt.registerSingleton<ServicesRepo>(ServicesRepoImpl());
  getIt.registerSingleton<AccountRepo>(AccountRepoImpl());
  getIt.registerSingleton<SearchRepo>(SearchRepoImpl());
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl());
  getIt.registerSingleton<BookingRepo>(BookingRepoImpl());
  getIt.registerSingleton<ReservationRepo>(ReservationRepoImpl());
  getIt.registerSingleton<CheckoutRepo>(CheckoutRepoImpl());
}
