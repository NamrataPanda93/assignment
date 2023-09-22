
import Foundation

class Location
{
    
    var timestamp: String = ""
    var lat: Double = 0.0
    var long: Double = 0.0
    var id: Int = 0

    
    init(id:Int, timestamp:String, lat:Double, long:Double)
    {
        self.id = id
        self.timestamp = timestamp
        self.lat = lat
        self.long = long

    }
    
}
