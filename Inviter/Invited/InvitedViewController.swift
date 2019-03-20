//
//  InvitedViewController.swift
//  Inviter
//
//  Created by Lucas Salton Cardinali on 20/03/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import UIKit

final class InvitedViewController: UIViewController {

    init(repository: CustomerRepository = CustomerRepository()) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
        title = "Invited"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let repository: CustomerRepository
    let invitedView = InvitedView.loadFromNib()

    override func loadView() {
        self.view = invitedView
    }

    override func viewDidLoad() {
        repository.fetchCustomers { result in
            switch result {
            case let .success(customers):
                let intercomCoordinates = Coordinate(latitude: 53.339428, longitude: -6.257664)

                let models = customers.filter({ $0.coordinates.distanceFrom(coordinate: intercomCoordinates) < 100 })
                                         .sorted(by: {$0.userId < $1.userId})
                                         .map({ customer -> TitleSubtitleViewModel in
                        let distanceValue = customer.coordinates.distanceFrom(coordinate: intercomCoordinates)
                        let distanceFormated = String(format: "%.0f", distanceValue)
                        return TitleSubtitleViewModel(title: "\(customer.userId) - \(customer.name)",
                                                      subtitle: "Distance: \(distanceFormated) Km")
                })
                invitedView.setupView(models: models)
            case let .failure(error):
                print(error)
            }
        }
    }

}
