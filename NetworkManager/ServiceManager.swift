import Foundation

protocol ServiceManagerProtocol {
    func callService<T: Decodable>(endpoint: Endpoint, success: @escaping ((T) -> Void), fail: @escaping ((HTTPError) -> Void))
}

class ServiceManager: ServiceManagerProtocol {
    
    var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func callService<T>(endpoint: Endpoint, success: @escaping ((T) -> Void), fail: @escaping ((HTTPError) -> Void)) where T : Decodable {
        
        // Adding parameters
        var urlVars = [String]()
        for (var k, var v) in endpoint.parameters {
            let characters = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
            characters.removeCharacters(in: "&")
            v = v.addingPercentEncoding(withAllowedCharacters: characters as CharacterSet)!
            k = k.addingPercentEncoding(withAllowedCharacters: characters as CharacterSet)!
            urlVars += [k + "=" + "\(v)"]
        }
        
        let parameters = (!urlVars.isEmpty ? "?" : "") + urlVars.joined(separator: "&")
        let urlString = endpoint.urlString + parameters
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = endpoint.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { data, _, error in

            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    fail(.noData)
                    return
                }
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(T.self, from: data) {
                    success(json)
                } else {
                    fail(.parsingFailed)
                }
            }
        })
        task.resume()
    }
}
