//
//  MovieSessionTimingChildViewController.swift
//  Movie
//
//  Created by vijay raghavan on 24/06/20.
//  Copyright © 2020 vijay raghavan. All rights reserved.
//

import UIKit
import Charts

class MovieSessionTimingChildViewController: UIViewController, ChartViewDelegate {
    
    var movieTiming: [String] = ["8:00 AM", "11:30 AM", "1:30 PM", "3:10 PM", "5:15 PM", "6:30 PM"]
    
    var movieSeatsFill: [Int] = [1, 2, 1, 3, 1, 5]
    
    let days = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    
    var date: Date = Date()
    let calendar = Calendar.current
    let monthFormatter = DateFormatter()
    let dayFormatter = DateFormatter()
    
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var bookSeatsButton: UIButton!
    
    @IBOutlet weak var movieDateText: UILabel!
    @IBOutlet weak var movieDayText: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var movieMonthText: UILabel!
    
    var parentVC: DetailedMovieViewController?
    var selectedPosition: Int = -1
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        selectedPosition = Int(entry.x)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        parentVC = parent as? DetailedMovieViewController
        barChartView.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.layer.cornerRadius = 10
        bookSeatsButton.layer.cornerRadius = 10
        bookSeatsButton.clipsToBounds = true
        
        //Get Current date
        monthFormatter.dateFormat = "MMMM"
        dayFormatter.dateFormat = "EEE"
        
        movieDateText.text = String(calendar.component(.day, from: date))
        movieDayText.text = dayFormatter.string(from: date)
        movieMonthText.text = monthFormatter.string(from: date).capitalized

        //Bar Chart Data
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false
//        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:movieTiming)
        barChartView.xAxis.labelTextColor = UIColor(ciColor: .black)
        barChartView.xAxis.granularity = 1
        barChartView.legend.enabled = false
        barChartView.scaleXEnabled = false
        barChartView.scaleYEnabled = false
        
        randomGenerateSeatFillingNumbers()
        previousButton.isEnabled = false
    }
    
    func randomGenerateSeatFillingNumbers() {
        barChartView.clear()
        
        let movieSeats = [Double.random(in: 1.0...5.0), Double.random(in: 1.0...5.0), Double.random(in: 1.0...5.0), Double.random(in: 1.0...5.0), Double.random(in: 1.0...5.0), Double.random(in: 1.0...5.0)]
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<movieTiming.count {
          let dataEntry = BarChartDataEntry(x: Double(i), y: movieSeats[i])
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: nil)
        chartDataSet.drawValuesEnabled = false
        chartDataSet.colors = [UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)]
        chartDataSet.highlightColor = UIColor(red: 0.52, green: 0.55, blue: 0.80, alpha: 1.00)
        
        
        let chartData = BarChartData(dataSet: chartDataSet)
        let barWidth = 1.0
//        let barSpace = 0.10
//        let groupSpace = 0.1
//        chartData.groupBars(fromX: 1, groupSpace: groupSpace, barSpace: barSpace)
        chartData.barWidth = barWidth
        
        barChartView.data = chartData
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func previousDayButtonClicked(_ sender: Any) {
        if let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: date) {
            date = previousDate
            movieDateText.text = String(calendar.component(.day, from: date))
            movieDayText.text = dayFormatter.string(from: date)
            movieMonthText.text = monthFormatter.string(from: date).capitalized
            
            let currentDate = Date()
            if (calendar.component(.day, from: date) == calendar.component(.day, from: currentDate)) && (calendar.component(.weekday, from: date) == calendar.component(.weekday, from: currentDate)) {
                previousButton.isEnabled = false
            }
            
            randomGenerateSeatFillingNumbers()
        }
        
    }
    
    @IBAction func nextDayButtonClicked(_ sender: Any) {
        previousButton.isEnabled = true
        if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: date) {
            date = nextDate
            movieDateText.text = String(calendar.component(.day, from: date))
            movieDayText.text = dayFormatter.string(from: date)
            movieMonthText.text = monthFormatter.string(from: date).capitalized
            
            randomGenerateSeatFillingNumbers()
        }
    }
    
    @IBAction func bookSeatsButtonClicked(_ sender: Any) {
        if selectedPosition != -1 {
            if let parent = parentVC {
                parent.selectedTiming = "TIME: \(movieTiming[selectedPosition])"
                parent.selectedDate = "DATE: \(String(calendar.component(.day, from: date))).\(String(calendar.component(.month, from: date))).\(String(calendar.component(.year, from: date)))"
                parent.changeToTicketBookingVC()
            }
        }
    }
}
