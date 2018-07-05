//
//  ViewController.swift
//  mr.gebrail
//
//  Created by Zyad Galal on 7/3/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import GoogleMaps
import SVProgressHUD
import Alamofire
import Foundation
class ViewController: UIViewController ,GMSMapViewDelegate{
    //an array for all capitals names , lat ,lng
    let capitals = [ "Kabul","Tiranë (Tirana)","El Djazaïr (Algiers)","Pago Pago","Andorra la Vella","Luanda","The Valley","St. John's","Buenos Aires","Yerevan","Oranjestad","Canberra","Wien (Vienna)","Baku","Nassau","Al-Manamah (Manama)","Dhaka","Bridgetown","Minsk","Bruxelles-Brussel","Belmopan","Cotonou","Porto-Novo","Hamilton","Thimphu","La Paz","Sucre","Sarajevo","Gaborone","Brasília","Road Town","Bandar Seri Begawan","Sofia","Ouagadougou","Bujumbura","Praia","Phnum Pénh (Phnom Penh)","Yaoundé","Ottawa-Gatineau","Kralendijk","George Town","Bangui","N'Djaména","St. Helier","St. Peter Port","Santiago","Beijing","Hong Kong","Macao","Bogotá","Moroni","Brazzaville","Rarotonga","San José","Abidjan","Yamoussoukro","Zagreb","Havana","Willemstad","Lefkosia (Nicosia)","Praha (Prague)","P'yongyang","Kinshasa","Copenhagen","Djibouti","Roseau","Santo Domingo","Quito","Cairo","San Salvador","Malabo","Asmara","Tallinn","Addis Ababa","Stanley","Tórshavn","Suva","Helsinki","Paris","Cayenne","Papeete","Libreville","Banjul","Tbilisi","Berlin","Accra","Gibraltar","Athínai (Athens)","Nuuk (Godthåb)","St.George's","Basse-Terre","Hagåtña","Guatemala City","Conakry","Bissau","Georgetown","Port-au-Prince","Vatican City","Tegucigalpa","Budapest","Reykjavík","Delhi","Jakarta","Tehran","Baghdad","Dublin","Douglas","Jerusalem","Rome","Kingston","Tokyo","Amman","Astana","Nairobi","Tarawa","Al Kuwayt (Kuwait City)","Bishkek","Vientiane","Riga","Beirut","Maseru","Monrovia","Tarabulus (Tripoli)","Vaduz","Vilnius","Luxembourg","Antananarivo","Lilongwe","Kuala Lumpur","Male","Bamako","Valletta","Majuro","Fort-de-France","Nouakchott","Port Louis","Mamoudzou","Ciudad de México (Mexico City)","Palikir","Monaco","Ulaanbaatar","Podgorica","Brades Estate","Rabat","Maputo","Nay Pyi Taw","Windhoek","Nauru","Kathmandu","Amsterdam","s-Gravenhage (The Hague)","Nouméa","Wellington","Managua","Niamey","Abuja","Alofi","Saipan","Oslo","Masqat (Muscat)","Islamabad","Koror","Ciudad de Panamá (Panama City)","Port Moresby","Asunción","Lima","Manila","Warszawa (Warsaw)","Lisboa (Lisbon)","San Juan","Ad-Dawhah (Doha)","Seoul","Chişinău","Saint-Denis","Bucuresti (Bucharest)","Moskva (Moscow)","Kigali","Jamestown","Basseterre","Castries","Saint-Pierre","Kingstown","Apia","San Marino","São Tomé","Ar-Riyadh (Riyadh)","Dakar","Beograd (Belgrade)","Victoria","Freetown","Singapore","Philipsburg","Bratislava","Ljubljana","Honiara","Muqdisho (Mogadishu)","Bloemfontein","Cape Town","Pretoria","Juba","Madrid","Colombo","Sri Jayewardenepura Kotte","Ramallah","Al-Khartum (Khartoum)","Paramaribo","Mbabane","Stockholm","Bern","Dimashq (Damascus)","Dushanbe","Skopje","Krung Thep (Bangkok)","Dili","Lomé","Tokelau","Nuku'alofa","Port of Spain","Tunis","Ankara","Ashgabat","Cockburn Town","Funafuti","Kampala","Kyiv (Kiev)","Abu Zaby (Abu Dhabi)","London","Dodoma","Washington, D.C.","Charlotte Amalie","Montevideo","Tashkent","Port Vila","Caracas","Hà Noi","Matu-Utu","El Aaiún","Sana'a'","Lusaka","Harare","Ottawa","Buenos Aires","Brasília"];
    
