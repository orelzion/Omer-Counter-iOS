//
//  Omer_Counter_Widget.swift
//  Omer Counter Widget
//
//  Created by Orel Zion on 19/04/2021.
//

import WidgetKit
import SwiftUI
import MapKit

struct Provider: TimelineProvider {
    
    let defaults = SharedUserDefaults.create()
    
    func placeholder(in context: Context) -> OmerEntry {
        OmerEntry(date: Date(), omerDay: 1)
    }
    
    private func getSavedLocation() -> CLLocation? {
        let coordinatesArray = defaults.array(forKey: SharedUserDefaults.keys.location)
        
        guard let lat = (coordinatesArray?[0]) as? Double else {
            return nil
        }
        guard let lng = (coordinatesArray?[1]) as? Double else {
            return nil
        }
        
        return CLLocation(latitude: lat, longitude: lng)
    }
    
    private func getTimesManager(location: CLLocation) -> TimesManager {
        let timesManager = TimesManager()
        timesManager.onLocationRecevied(location: location)
        
        return timesManager
    }
    
    private func getOmerDay(hebrewDate: Date) -> Int {
        let omerManager = OmerManager()
        omerManager.onDateUpdated(hebrewDate: hebrewDate)
        return omerManager.omerDay!
    }
    
    func getSnapshot(in context: Context, completion: @escaping (OmerEntry) -> ()) {
        if let lastLocation = getSavedLocation() {
            if let hebrewDate = getTimesManager(location: lastLocation).hebrewDate {
                let omerDay = getOmerDay(hebrewDate: hebrewDate)
                
                let entry = OmerEntry(date: Date(), omerDay: omerDay)
                completion(entry)
            }
        }
        
        let entry = OmerEntry(date: Date(), omerDay: 1)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [OmerEntry] = []
        
        if let lastLocation = getSavedLocation() {
            
            let timesManager = getTimesManager(location: lastLocation)
            
            // Getting entry for now
            if let hebrewDate = timesManager.hebrewDate {
                let omerDay = getOmerDay(hebrewDate: hebrewDate)
                
                let entry = OmerEntry(date: Date(), omerDay: omerDay)
                entries.append(entry)
            }
            
            // Getting entry for tomorrow
            if let nextHebrewDate = timesManager.nextHebrewDate {
                let omerDay = getOmerDay(hebrewDate: nextHebrewDate)
                let entry = OmerEntry(date: timesManager.nextSunset!, omerDay: omerDay)
                entries.append(entry)
            }
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct OmerEntry: TimelineEntry {
    var date: Date
    let omerDay: Int
}

struct Omer_Counter_WidgetEntryView : View {
    let entry: OmerEntry
    var omerDay: Int {
        return entry.omerDay - 1
    }
    
    var body: some View {
        ZStack {
            AttributedText(getOmerForNusach())
        }.multilineTextAlignment(.center)
        .font(Font.custom("ShofarRegular", size: 18))
        .padding()
    }
    
    private func getOmerForNusach() -> String {
        switch SharedUserDefaults.create().string(forKey: SharedUserDefaults.keys.nusach) {
        case "edot":
            return OmerTexts.Edot().omerDays[omerDay]
        case "sfarad", "chabad":
            return OmerTexts.Sfarad().omerDays[omerDay]
        case "ashkenaz":
            return OmerTexts.Ashkenaz().omerDays[omerDay]
        default:
            return OmerTexts.Edot().omerDays[omerDay]
        }
    }
}

@main
struct Omer_Counter_Widget: Widget {
    let kind: String = "Omer_Counter_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Omer_Counter_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Day of the Omer")
        .description("Each day you'll see the Omer counting for today")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Omer_Counter_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Omer_Counter_WidgetEntryView(entry: OmerEntry(date: Date(), omerDay: 6))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
