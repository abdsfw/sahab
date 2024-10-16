// import 'failures.dart';

// class FailuresMessage {
//   FailuresMessage({required this.en, required this.failure});

//   bool en;
//   Failure failure;

//   String serverFailureMessage() {
//     return en
//         ? 'Please try again later.'
//         : "الرجاء معاودة المحاولة في وقت لاحق.";
//   }

//   String offlineFailureMessage() {
//     return en
//         ? 'Please check your internet connection'
//         : 'الرجاء التحقق من اتصال الانترنت الخاص بك';
//   }

//   String mapFailureToMessage(failure) {
//     switch (failure.runtimeType) {
//       case ServerFailure:
//         return serverFailureMessage();
//       case OfflineFailure:
//         return offlineFailureMessage();

//       default:
//         return " Unexpected error,Please try again later.";
//     }
//   }
// }
