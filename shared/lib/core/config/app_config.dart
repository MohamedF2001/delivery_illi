enum AppFlavor { client, livreur, pointIllico, admin }

AppFlavor currentFlavor = AppFlavor.client;
const bool kDemoMode = false;

class AppConfig {
  //static const String baseUrl = 'https://illico-delivery.vercel.app/api';
  //static const String baseUrl = 'http://localhost:3000/api';
  static const String baseUrl = 'http://10.0.2.2:3000/api';
  static const String socketUrl = 'https://illico-delivery.vercel.app';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const double cashBlocageSeuil = 50000;
  static const int missionTimeoutSeconds = 30;
  static const double stockageTarifJour = 200;
}
