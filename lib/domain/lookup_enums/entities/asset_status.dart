import 'package:equatable/equatable.dart';

class AssetStatus extends Equatable {
  final String? assigned;
  final String? available;
  final String? damaged;
  final String? expired;
  final String? laptopInitiative;
  final String? missing;
  final String? returned;
  final String? stockOut;
  final String? warranty;

  const AssetStatus({
    this.assigned,
    this.available,
    this.damaged,
    this.expired,
    this.laptopInitiative,
    this.missing,
    this.returned,
    this.stockOut,
    this.warranty,
  });

  @override
  List<Object?> get props => [
    assigned,
    available,
    damaged,
    expired,
    laptopInitiative,
    missing,
    returned,
    stockOut,
    warranty,
  ];
}
