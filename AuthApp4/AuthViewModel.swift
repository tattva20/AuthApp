//
//  AuthViewModel.swift
//  AuthApp4
//
//  Created by Octavio Rojas on 3/1/20.
//  Copyright © 2020 Tattva. All rights reserved.
//

import Foundation
import UIKit
struct AuthViewModel {
    func setButtonState(_ button: UIButton, isEnabled: Bool) {
        if isEnabled {
            button.isEnabled = true
            button.backgroundColor = .systemPink
        } else {
            button.isEnabled = false
            button.backgroundColor = .gray
        }
    }

    func getUserUsingCredentials(username: String?, password: String?) -> User? {
        guard let user = username,
            let pass = password,
            let data = getData() else { return nil }
        let group = makeGroupFromData(data)
        return getUserIfExists(group, username: user, password: pass)
    }

    func getData() -> Data? {
        do {
            guard let path = Bundle.main.path(forResource: "userlist", ofType: "json"),
                let userGroupData = try String(contentsOfFile: path)
                    .data(using: .utf8) else { return nil }
            return userGroupData
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    func makeGroupFromData(_ data: Data?) -> UserGroup? {
        do {
            guard let jsonData = data else { return nil }
            let userGroup = try JSONDecoder().decode([User].self, from: jsonData)
            return UserGroup(users: userGroup)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    func makeUserAndGroup(userName: String?, password: String?) -> (User, UserGroup)? {
        guard let user = getUserUsingCredentials(username: userName, password: password),
        let data = getData(),
        let group = makeGroupFromData(data) else { return nil }
        return (user, group)
    }

    func getUserIfExists(_ userGroup: UserGroup?, username: String, password: String) -> User? {
        guard let group = userGroup else { return nil }
        let user = group.users.first {
            $0.username == username &&
            $0.password == password
        }
        return user
    }

    func isValidUser(user: User, group: UserGroup) -> Bool {
        return getUserIfExists(group, username: user.username, password: user.password) != nil ? true : false
    }

    func presentDetailView(rootViewController: AuthView) {
        let viewController = UIViewController()
        rootViewController.present(viewController, animated: true, completion: nil)
    }

    func presentAlertView(rootViewController: AuthView, title: String, message: String)  {
        let alertController = UIAlertController(title: title,
        message: message,
        preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .cancel, handler: nil))
        rootViewController.present(alertController, animated: true, completion: nil)
    }
}
