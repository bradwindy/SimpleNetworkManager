# SimpleNetworkManager

## Info:

A simple Swift network manager built ontop of Alamofire. Makes network requests and applying simple auth very easy.

## Example implementation:

### Custom Subclass:

```
class SomeExampleNetworkRequestManager: NetworkRequestManager {
    override var decoder: JSONDecoder {
        get {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return decoder
        }
        set {
            super.decoder = newValue
        }
    }

    override func applyAuth(headers: inout HTTPHeaders?, parameters: inout [String: Any]?) {
        headers = HTTPHeaders(["x-apikey": apiKey])
        parameters?["apikey"] = apiKey
    }

    private let apiKey = "XXXXXX"

    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "Pacific/Auckland")
        dateFormatter.locale = .autoupdatingCurrent
        return dateFormatter
    }
}
```

### Call site for Subclass:

```
let networkManager = SomeExampleNetworkRequestManager()
let response = try await networkManager.makeRequest(endpoint: "https://example.com/data", parameters: parameters)
```
