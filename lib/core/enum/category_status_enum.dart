enum CategoryStatus { active, inactive }

extension CategoryStatusX on CategoryStatus {
  String getValue({bool isThai = false}) {
    if (isThai) {
      switch (this) {
        case CategoryStatus.active:
          return "ใช้งาน";
        case CategoryStatus.inactive:
          return "ไม่ใช้งาน";
      }
    }else{
      switch (this) {
      case CategoryStatus.active:
        return "ACTIVE";
      case CategoryStatus.inactive:
        return "INACTIVE";
    }
    }
  }

  static CategoryStatus fromString(String value) {
    switch (value) {
      case "ACTIVE":
      case "ใช้งาน":
        return CategoryStatus.active;
      case "INACTIVE":
      case "ไม่ใช้งาน":
        return CategoryStatus.inactive;
      default:
        throw ArgumentError("Invalid CategoryStatus: $value");
    }
  }
}
