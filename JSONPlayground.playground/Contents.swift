import Foundation

let filename = "zips"
let filetype = "json"

// City information
class City {
    private var name:String
    private var state:String
    private var postal_codes=[String]()
    
    init(name:String, state:String, postal_code:String){
        self.name = name
        self.state = state
        self.postal_codes.append(postal_code)
    }
    
    func addPostalCode(postal_code:String){
        if !postal_codes.contains(postal_code){
            postal_codes.append(postal_code)
        }
    }
}

// dictionary of cities indexed by city-state
var cities = [String:City]()
// dictionary of cities indexed by zip code
var zipcodes = [String:City]()

if let path = NSBundle.mainBundle().pathForResource(filename, ofType: filetype) {
    if let data = NSData(contentsOfFile: path) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! [Dictionary<String, String>]
            for dict in json {
                if let zip = dict["postal_code"] {
                    let cityKey = "\(dict["city"]!)-\(dict["state"]!)"
                    if let city = cities[cityKey] {
                        city.addPostalCode(zip)
                        zipcodes[zip] = city
                    } else {
                        cities[cityKey] = City(name: dict["city"]!, state: dict["state"]!, postal_code:zip)
                        zipcodes[zip] = cities[cityKey]
                    }
                }
            }
        } catch {
            print(error)
        }
    } else {
        print("error loading data from \(filename).\(filetype)")
    }
} else {
    print("\(filename).\(filetype) not found")
}

// Print info for zip
func printZipCodeInfo(zip:String){
    let mapurl = "http://www.google.com/maps/place/"
    
    if let city = zipcodes[zip] {
        let cityName = city.name.stringByReplacingOccurrencesOfString(" ", withString: "")
        print("ZIP:\(zip)\nCity:\(city.name), map:\(mapurl)\(cityName)+\(city.state)+\(zip), state:\(city.state)")
    } else {
        print("Unable to find information for zipcode - \(zip)")
    }
}

printZipCodeInfo("97124")

// Print all zip codes for a city in state
func printZipCodesForCity(city:String, state:String){
    let key = "\(city.uppercaseString)-\(state.uppercaseString)"
    if let city = cities[key]{
        print("\(city.name), zip codes:\(city.postal_codes)")
    } else {
        print("\(city.uppercaseString), \(state.uppercaseString) not found")
    }
}

printZipCodesForCity("Austin", state: "Tx")
