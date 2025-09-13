//
//  ContentView.swift
//  SettingsViewController
//
//  Created by Yuki Sasaki on 2025/09/12.
//

import SwiftUI
import CoreData
import UIKit

// MARK: - UIViewControllerRepresentable
struct SettingsSheet: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let settingsVC = SettingsTableViewController()
        let nav = UINavigationController(rootViewController: settingsVC)
        return nav
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

// MARK: - UITableViewController
class SettingsTableViewController: UITableViewController {
    
    // データ例
    let sectionTitles = ["フルーツ", "動物"]
    let items = [
        ["Apple", "Banana", "Cherry"],   // セクション0
        ["Dog", "Cat"]                   // セクション1
    ]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        
        // セクション0は矢印あり、セクション1はなし
        if indexPath.section == 0 {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            navigationController?.pushViewController(AppleViewController(), animated: true)
        case (0, 1):
            navigationController?.pushViewController(BananaViewController(), animated: true)
        case (1, 0):
            navigationController?.pushViewController(DogViewController(), animated: true)
        case (1, 1):
            navigationController?.pushViewController(CatViewController(), animated: true)
        default:
            break
        }
    }
}

// MARK: - SwiftUI View
struct ContentView: View {
    @State private var showSheet = false

    var body: some View {
        Button("設定を開く") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            SettingsSheet()
        }
        .padding()
    }
}

// MARK: - App
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



import UIKit

class AppleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        title = "🍎 Apple"
    }
}

class BananaViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = "🍌 Banana"
    }
}

class DogViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        title = "🐶 Dog"
    }
}

class CatViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        title = "🐱 Cat"
    }
}
