enum TransactionType { all, income, expense, saving }

extension TransactionTypeX on TransactionType {
  String getValue({bool isThai = false}) {
    if (isThai) {
      switch (this) {
        case TransactionType.income:
          return "รายรับ";
        case TransactionType.expense:
          return "รายจ่าย";
        case TransactionType.saving:
          return "เงินออม";
        case TransactionType.all:
          return "ทั้งหมด";
      }
    } else {
      switch (this) {
        case TransactionType.income:
          return "INCOME";
        case TransactionType.expense:
          return "EXPENSE";
        case TransactionType.saving:
          return "SAVING";
        case TransactionType.all:
          return "ALL";
      }
    }
  }

  static TransactionType fromString(String value) {
    switch (value.toUpperCase()) {
      case "INCOME":
      case "รายรับ":
        return TransactionType.income;
      case "EXPENSE":
      case "รายจ่าย":
        return TransactionType.expense;
      case "SAVING":
      case "เงินออม":
        return TransactionType.saving;
      case "ALL":
      case "ทั้งหมด":
        return TransactionType.all;
      default:
        throw ArgumentError("Invalid TransactionType: $value");
    }
  }
}
