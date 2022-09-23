import Vapor
import RoutingKit

struct FilenameObject {
    let path: String
    let query: String?
    
    init(with url: URI) {
        path = url.path
        query = url.query
    }
    
    var sourcePath: String {
        
        // path = "/" -> "index.json"
        // path
        // path/to/amount/10/page/1/file.json
        let sourcePath = "\(filePath)\(fileName)"
        print("###: \(sourcePath)")
        return sourcePath
    }
    
    private var fileName: String {
        let filename = path.pathComponents.last ?? "index"
        return "\(filename).json"
    }
    
    private var filePath: String {
        return "\(pathComponentFilePath)\(queryFilePath)"
    }
    
    private var pathComponentFilePath: String {
        guard !path.pathComponents.isEmpty else {
            return ""
        }
        
        let pathComponents = path.pathComponents.dropLast()
        let stringComponents = pathComponents.map{ String($0.description) }
        
        var pathPart = stringComponents.joined(separator: "/")
        if pathPart.isEmpty {
            return ""
        } else {
            return "\(pathPart)/"
        }
    }
    
    private var queryFilePath: String {
        guard let query = query, !query.isEmpty else {
            return ""
        }
        let dict = query.toDictionary()
        var queryPath = ""
        dict.keys
            .sorted()
            .forEach{ key in
            if let value = dict[key] {
                queryPath.append("\(key)/\(value)/")
            }
        }
        
        return queryPath
    }
}

extension String {
    func toDictionary() -> Dictionary<String, String> {
        var dictionary: Dictionary<String, String> = .init()
        
        self.split(separator: "&")
            .map{ String($0) }
            .forEach{
                let keyValue = $0.split(separator: "=").map{ String($0) }
                guard
                    keyValue.count == 2,
                    let key = keyValue.first,
                    let value = keyValue.last
                else { return }
                      
                dictionary[key] = value
            }
        
        return dictionary
    }
}
