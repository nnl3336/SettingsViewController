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

    let items = ["詳細画面1", "詳細画面2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "設定"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = UIViewController()
        vc.view.backgroundColor = (indexPath.row == 0) ? .systemGreen : .systemBlue
        vc.title = items[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)
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

