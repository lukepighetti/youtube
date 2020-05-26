import 'package:flutter/foundation.dart';

/// Creates a sealed class & where pattern around
/// typical app data states, ie `initial`, `waiting`,
/// `error(Error)`, `data(Data)`
///
/// Helps us handle the typical states surrounding
/// app data.
class Status<D, E> {
  final D data;
  final E error;
  final StatusEnum statusEnum;

  Status({
    @required this.data,
    @required this.error,
    @required this.statusEnum,
  });

  /// A convience constructor for initial status
  Status.initial()
      : error = null,
        data = null,
        statusEnum = StatusEnum.initial;

  /// A convience constructor for waiting status
  Status.waiting()
      : error = null,
        data = null,
        statusEnum = StatusEnum.waiting;

  /// A convience constructor for error status
  Status.error(this.error)
      : data = null,
        statusEnum = StatusEnum.error;

  /// A convience constructor for data status
  Status.data(this.data)
      : error = null,
        statusEnum = StatusEnum.data;

  R where<R>({
    @required R Function() onInitial,
    @required R Function() onWaiting,
    @required R Function(E) onError,
    @required R Function(D) onData,
  }) {
    switch (statusEnum) {
      case StatusEnum.initial:
        return onInitial?.call();

      case StatusEnum.waiting:
        return onWaiting?.call();

      case StatusEnum.error:
        return onError?.call(error);

      case StatusEnum.data:
        return onData?.call(data);

      default:
        throw StateError("statusEnum must not be null");
    }
  }
}

/// The typical states for app data
enum StatusEnum { initial, waiting, error, data }
