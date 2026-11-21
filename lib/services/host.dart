import 'dart:io' show Platform;


bool get onAndroid => Platform.isAndroid;

bool get onIOS => false;

bool get onMobile => onAndroid;
