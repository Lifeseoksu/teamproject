//
//  ViewController.swift
//  team project
//
//  Created by snlcom on 6/8/24.
//

import UIKit
import CalendarKit
import EventKit

class CalenderViewController: DayViewController {
    private let eventStore = EKEventStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CPM Calender"
        requestAccessToCalender()
    }

    func requestAccessToCalender() {
        eventStore.requestAccess(to: .event) { success, error in
            
        }
    }
    
    override func eventsForDate(_ date: Date) -> [any EventDescriptor] {
        let startDate = date
        var oneDayComponents = DateComponents()
        oneDayComponents.day = 1
       
        let ewndDate = calendar.date(byAdding: oneDayComponents, to: startDate)!
        
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        
        let  eventKitEvents = eventStore.events(matching: Predicate)
        
        let calendarKitEvents = eventKitEvents.map { ekEvent -> Event in
            let ckEvent = Event()
            ckEvent.startDate = ekEvent.startDate
            ckEvent.endDate = ekEvent.endDate
            ckEvent.isAllDay = ekEvent.isAllDay
            ckEvent.text = ekEvent.title
            if let eventColor = ekEvent.calendar.cgColor {
                ckEvent.color = UIColor(cgColor: eventColor)
            }
            return ckEvent
        }
        return calendarKitEvents
    }
}

