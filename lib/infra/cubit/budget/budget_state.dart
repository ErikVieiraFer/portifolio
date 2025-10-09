import 'package:equatable/equatable.dart';

enum BudgetStatus { initial, loading, success, error }

class BudgetState extends Equatable {
  final BudgetStatus status;
  final String? errorMessage;

  const BudgetState({
    this.status = BudgetStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage];

  BudgetState copyWith({
    BudgetStatus? status,
    String? errorMessage,
  }) {
    return BudgetState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}