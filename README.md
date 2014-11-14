ios-app-crash
=============

---How to run---

1. Open project file with XCode 6 or higher. Edit the scheme to to use fences location (Product>Scheme>Edit Scheme>Options tab>Default location>Set to fences)
2. Run on iOS 7.1 device simulator to ensure location permissions are working. If you want to run on iOS8 sim, you may have to open setting on device simulator, then go to privacy, select this app, and choose always. The app will then display your lat, lon.


---What it does---

Very simple iOS app that shows the user's current location. In doing so it use CocoaLumberjack to log the location to the console. Then I have background worker to do other stuff on a seperate thread that runs every second. When it runs, it log some stuff.
When running this app, you will get EXC_BAD_ACCESS error wihin a minute in DDLog.m, inside + (void)log:(BOOL)asynchronous on line 317 (see below)
NSString *message = [[NSString alloc] initWithFormat:format arguments:args];

