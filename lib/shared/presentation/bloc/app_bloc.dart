// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../core/utils/storage/app_storage.dart';

// part 'app_event.dart';
// part 'app_state.dart';

// class AppBloc extends Bloc<AppEvent, AppState> {
//   static AppBloc get(context) => BlocProvider.of(context);

//   String appLang = 'en';

//   AppBloc() : super(AppInitial()) {
//     on<AppEvent>((event, emit) async {
//       // TODO: implement event handler

//       if (event is ChooseLangEvent) {
//         appLang = event.lang;
//         emit(ChooseLangState(lang: event.lang));
//       }

//       if (event is GetLangAppEvent) {
//         String? lang = AppLang().getLang();
//         appLang = lang ?? 'en';
//         emit(GetLangAppState(appLang: appLang));
//       }
//     });
//   }
// }
