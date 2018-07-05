//
//  DetailsViewController.swift
//  mr.gebrail
//
//  Created by Zyad Galal on 7/5/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
class DetailsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource{

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var forcastCollectionView: UICollectionView!
    var countryWeatherData = WeatherModel()
    var boardcast = [weatherForcast()]
    //------------------- reqiuried as parameters for networking
    var networkingURL = "https://weather.cit.api.here.com/weather/1.0/report.json"
    var appID = "DemoAppId01082013GAL"
    var appCode = "AJKnXv84fjrb0KIHawS0Tg"
    //---------------------------------------- counting label
    var timer : Timer!
    var startTimer : Int = 0
    //-----------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Loading")
        boardcast.removeAll()
        forcastCollectionView.dataSource = self
        forcastCollectionView.delegate = self
        cityName.text = countryWeatherData.name
        forcastCollectionView.backgroundColor = UIColor.clear
        //prepare for networking
        let params : [String : String] = ["product":"forecast_7days_simple","name" : countryWeatherData.name , "app_id":appID , "app_code":appCode]
        createConnection(Parameters : params)
        
    }
    

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return boardcast.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = forcastCollectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! CollectionViewCell
        cell.day.text = boardcast[indexPath.row].dayName
        cell.weatherStatus.image = boardcast[indexPath.row].imageURL
        cell.weatherTemp.text = "\(Int(boardcast[indexPath.row].lowTemp))° - \(Int(boardcast[indexPath.row].highTemp))° "
        return cell
    }
    //------------------ NETWORKING---------------------
    func createConnection(Parameters : [String:String])
    {
        Alamofire.request(networkingURL , method: .get , parameters: Parameters ).responseJSON{
            response in
            if response.result.isSuccess
            {
                print("Success")
                var JSONResult = JSON(response.result.value!)
                self.parsingJSON(json : JSONResult)
            }
            else
            {
                print("error \(response.result.error)")
                
            }
        }
    }
    func parsingJSON(json : JSON)
    {
        if let days = json["dailyForecasts"]["forecastLocation"]["forecast"].array{
            for day in days
            {
                let summary = weatherForcast()
                summary.dayName = day["weekday"].stringValue
                summary.highTemp = Double(day["highTemperature"].stringValue)
                summary.lowTemp = Double(day["lowTemperature"].stringValue)
                let path = day["iconLink"].stringValue
                let url = NSURL(string: path)
                let data = NSData(contentsOf: url! as URL)
                summary.imageURL = UIImage(data: data! as Data)
                boardcast.append(summary)
            }
            forcastCollectionView.reloadData()
            SVProgressHUD.dismiss()
            //Timer for counting label
            if timer != nil
            {
                timer.invalidate()
            }
            self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.countingLabel), userInfo: nil, repeats: true)
            
        }
    }
    
    //------------------------------------- COUNTING LABELE
    @objc func countingLabel()
    {
        if startTimer != countryWeatherData.temp+1
        {
            cityTemp.text = "\(startTimer)°"
            startTimer += 1
        }
        else
        {
            timer.invalidate()
        }
    }
    @IBAction func backClicked(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}
