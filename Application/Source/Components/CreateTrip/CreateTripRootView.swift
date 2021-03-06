//
//  CreateTripRootView.swift
//  TravelPlanner
//
//  Created by Tadeáš Kříž on 04/09/16.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Reactant
import RxSwift

import IQKeyboardManagerSwift

enum CreateTripAction {
    case selectDestination
    case beginDate(Date)
    case endDate(Date)
    case commentText(String)
}

final class CreateTripRootView: ViewBase<Trip, CreateTripAction> {

    override var actions: [Observable<CreateTripAction>] {
        return [
            destinationButtonOverlay.rx.tap.rewrite(with: .selectDestination),
            Observable.of(beginDatePicker.rx.date.skip(1).asObservable(), beginOverrideSubject).merge()
                .map(CreateTripAction.beginDate),
            Observable.of(endDatePicker.rx.date.skip(1).asObservable(), endOverrideSubject).merge()
                .map(CreateTripAction.endDate),
            comment.rx.text.replaceNilWith("").skip(1).map(CreateTripAction.commentText),
        ]
    }

    private let mode: CreateTripControllerMode

    let destination = UITextField().styled(using: Styles.textField)
    let destinationButtonOverlay = UIButton()

    private let beginOverrideSubject = PublishSubject<Date>()
    let begin = UITextField().styled(using: Styles.textField)
    private let beginToolbar = IQToolbar()

    private let endOverrideSubject = PublishSubject<Date>()
    let end = UITextField().styled(using: Styles.textField)
    private let endToolbar = IQToolbar()

    let comment = UITextView().styled(using: Styles.comment)

    private let beginDatePicker = UIDatePicker().styled(using: Styles.datePicker)
    private let endDatePicker = UIDatePicker().styled(using: Styles.datePicker)

    let placeholderLabel = UILabel().styled(using: Styles.commentPlaceholder)

    init(mode: CreateTripControllerMode) {
        self.mode = mode
        super.init()
    }

    override func update() {
        destination.text = componentState.destination?.fullAddress
        begin.text = componentState.begin?.string(dateStyle: .medium, timeStyle: .none)
        end.text = componentState.end?.string(dateStyle: .medium, timeStyle: .none)

        beginDatePicker.setDate(componentState.begin ?? Date(), animated: true)
        endDatePicker.setDate(componentState.end ?? componentState.begin ?? Date(), animated: true)

        beginDatePicker.minimumDate = mode == .create ? Date().startOf(component: .day) : nil
        endDatePicker.minimumDate = componentState.begin

        // Only set comment text when it changed, otherwise it keeps putting cursor at the end of the textView.
        if comment.text != componentState.comment {
            comment.text = componentState.comment
        }

        placeholderLabel.isHidden = comment.text.isNotEmpty

        renderKeyboardToolbars()
    }

    private func renderKeyboardToolbars() {
        let doneButton = IQBarButtonItem(title: L10n.Common.done, style: .done) { [weak self] in
            self?.endEditing(true)
        }
        let flexibleSpace = IQBarButtonItem(barButtonSystemItem: .flexibleSpace)
        
        if let beginDate = componentState.begin, beginDate == Date() {
            beginToolbar.items = [flexibleSpace, doneButton]
        } else {
            let todayButton = IQBarButtonItem(title: L10n.Trip.Create.today, style: .plain)
            beginToolbar.items = [todayButton, flexibleSpace, doneButton]

            todayButton.rx.tap
                .rewrite(with: Date())
                .subscribe(onNext: { [beginOverrideSubject] in
                    beginOverrideSubject.onNext($0)
                })
                .disposed(by: stateDisposeBag)
        }

        if let beginDate = componentState.begin,
            let endDate = componentState.end, beginDate == endDate {

            endToolbar.items = [flexibleSpace, doneButton]
        } else if let begin = componentState.begin {
            let oneDayTripButton = IQBarButtonItem(title: L10n.Trip.Create.oneDayTrip, style: .plain)
            endToolbar.items = [oneDayTripButton, flexibleSpace, doneButton]

            oneDayTripButton.rx.tap
                .rewrite(with: begin)
                .subscribe(onNext: { [endOverrideSubject] in
                    endOverrideSubject.onNext($0)
                })
                .disposed(by: stateDisposeBag)
        } else {
            let todayButton = IQBarButtonItem(title: L10n.Trip.Create.today, style: .plain)
            endToolbar.items = [todayButton, flexibleSpace, doneButton]

            todayButton.rx.tap
                .rewrite(with: Date())
                .subscribe(onNext: { [endOverrideSubject] in
                    endOverrideSubject.onNext($0)
                })
                .disposed(by: stateDisposeBag)
        }
    }

    override func loadView() {
        destination.isEnabled = false
        destinationButtonOverlay.accessibilityLabel = L10n.Trip.Create.selectDestination
        destination.placeholder = L10n.Trip.destination
        begin.accessibilityLabel = L10n.Trip.begin
        begin.placeholder = L10n.Trip.begin
        end.accessibilityLabel = L10n.Trip.end
        end.placeholder = L10n.Trip.end

        begin.inputView = beginDatePicker
        begin.inputAccessoryView = beginToolbar
        end.inputView = endDatePicker
        end.inputAccessoryView = endToolbar

        comment.text = L10n.Trip.comment
        comment.accessibilityLabel = L10n.Trip.comment
    }

    func setBeginToToday() {
        beginOverrideSubject.onNext(Date())
    }

    func setEndToToday() {
        endOverrideSubject.onNext(Date())
    }

    func setEndToBegin() {
        guard let begin = componentState.begin else { return }
        endOverrideSubject.onNext(begin)
    }

    func closeKeyboard() {
        endEditing(true)
    }
}

extension CreateTripRootView {
    fileprivate struct Styles {
        static func textField(textField: UITextField) {
            textField.font = Fonts.displayLight(size: 16)
        }

        static func datePicker(datePicker: UIDatePicker) {
            datePicker.datePickerMode = .date
        }

        static func comment(textView: UITextView) {
            textView.backgroundColor = .clear
            textView.font = Fonts.displayLight(size: 16)
            textView.textContainer.lineFragmentPadding = 0
            textView.textContainerInset = UIEdgeInsets.zero
            textView.isScrollEnabled = false
        }

        static func commentPlaceholder(label: UILabel) {
            label.textColor = Colors.faded
            label.font = Fonts.displayLight(size: 16)
        }
    }
}