    let lat = ["34.53","41.33","36.75","-14.28","42.51","-8.84","18.22","17.12","-34.61","40.18","12.52","-35.28","48.21","40.38","25.06","26.22","23.71","13.10","53.90","50.85","17.25","6.37","6.50","32.29","27.47","-16.50","-19.03","43.85","-24.65","-15.78","18.42","4.94","42.70","12.36","-3.38","14.92","11.56","3.87","45.42","12.15","19.29","4.36","12.11","49.19","49.46","-33.46","39.91","22.28","22.20","4.61","-11.70","-4.27","-21.23","9.93","5.35","6.82","45.81","23.12","12.11","35.16","50.09","39.03","-4.33","55.68","11.59","15.30","18.49","-0.23","30.04","13.69","3.75","15.33","59.44","9.02","-51.70","62.01","-18.14","60.17","48.85","4.93","-17.53","0.39","13.45","41.69","52.52","5.56","36.14","37.95","64.18","12.06","16.00","13.48","14.61","9.57","11.86","6.80","18.54","41.90","14.08","47.50","64.14","28.67","-6.21","35.69","33.34","53.33","54.15","31.77","41.89","18.00","35.69","31.96","51.18","-1.28","1.33","29.35","42.87","17.97","56.95","33.90","-29.32","6.30","32.88","47.14","54.69","49.61","-18.91","-13.97","3.14","4.17","12.65","35.90","7.09","14.61","18.09","-20.16","-12.78","19.43","6.92","43.73","47.91","42.44","16.79","34.01","-25.97","19.75","-22.56","-0.53","27.70","52.37","52.08","-22.28","-41.29","12.13","13.51","9.06","-19.06","15.21","59.91","23.61","33.70","7.34","9.00","-9.44","-25.30","-12.04","14.60","52.23","38.72","18.47","25.27","37.57","47.01","-20.88","44.43","55.75","-1.95","-15.94","17.29","14.01","46.77","13.16","-13.83","43.93","0.34","24.69","14.69","44.82","-4.62","8.48","1.29","18.03","48.15","46.05","-9.43","2.04","-29.12","-33.93","-25.74","4.85","40.42","6.93","6.90","31.90","15.55","5.87","-26.32","59.33","46.95","33.51","38.54","42.00","13.72","-8.56","6.14","-9.38","-21.14","10.67","36.82","39.92","37.95","21.46","-8.52","0.32","50.45","24.46","51.51","-6.17","38.90","18.34","-34.83","41.26","-17.73","10.49","21.02","-13.28","27.15","15.35","-15.41","-17.83","45.41117","-34.61315","-15.77972"];
    let lng = ["69.17","19.82","3.04","-170.70","1.52","13.23","63.06","61.85","58.40","44.51","-70.03","149.13","16.37","49.89","-77.34","50.58","90.41","59.62","27.57","4.35","88.77","2.42","2.60","64.78","89.64","-68.15","65.26","18.36","25.91","47.93","64.62","114.95","23.32","1.54","29.36","-23.51","104.92","11.52","75.70","68.27","81.37","18.55","15.04","2.10","2.54","70.65","116.40","114.19","113.55","-74.08","43.26","15.28","159.76","84.08","4.03","5.28","15.98","-82.38","68.93","33.37","14.42","125.75","15.31","12.57","43.14","61.39","69.90","78.52","31.24","-89.19","8.78","38.93","24.75","38.75","57.85","6.77","178.44","24.94","2.35","-52.33","149.57","9.45","-16.68","44.83","13.41","0.20","5.35","23.75","-51.72","61.75","61.73","144.75","-90.53","13.65","15.60","58.16","72.34","12.45","-87.21","19.04","-21.90","77.22","106.84","51.42","44.40","6.25","4.48","35.22","12.48","76.79","139.69","35.95","71.45","36.82","172.98","47.98","74.59","102.60","24.11","35.48","27.48","-10.80","13.19","9.52","25.28","6.13","47.54","33.79","101.69","73.51","8.00","14.51","171.38","61.07","15.98","57.50","45.23","99.14","158.16","7.42","106.88","19.26","62.21","6.83","32.59","96.13","17.08","166.91","85.32","4.89","4.30","166.46","174.78","-86.25","2.11","7.49","169.92","145.75","10.75","58.59","73.06","134.48","-79.52","147.18","-57.64","77.03","120.98","21.01","9.14","66.11","51.52","126.98","28.86","55.45","26.10","37.62","30.06","-5.72","62.73","60.99","56.18","61.22","171.77","12.45","6.73","46.71","-17.44","20.46","55.45","13.23","103.85","-63.05","17.11","14.51","159.95","45.34","26.21","18.42","28.19","31.58","3.70","79.85","79.91","35.20","32.53","55.17","31.13","18.06","7.45","36.31","68.78","21.43","100.53","125.57","1.21","-171.25","175.20","61.52","10.17","32.85","58.38","-71.14","179.20","32.58","30.52","54.36","0.13","35.74","-77.04","64.93","56.17","69.22","168.32","66.88","105.84","-176.17","13.20","44.21","28.28","31.05","-75.69812","-58.37723","-47.92972"];
    
    @IBOutlet var customInfoWindowView: UIView!
    @IBOutlet weak var cityname: UILabel!
    @IBOutlet weak var hightemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    //store all data in one array
    var capitalData = [capitalcoords()]
    
    //dictionary to store every capital data
    var capitalscoords = [String: CLPlacemark]()
    //networking url
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let API_Key = "fc7097f277fbf3febf96e992b37614d2"
    
