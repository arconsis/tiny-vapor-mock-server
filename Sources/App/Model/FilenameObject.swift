import Vapor

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
        guard !path.pathComponents.isEmpty else {
            return "index.json"
        }
        
        return "\(String(path.dropFirst(1))).json"
    }
}
