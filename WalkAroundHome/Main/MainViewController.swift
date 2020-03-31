//
//  ViewController.swift
//  100metersTracker
//
//  Created by REUTSKIY YURIY on 30.03.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	let geolocationManager: GeolocationManagerProtocol = GeolocationManager()

	var isActiveTracking: Bool = false {
		didSet {
			startTrackButton.setEnabled(!isActiveTracking)
			stopTrackButton.setEnabled(isActiveTracking)
		}
	}

	lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.defaultTextFont
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	lazy var distanceLabel: UILabel = {
		let label = UILabel()
		label.text = Constants.Texts.defaultDistanceTitle
		label.font = UIFont.headlineFont
		label.textColor = UIColor.placeholderText
		label.adjustsFontSizeToFitWidth = true
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	lazy var homeButton: ActionButton = {
		ActionButton(defaultText: Constants.Texts.homeCoordinateButton)
	}()

	lazy var startTrackButton: ActionButton = {
		ActionButton(defaultText: Constants.Texts.startTrackingButton)
	}()

	lazy var stopTrackButton: ActionButton = {
		ActionButton(defaultText: Constants.Texts.stopTrackingButton)
	}()

	lazy var buttonContainer: UIView = {
		let buttonContainer = UIView()
		buttonContainer.translatesAutoresizingMaskIntoConstraints = false
		return buttonContainer
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		title = Constants.Texts.mainScreenTitle
		navigationItem.title = Constants.Texts.mainScreenNavigationBarTitle
		isActiveTracking = false
		navigationController?.navigationBar.prefersLargeTitles = true
		view.backgroundColor = .systemBackground
		setupButtonsView()
		setupDescriptionLabel()
		setupDistanceLabel()
	}

	private func setupButtonsView() {
		view.addSubview(buttonContainer)

		let height = Constants.Layout.defaultMargin * 2 + Constants.Layout.buttonHeight * 3
		NSLayoutConstraint.activate([
			buttonContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			buttonContainer.heightAnchor.constraint(equalToConstant: height),
			buttonContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			buttonContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
		])

		view.addSubview(homeButton)
		view.addSubview(startTrackButton)
		view.addSubview(stopTrackButton)

		setupHomeButton()
		setupStartTrackingButton()
		setupStopTrackingButton()
	}

	private func setupHomeButton() {
		NSLayoutConstraint.activate([
			homeButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor,
												constant: Constants.Layout.defaultMargin),
			homeButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
			homeButton.bottomAnchor.constraint(equalTo: startTrackButton.topAnchor,
											   constant: -Constants.Layout.defaultMargin),
			homeButton.heightAnchor.constraint(equalTo: startTrackButton.heightAnchor),
			homeButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor,
												 constant: -Constants.Layout.defaultMargin)
		])
		homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
	}

	private func setupStartTrackingButton() {
		NSLayoutConstraint.activate([
			startTrackButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor,
													  constant: Constants.Layout.defaultMargin),
			startTrackButton.bottomAnchor.constraint(equalTo: stopTrackButton.topAnchor,
													 constant: -Constants.Layout.defaultMargin),
			startTrackButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor,
													   constant: -Constants.Layout.defaultMargin)
		])
		startTrackButton.addTarget(self, action: #selector(startTrackButtonTapped), for: .touchUpInside)
	}

	private func setupStopTrackingButton() {
		NSLayoutConstraint.activate([
			stopTrackButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor,
													 constant: Constants.Layout.defaultMargin),
			stopTrackButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor),
			stopTrackButton.heightAnchor.constraint(equalTo: startTrackButton.heightAnchor),
			stopTrackButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor,
													  constant: -Constants.Layout.defaultMargin)
		])
		stopTrackButton.addTarget(self, action: #selector(stopTrackButtonTapped), for: .touchUpInside)
	}

	private func setupDescriptionLabel() {
		view.addSubview(descriptionLabel)
		NSLayoutConstraint.activate([
			descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
													  constant: Constants.Layout.defaultMargin),
			descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			descriptionLabel.topAnchor.constraint(equalTo: buttonContainer.bottomAnchor,
												  constant: Constants.Layout.defaultMargin * 2)
		])
		descriptionLabel.text = Constants.Texts.description
	}

	private func setupDistanceLabel() {
		view.addSubview(distanceLabel)

		NSLayoutConstraint.activate([
			distanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			distanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
												   constant: Constants.Layout.defaultMargin),
			distanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
													constant: -Constants.Layout.defaultMargin),
			distanceLabel.bottomAnchor.constraint(equalTo: buttonContainer.topAnchor,
												  constant: -Constants.Layout.defaultMargin * 2)
		])

		geolocationManager.setDistanceUpdate { [unowned self] distance in
			self.distanceLabel.text = "~\(Int(distance)) метров"
		}
	}

	@objc private func homeButtonTapped() {
		geolocationManager.determineHomeCoordinate { [unowned self]  determined in
			if determined {
				self.showAlertController(withText: "Определили координаты!", message: "Теперь можно начинать трекать перемещения вокруг дома.")
			} else {
				self.showAlertController(withText: "Ошибка!", message: "Не смогли определить координаты, проверьте настройки.")
			}
		}
	}

	@objc private func startTrackButtonTapped() {
		if geolocationManager.homeLocationDeterminated {
			activateTracking()
		} else {
			self.showAlertController(withText: "Ошибка!", message: "Не смогли определить координаты, проверьте настройки.")
		}
	}

	private func activateTracking() {
		isActiveTracking = true
		geolocationManager.startMonitoring { exited in
			self.showAlertController(withText: "🚨🚨🚨", message: "Вы вышли за пределы дома!")
		}
	}

	@objc private func stopTrackButtonTapped() {
		isActiveTracking = false
		geolocationManager.stopMonitoring()
	}
}