    //------------ struct for weather data
    struct WeatherInfo : Decodable{
        var temp : Double
        var temp_min : Double
        var temp_max : Double
        
    }
    struct WeatherData :Decodable{
        var name : String
        var main : WeatherInfo
       
        }
    //------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show(withStatus: "please wait while loading some data")
        
        for var i in (0...capitals.count-1)
        {
            var data = capitalcoords(Name: capitals[i], Lat: lat[i], Lng: lng[i])
            var position = CLLocationCoordinate2DMake(Double(data.lat)!,Double(data.lng)!)
            var marker = GMSMarker(position: position)
            marker.title = data.name
            marker.map = self.view as? GMSMapView
            capitalData.append(data)
            SVProgressHUD.dismiss()
        }
        //design for info window
        //shadow
        customInfoWindowView.layer.shadowOpacity = 0.15
        customInfoWindowView.layer.shadowOffset = CGSize(width: 5 , height: 10)
        customInfoWindowView.layer.shadowRadius = 5
        customInfoWindowView.layer.cornerRadius = 5
        customInfoWindowView.layer.shadowColor = UIColor.black.cgColor
        customInfoWindowView.layer.masksToBounds = false
     }
    //---------------------INFOWINDOW ACTIONS
    //-------------- moving data to get more details in the second view controller
    @IBAction func closeInfoWindow(_ sender: Any) {
        animateout(vieww: customInfoWindowView)
    }
    @IBAction func MoreDetailsbtnClicked(_ sender: Any) {
        animateout(vieww: customInfoWindowView)
        self.performSegue(withIdentifier: "moreInfo", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var details = segue.destination as! DetailsViewController
        details.countryWeatherData = returnvalue
    }
    //--------------------------------------
    //---------------------------------------------------------
    //load view
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 1.0)
        let mapview = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapview.delegate = self
        view = mapview
    }
    //create connection to get all data about capitales
    var returnvalue = WeatherModel()
    func getCapitalData(parameters : [String:String])
    {
        
        Alamofire.request(WEATHER_URL , method: .get , parameters: parameters ).responseJSON{
            response in
            if response.result.isSuccess
            {
                print("Success")
                guard let data = response.data else {return}
               
                do
                {
                    let weatherinformation = try JSONDecoder().decode(WeatherData.self, from: data)
                    print(weatherinformation.main.temp)
                    self.returnvalue.name = weatherinformation.name
                    self.returnvalue.temp = Int(weatherinformation.main.temp - 273.15)
                    self.returnvalue.temp_max = Int(weatherinformation.main.temp_max - 273.15)
                    self.returnvalue.temp_min = Int(weatherinformation.main.temp_min - 273.15)
                    print(response)
                    
                }
                catch let jsonerror{
                }
            }
            else
            {
                print("error \(response.result.error)")
                
            }
        }
        
    }
    //------------INFO WINDOW APEARACNE
    //timer
    var timer : Timer!
    //string to save city name
    var city : String!
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //hide info window if shown
        animateout(vieww: customInfoWindowView)
        //--------------- clear labels
        clear()
        //to make marker in center
       // mapView.camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 1.0)
        let location = GMSCameraPosition.camera(withLatitude: marker.position.latitude, longitude: marker.position.longitude, zoom: 5.0)
        mapView.animate(to: location)
        // to begin networing
        let params : [String : String] = ["lat":String(marker.position.latitude),"lon":String(marker.position.longitude) , "appID" : API_Key]
        self.getCapitalData(parameters: params)
        //save lat and lng
        returnvalue.lat = marker.position.latitude
        returnvalue.lng = marker.position.longitude
        
     //timer
        if timer != nil
        {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updatedata), userInfo: nil, repeats: true)
        city = marker.title
        animateIn(vieww: customInfoWindowView)
        
        return true
    }
    @objc func updatedata(){
        if returnvalue.name != ""
        {
            cityname.text = city
            temp.text = "\(self.returnvalue.temp)°"
            hightemp.text = "H:\(self.returnvalue.temp_max)°"
            lowTemp.text = "L:\(self.returnvalue.temp_min)°"
            customInfoWindowView.layer.cornerRadius = 5
            self.view.addSubview(customInfoWindowView)
            //save name
            returnvalue.name = city
            timer.invalidate()
        }
    }
    func clear()
    {
        cityname.text = "Loading..."
        temp.text = "--°"
        hightemp.text = "H:--°"
        lowTemp.text = "L:--°"
    }
    //------------------------------------------
    //--------------INFO WINDOW ANIMATION---------
    //animation when marker click func
    func animateIn(vieww : UIView)
    {
        self.view.addSubview(vieww)
        vieww.center = self.view.center
        vieww.transform = CGAffineTransform.init(scaleX:1.3 , y:1.3)
        vieww.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            
            vieww.alpha = 1
            vieww.transform = CGAffineTransform.identity
        }
    }
    //animate when popup closed
    func animateout(vieww : UIView)
    {
        UIView.animate(withDuration: 0.3, animations: {
            vieww.transform = CGAffineTransform.init(scaleX:1.3 , y:1.3)
            vieww.alpha = 0
            
        }) { (success:Bool) in
        }
    }
}

