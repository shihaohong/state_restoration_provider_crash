# hot_reload_crash

To reproduce the crash:

- Run the Flutter application
- Make any changes to the code in your IDE
- Hot Reload

After following the steps above, the following error message appears and the app crashes:

```bash
Unhandled exception:
root::package:hot_reload_crash/main.dart::_RestorableCounterState::@methods::package:flutter/src/widgets/restoration.dart::_debugAssertNotDisposed is already bound
#0      CanonicalName.bindTo (package:kernel/canonical_name.dart:192:7)
#1      Class.computeCanonicalNames (package:kernel/ast.dart:1201:51)
#2      Library.computeCanonicalNames (package:kernel/ast.dart:559:14)
#3      Component.computeCanonicalNamesForLibrary (package:kernel/ast.dart:10821:13)
#4      Component.computeCanonicalNames (package:kernel/ast.dart:10783:7)
#5      sortComponent (package:vm/kernel_front_end.dart:679:13)

#6      FrontendCompiler.writeDillFile (package:frontend_server/frontend_server.dart:656:5)
#7      FrontendCompiler.recompileDelta (package:frontend_server/frontend_server.dart:766:13)
```
