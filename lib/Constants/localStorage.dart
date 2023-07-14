// ignore_for_file: file_names
import 'package:localstorage/localstorage.dart';

const String baseUrl = "https://tr.atrehealthtech.com/beta-atre/api-v2/admin/";

const String version = 'atre_application_desktop_0.0.2';
String? globalAccessToken;
String? globalUserID;

class CommonLocalStorage {
  // *************************** ACCESS TOKEN **************************

  // Write Token
  Future<void> saveLocalStorageToken(value) async {
    LocalStorage localStorage = LocalStorage('atre_windows');
    return await localStorage.setItem('LoginToken', value);
  }

  //Read Token

  Future readLocalStorageToken() async {
    LocalStorage localStorage = LocalStorage('atre_windows');
    return localStorage.getItem('LoginToken');
  }

  // *************************** USER ID **************************

  // Write Token
  Future<void> saveLocalStorageUserID(value) async {
    LocalStorage localStorage = LocalStorage('atre_windows');
    return await localStorage.setItem('LoginToken', value);
  }

  //Read Token

  Future readLocalStorageUserID() async {
    LocalStorage localStorage = LocalStorage('atre_windows');
    return localStorage.getItem('UserID');
  }
}
