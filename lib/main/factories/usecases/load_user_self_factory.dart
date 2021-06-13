import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadUserSelf makeRemoteLoadUserSelf() => RemoteLoadUserSelf(
      cloudFirestore: makeCloudFirestore(),
    );
