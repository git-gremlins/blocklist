import 'package:flutter/material.dart';

class FutureData<TReturn, TFuture> extends FutureBuilder<TFuture> {
  @override
  Future<TFuture> future;
  TReturn Function(TFuture snapshotData) onDataCallback;
  TReturn Function(Object? error) onErrorCallback;
  TReturn loadingValue;
  Widget Function(TReturn result) onReturnCallback;

  FutureData(
      {super.key,
      required this.future,
      required this.onDataCallback,
      required this.onReturnCallback,
      required this.onErrorCallback,
      required this.loadingValue})
      : super(
            future: future,
            builder: (context, snapshot) {
              TReturn result;
              if (snapshot.hasData) {
                result = onDataCallback(snapshot.data as TFuture);
              } else if (snapshot.hasError) {
                result = onErrorCallback(snapshot.error);
              } else {
                result = loadingValue;
              }
              return onReturnCallback(result);
            });
}
