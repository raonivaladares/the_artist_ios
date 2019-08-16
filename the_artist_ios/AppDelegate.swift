import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let appStartupRouter = AppStartupRouter(window: window)
        
        appStartupRouter.presentInitialViewController()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}

final class AppStartupRouter {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func presentInitialViewController() {
        let navigationController = UINavigationController()
        let viewController = WelcomeModuleAssembler()
            .assemble(navigationController: navigationController)
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
