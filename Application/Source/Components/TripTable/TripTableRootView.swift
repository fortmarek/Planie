//
//  TripTableRootView.swift
//  TravelPlanner
//
//  Created by Tadeáš Kříž on 04/09/16.
//  Copyright © 2017 Brightify. All rights reserved.
//


import Reactant
import RxSwift

final class TripTableRootView: ViewBase<CollectionViewState<Trip>, PlainTableViewAction<TripCell>> {

    let tableView: PlainTableView<TripCell> = PlainTableView(reloadable: false)

    override var actions: [Observable<PlainTableViewAction<TripCell>>] {
        return tableView.actions 
    }

    override func update() {
        tableView.componentState = componentState
    }

    override func afterInit() {
        tableView.rowHeight = TripCell.height
        tableView.separatorStyle = .none
        tableView.tableView.tableFooterView = UIView()
        tableView.tableView.contentInset.bottom = 8
    }
}
