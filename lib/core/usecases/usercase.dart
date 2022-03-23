import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mc_crud_test/core/error_and_success/failures.dart';

abstract class UseCase<Type,Params>{
  Future<Either<Failure,Type>?> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}