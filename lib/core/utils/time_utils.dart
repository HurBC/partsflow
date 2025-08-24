String getElapsedTime(String datetime) {
  var stringTime = DateTime.parse(datetime);
  var now = DateTime.now();

  var subtractedDate = now.difference(stringTime);

  if (subtractedDate.inHours < 0) {
    return "Hace ${subtractedDate.inMinutes} minutos";
  } else if (subtractedDate.inDays < 0) {
    return "Hace ${subtractedDate.inHours} horas";
  } else {
    return "Hace ${subtractedDate.inDays} dias";
  }
}
