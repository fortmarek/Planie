//
//  TripTableRootView.swift
//  TravelPlanner
//
//  Created by Tadeáš Kříž on 04/09/16.
//  Copyright © 2017 Brightify. All rights reserved.
//


import Reactant
import RxSwift

final class TripTableRootView: ViewBase<[Trip], PlainTableViewAction<TripCell>> {

    let tableView: PlainTableView<TripCell> = PlainTableView(cellFactory: TripCell.init, reloadable: false)

    override var actions: [Observable<PlainTableViewAction<TripCell>>] {
        return tableView.actions 
    }

    override func afterInit() {
        tableView.rowHeight = TripCell.height
        tableView.separatorStyle = .none
        tableView.tableView.tableFooterView = UIView() //this line makes searchbarwrapper disappear
        tableView.tableView.contentInset.bottom = 8
    }
}
