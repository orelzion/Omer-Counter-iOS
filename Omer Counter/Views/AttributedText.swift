import SwiftUI

/// AttributedText is a way to show some HTML-tagged text in a
/// SwiftUI Text View WITHOUT using UIKit
/// Currently only the tags <b> and <i> are supported
struct AttributedText: View {
    let content: String
    
    init(_ content: String) {
        self.content = content
    }
    
    var body: some View {
        formattedWithHTML(string: content)
    }
    
    private func formattedWithHTML(string: String) -> Text {
        let data = Data("<XML>\(string.replacingOccurrences(of: "<br>", with: "\n"))</XML>".utf8)
        let parser = HTML2TextParser(data: data)
        parser.delegate = parser
        if parser.parse() {
            return parser.resultText
        }
        return Text("")
    }
}

private class HTML2TextParser: XMLParser, XMLParserDelegate {
    private var isBold = false
    private var isItalic = false
    private var color: Color? = nil
    private var isSmall = false
    private var isBig = false
    var resultText = Text("")
    
    override init(data: Data) {
        super.init(data: data)
    }
    
    private func addChunkOfText(contentText: String) {
        guard contentText != "" else {
            return
        }
        var textChunk = Text(contentText)
        textChunk = isBold ? textChunk.bold() : textChunk
        textChunk = isItalic ? textChunk.italic() : textChunk
        if(color != nil) {
            textChunk = textChunk.foregroundColor(color)
        }
        if(isSmall) {
            textChunk = textChunk.font(.footnote)
        }
        if(isBig) {
            textChunk = textChunk.font(.title2)
        }
        resultText = resultText + textChunk
    }
    
    // MARK: - Delegate methods of XMLParserDelegate -
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        if elementName.uppercased() == "B" {
            isBold = true
        } else if elementName.uppercased() == "I" {
            isItalic = true
        } else if(elementName.uppercased() == "FONT") {
            guard let hexColor = attributeDict["color"] else {
                return
            }
            color = Color(UIColor(hexColor))
        } else if(elementName.uppercased() == "SMALL") {
            isSmall = true
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName.uppercased() == "B" {
            isBold = false
        } else if elementName.uppercased() == "I" {
            isItalic = false
        } else if(elementName.uppercased() == "FONT") {
            color = nil
        } else if(elementName.uppercased() == "SMALL") {
            isSmall = false
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        addChunkOfText(contentText: string)
    }
}

struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        AttributedText(beforeOmer)
    }
}
