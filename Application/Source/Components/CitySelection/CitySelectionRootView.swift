//
//  CitySelectionRootView.swift
//  TravelPlanner
//
//  Created by Tadeáš Kříž on 03/09/16.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Reactant
import RxSwift 



final class CitySelectionRootView: ViewBase<CollectionViewState<City>, PlainTableViewAction<CityCell>> {

    let tableView: PlainTableView<CityCell> = PlainTableView()

    override var actions: [Observable<PlainTableViewAction<CityCell>>] {
        return tableView.actions
    }

    override func update() {
        tableView.componentState = componentState
    }

    override func afterInit() {
        tableView.estimatedRowHeight = CityCell.height
        tableView.footerView = UIView()
    }
}
