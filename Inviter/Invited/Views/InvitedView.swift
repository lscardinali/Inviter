//
//  InvitedView.swift
//  Inviter
//
//  Created by Lucas Salton Cardinali on 20/03/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import Reusable

enum InvitedViewState {
    case initial
    case dataLoaded(models: [TitleSubtitleViewModel])
    case errorOnLoad(message: String)
}

final class InvitedView: UIView, NibLoadable {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var models: [TitleSubtitleViewModel] = []

    func setState(state: InvitedViewState) {
        switch state {
        case .initial:
            statusLabel.isHidden = true
            tableView.isHidden = true
        case let .dataLoaded(models):
            if models.isEmpty {
                statusLabel.text = "No customers found in range"
                statusLabel.isHidden = false
                tableView.isHidden = true
            } else {
                statusLabel.isHidden = true
                tableView.isHidden = false
                self.models = models
                if tableView.dataSource != nil {
                    tableView.reloadData()
                } else {
                    tableView.dataSource = self
                }
            }
        case let .errorOnLoad(message):
            statusLabel.isHidden = false
            statusLabel.text = message
            tableView.isHidden = true
        }
    }

}

extension InvitedView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "InvitedCell") {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "InvitedCell")
        }

        let model = models[indexPath.row]

        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.subtitle

        return cell
    }
}
