import 'package:netflixclone/core/notifiers/authentication.notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [...remoteProviders, ...localProviders];

//InDirect Providers
List<SingleChildWidget> remoteProviders = [
  ChangeNotifierProvider<AuthenticationNotifier>(
      create: (_) => AuthenticationNotifier()),
];
//Direct Providers
List<SingleChildWidget> localProviders = [];
