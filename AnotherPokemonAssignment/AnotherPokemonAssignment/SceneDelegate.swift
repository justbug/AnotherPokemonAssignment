//
//  SceneDelegate.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = getRootViewController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

private extension SceneDelegate {
    func getRootViewController() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [getListViewControllerWithNav(), getFavoriteCollectionViewControllerWithNav()]
        return tabBarController
    }

    func getListViewControllerWithNav() -> UINavigationController {
        let title = "List"
        let useCase = ListUseCase(listService: ListService())
        let vc = ListViewController(viewModel: ListViewModel(title: title, listUseCase: useCase))
        vc.tabBarItem = makeTabBarItem(
            title: title,
            image: UIImage(systemName: "list.bullet.rectangle.portrait"),
            selectedImage: UIImage(systemName: "list.bullet.rectangle.portrait.fill")
        )
        return UINavigationController(rootViewController: vc)
    }

    func getFavoriteCollectionViewControllerWithNav() -> UINavigationController {
        let title = "Favorite"
        let useCase = FavoriteListUseCase(store: UserDefaultsStore())
        let vc = ListViewController(viewModel: ListViewModel(title: title, listUseCase: useCase))
        vc.tabBarItem = makeTabBarItem(
            title: title,
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        return UINavigationController(rootViewController: vc)
    }

    func makeTabBarItem(title: String, image: UIImage?, selectedImage: UIImage?) -> UITabBarItem {
        let tabBarItem = UITabBarItem()
        tabBarItem.title = title
        tabBarItem.image = image
        tabBarItem.selectedImage = selectedImage
        return tabBarItem
    }
}
