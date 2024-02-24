import 'package:fpdart/fpdart.dart';
import 'package:instagram_assessment/config/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;