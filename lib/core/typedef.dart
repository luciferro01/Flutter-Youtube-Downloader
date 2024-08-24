import 'package:fpdart/fpdart.dart';
import 'package:ft_yt_downloader/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
