//
//  SceneDelegate.swift
//  Lesson_3.36_6
//
//  Created by Dmitry Parhomenko on 13.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        /// 1. Инициализация и создание сцены windowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        /// 2. Инициализируем переменную window классом UIWindow в которую передаем windowScene
        /// UIWindow класс отвечающий за окна в которых размещаются UIView Controller
        window = UIWindow(windowScene: windowScene)
        /// 3. Делаем наше окно ключевым и видимым
        window?.makeKeyAndVisible()
        /// 4.  Инициализтруем стартовый  UINavigationController  в котором TackListViewController()
        window?.rootViewController = UINavigationController(rootViewController: TaskListViewController())
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

