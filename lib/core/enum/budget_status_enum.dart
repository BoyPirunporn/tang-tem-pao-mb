enum BudgetStatus { active, complete }

extension BudgetStatusX on BudgetStatus {
  String getValue({bool isThai = false}) {
    if (isThai) {
      switch (this) {
        case BudgetStatus.active:
          return "ใช้งานอยู่";
        case BudgetStatus.complete:
          return "เป้าหมายสำเร็จแล้ว";
      }
    }else{
      switch (this) {
        case BudgetStatus.active:
          return "ACTIVE";
        case BudgetStatus.complete:
          return "COMPLETE";
      }
    }
  }
  
  static BudgetStatus formString(String status){
    switch (status) {
      case 'ACTIVE':
      case 'ใช้งานอยู่':
        return BudgetStatus.active;
      case 'COMPLETE':
      case 'เป้าหมายสำเร็จแล้ว':
        return BudgetStatus.complete;
      default:
        throw ArgumentError("Invalid BudgetStatus $status");
    }
  }
}
