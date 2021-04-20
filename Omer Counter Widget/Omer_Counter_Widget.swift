//
//  Omer_Counter_Widget.swift
//  Omer Counter Widget
//
//  Created by Orel Zion on 19/04/2021.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Omer_Counter_WidgetEntryView : View {
    var entry: Provider.Entry
    let omerDay: Int
    
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
            Omer_Counter_WidgetEntryView(entry: entry, omerDay: 13)
        }
        .configurationDisplayName("Day of the Omer")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct Omer_Counter_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Omer_Counter_WidgetEntryView(entry: SimpleEntry(date: Date()), omerDay: 6)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
