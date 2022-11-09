import 'package:flutter/material.dart';

getScreenWidth(context) {
  return MediaQuery.of(context).size.width; //to get the width of screen
}

getScreenHeight(context) {
  MediaQuery.of(context).size.height; //to get height of screen
}

isSmallScreen(context) {
  if (MediaQuery.of(context).size.width < 768) {
    return true;
  } else {
    return false;
  }
}

getContentWidth(context) {
  if (isSmallScreen(context)) {
    return getScreenWidth(context) - 50;
  } else {
    return getScreenWidth(context) - 200;
  }
}
