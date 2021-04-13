//
//  OmerCounterWidget.swift
//  OmerCounterWidget
//
//  Created by Orel Zion on 12/04/2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),
                    omerDay: 15,
                    configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),
                                omerDay: 15,
                                configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate,
                                    omerDay: 15,            configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let omerDay: Int
    let configuration: ConfigurationIntent
}

struct OmerCounterWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color("WidgetBackground")
            VStack(alignment: .leading) {
                Group {
                    Text("today".localizedCapitalized)
                        .foregroundColor(.pink)
                    Text(entry.omerDay.description)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
                    
                Spacer()
                Text("יום שהם שני שבועות ויום אחד לעומר")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                Spacer()
            }.padding()
        }
    }
}

@main
struct OmerCounterWidget: Widget {
    let kind: String = "OmerCounterWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            OmerCounterWidgetEntryView(entry:entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct OmerCounterWidget_Previews: PreviewProvider {
    static var previews: some View {
        OmerCounterWidgetEntryView(entry: SimpleEntry(date: Date(),
                                                      omerDay: 15,       configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
