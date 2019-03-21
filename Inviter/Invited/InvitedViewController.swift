//
//  InvitedViewController.swift
//  Inviter
//
//  Created by Lucas Salton Cardinali on 20/03/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import UIKit

final class InvitedViewController: UIViewController {

    let repository: CustomerRepository
    let invitedView = InvitedView.loadFromNib()
    let hqCoordinates = Coordinate(latitude: 53.339428, longitude: -6.257664)

    init(repository: CustomerRepository = CustomerRepository()) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
        title = "Invited"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = invitedView
    }

    override func viewDidLoad() {
        invitedView.setState(state: .initial)
        fetchCustomers()
    }

    func fetchCustomers() {
        repository.fetchCustomers(within: 100, from: hqCoordinates, orderedById: true) { result in
            switch result {
            case let .success(customers):
                let models = customers.map({ customer -> TitleSubtitleViewModel in
                    let distanceValue = customer.coordinates?.distanceFrom(coordinate: hqCoordinates)
                    let distanceFormated = String(format: "%.0f", distanceValue ?? 0)
                    return TitleSubtitleViewModel(title: "\(customer.userId) - \(customer.name)",
                        subtitle: "Distance: \(distanceFormated) Km")
                })
                invitedView.setState(state: .dataLoaded(models: models))
            case .failure:
                invitedView.setState(state: .errorOnLoad(message: "Couldn't load customers"))
            }
        }
    }
}
