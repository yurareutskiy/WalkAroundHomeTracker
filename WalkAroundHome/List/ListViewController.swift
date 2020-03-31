//
//  ListViewController.swift
//  100metersTracker
//
//  Created by REUTSKIY YURIY on 31.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

	lazy var tableView: UITableView = {
		let table = UITableView()
		table.registerReusable(cellClass: ItemTableViewCell.self)
		table.delegate = self
		table.dataSource = self
		table.translatesAutoresizingMaskIntoConstraints = false
		return table
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		title = Constants.List.title
		navigationController?.navigationBar.prefersLargeTitles = true
		view.backgroundColor = .systemBackground
		setupTable()
	}

	private func setupTable() {
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 30
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withClass: ItemTableViewCell.self) else {
			return UITableViewCell()
		}

		cell.textLabel?.text = "Index path \(indexPath.row)"

		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50.0
	}


}
