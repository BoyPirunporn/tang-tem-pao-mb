enum BalanceType {
  asset,
  liability
}

extension BalanceTypeX on BalanceType {
  String getValue({bool isThai = false}){
   if(isThai){
    switch (this) {
      case BalanceType.asset:
        return "ทรัพท์สิน";
      case BalanceType.liability:
        return "หนี้สิน";
    }

   }
   switch (this) {
      case BalanceType.asset:
        return "ASSET";
      case BalanceType.liability:
        return "LIABILITY";
    }
  }
  static BalanceType formString(String type){
    switch (type) {
      case 'ASSET':
      case 'ทรัพท์สิน':
        return BalanceType.asset;
      case 'LIABILITY':
      case 'หนี้สิน':
        return BalanceType.liability;
      default:
        throw ArgumentError("Invalid BalanceType $type");
    }
  }
}