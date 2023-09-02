//
//  DashBoardVC.swift
//  Ecommerce
//
//  Created by Hemang Solanki on 02/09/23.
//

import UIKit
import DGCharts

class DateValueFormatter: AxisValueFormatter {
    let dateFormatter = DateFormatter()
    let baseDate: Date
    
    init(baseDate: Date) {
        dateFormatter.dateFormat = "MMM yyyy"
        self.baseDate = baseDate
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        // Add month interval to base date
        
        guard let date = Calendar.current.date(byAdding: .month, value: Int(value), to: baseDate) else {
            return ""
        }
        return dateFormatter.string(from: date)
    }
}

class DashBoardVC: UIViewController, ChartViewDelegate {
    
    //    MARK: - Outlets & Variable -
    var viewModel: LoginViewModel = .init()
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet var chartView: LineChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    @IBOutlet var sliderTextY: UITextField!
    
    //    MARK: - View Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.viewHeader.applyGredientBG(colors: [UIColor.init(hexString: "#ffb73f"),UIColor.init(hexString: "#F2391A")], points: [.init(x: 0.0, y: 0.25), .init(x: 0.0, y: 0.75)], isCenter: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.hideNavigationBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //    MARK: - Init -
    
    func setupUI() {
        self.setText()
        self.setFontColors()
        self.setFonts()
        self.setChartVieW()
        self.getDashboard()
    }
    
    func setChartVieW() {
        chartView.delegate = self
        chartView.chartDescription.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 100, label: "Index 10")
        llXAxis.lineWidth = 4
        llXAxis.lineDashLengths = [10, 10, 0]
        llXAxis.labelPosition = .rightBottom
        llXAxis.valueFont = .systemFont(ofSize: 10)
        
        chartView.xAxis.gridLineDashLengths = [10, 10]
        chartView.xAxis.gridLineDashPhase = 0
        
        let ll1 = ChartLimitLine(limit: 10000, label: "Upper Limit")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .rightTop
        ll1.valueFont = .systemFont(ofSize: 10)
        
        let ll2 = ChartLimitLine(limit: 0, label: "Lower Limit")
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = .rightBottom
        ll2.valueFont = .systemFont(ofSize: 10)
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 10
        leftAxis.axisMinimum = 0
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView.rightAxis.enabled = false
        
        //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
        //[_chartView.viewPortHandler setMaximumScaleX: 2.f];
        
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
        
        chartView.legend.form = .line
        
        sliderX.value = 30
        sliderY.value = 100
        slidersValueChanged(nil)
        
        chartView.animate(xAxisDuration: 2.5)
    }
    
    @IBAction func btnLogoutTapped(_ sender: Any) {
        self.logoutPopup()
    }
    
    func setText() {
        
    }
    
    func setFontColors() {
        //        self.btnSubmit.setTitleColor(ColorConstants.Primary_color, for: .normal)
        //        self.txtEmail.placeholderColors = ColorConstants.LightGrayColor
        //        self.txtPassword.placeholderColors = ColorConstants.LightGrayColor
        //        self.txtEmail.textColor = ColorConstants.BlackColor
        //        self.txtPassword.textColor = ColorConstants.BlackColor
    }
    
    func setFonts() {
        //        self.btnSubmit.titleLabel!.font = Fonts.sharedObject().getAppFontFont(family: .Bold, size: 20)
        //        self.txtEmail.font = Fonts.sharedObject().getAppFontFont(family: .Regular, size: 14)
        //        self.txtPassword.font = Fonts.sharedObject().getAppFontFont(family: .Regular, size: 14)
    }
    
    
    func logoutPopup() {
        let refreshAlert = UIAlertController(title: "LOGOUT", message: "Are you sure you want to logout ?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if UserDefaults.standard.isUserLoggedIn() == true{
                self.getDeleteTokenAPI()
            }
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    
    
    // MARK: - API -
    
    func getDeleteTokenAPI() {
        self.viewModel.setDeleteToken {
            self.showToast(message: "You have been logged out successfully.")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                UserDefaults.standard.removeAll()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                    DispatchQueue.main.async { [self] in
                        let vc: ViewController = StoryBoardConstants.MAIN.instantiateViewController(aClass: ViewController.self)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        } failure: {
            profileResponse, responseStatus in
            if profileResponse != nil{
                if responseStatus.statusCode == 402 {
                    DispatchQueue.main.async {
                        Common.shared.hideHUD()
                    }
                }
                if profileResponse?.message == "Unauthorized"{
                    Common.shared.logout()
                }
                self.showToast(message: (profileResponse?.message)!,isMenu: true)
            }else{
                if responseStatus.statusCode == 500 {
                    self.showToast(message: "We're experiencing a temporary issue with our servers. Please try again soon.", isMenu: true)
                }else if responseStatus.statusCode == 402 {
                    DispatchQueue.main.async {
                        Common.shared.hideHUD()
                    }
                }else{
                    self.showToast(message: responseStatus.errorMessage,isMenu: true)
                }
            }
        }
    }
    
    // MARK: - API -
    
    func getDashboard() {
        self.viewModel.GetDashboard {
            self.setdata()
        } failure: {
            profileResponse, responseStatus in
            if profileResponse != nil{
                if responseStatus.statusCode == 402 {
                    DispatchQueue.main.async {
                        Common.shared.hideHUD()
                    }
                }
                if profileResponse?.message == "Unauthorized"{
                    Common.shared.logout()
                }
                self.showToast(message: (profileResponse?.message)!,isMenu: true)
            }else{
                if responseStatus.statusCode == 500 {
                    self.showToast(message: "We're experiencing a temporary issue with our servers. Please try again soon.", isMenu: true)
                }else if responseStatus.statusCode == 402 {
                    DispatchQueue.main.async {
                        Common.shared.hideHUD()
                    }
                }else{
                    self.showToast(message: responseStatus.errorMessage,isMenu: true)
                }
            }
        }
    }
    
    func updateChartData() {
        
        self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
    }
    
    func setdata() {
        // Sample data
        let dateStrings = self.viewModel.dashBoardData?.dates ?? [""]
        let yValues: [BarChartDataEntry] = dateStrings.enumerated().map { (index, dateStrings) in
            return BarChartDataEntry(x: Double(index), y: 1.0) // y value is 1.0 for simplicity
        }
        chartView.leftAxis.valueFormatter = IndexAxisValueFormatter(values: dateStrings)
        chartView.leftAxis.granularity = 1.0
        
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        
        //        let values: [ChartDataEntry] = [
        //                ChartDataEntry(x: 0.0, y: 0.0),
        //                ChartDataEntry(x: 1.0, y: 2.0),
        //                ChartDataEntry(x: 2.0, y: 3.5),
        //                // ... add more entries as needed
        //            ]
        
        //        let values = (0..<count).map { (i) -> ChartDataEntry in
        //            let val = Double(arc4random_uniform(range))
        //            print(val,"NEW VALUES")
        //            return ChartDataEntry(x: Double(i), y: val, icon: #imageLiteral(resourceName: "icon"))
        //        }
        //        let values: [ChartDataEntry] = [
        //            //... your data here. For example:
        //            ChartDataEntry(x: 1.0, y: Date().timeIntervalSince1970)
        //        ]
        //
        //
        //        let set1 = LineChartDataSet(entries: values, label: "")
        //        set1.drawIconsEnabled = false
        //        setup(set1)
        //
        //        let value = ChartDataEntry(x: Double(3), y: 3)
        //        set1.addEntryOrdered(value)
        //        let gradientColors = [ColorConstants.Primary_color!.cgColor,
        //                              ColorConstants.Secondry_color!.cgColor]
        //        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        //
        //        set1.fillAlpha = 1
        //        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        //        set1.drawFilledEnabled = true
        //
        //        let data = LineChartData(dataSet: set1)
        //
        //        chartView.data = data
        //
        //        let yAxis = chartView.leftAxis
        //        yAxis.valueFormatter = DateValueFormatter()
        
//
//        let arrayDate = self.viewModel.dashBoardData?.predictedMean ?? [0.0]
//
//        let values = (0..<arrayDate.count).map { (i) -> ChartDataEntry in
//            let val = Double(arc4random_uniform(range) + 3)
//            return ChartDataEntry(x: Double(i), y: val, icon: #imageLiteral(resourceName: "icon"))
//        }
//        let set1 = LineChartDataSet(entries: values, label: "")
//        set1.drawIconsEnabled = false
//        setup(set1)
//
//        let value = ChartDataEntry(x: Double(2), y: 10)
//        set1.addEntryOrdered(value)
//        let gradientColors = [ColorConstants.Primary_color!.cgColor,
//                              ColorConstants.Secondry_color!.cgColor]
//        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
//
//        set1.fillAlpha = 1
//        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
//        set1.drawFilledEnabled = true
//
//        let data = LineChartData(dataSet: set1)
//        chartView.data = data
//
//        let baseDate = Date() // Today's date for this example
//
//        let yAxis = chartView.leftAxis
//        yAxis.valueFormatter = DateValueFormatter(baseDate: baseDate)
//        yAxis.granularity = 1.0
        
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 1)
            return ChartDataEntry(x: Double(i), y: val, icon: #imageLiteral(resourceName: "icon"))
        }

        let set1 = LineChartDataSet(entries: values, label: "")
        set1.drawIconsEnabled = false
        setup(set1)

        let value = ChartDataEntry(x: Double(0), y: 30)
        set1.addEntryOrdered(value)
        let gradientColors = [ColorConstants.Primary_color!.cgColor,
                              ColorConstants.Secondry_color!.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        set1.fillAlpha = 1
        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set1.drawFilledEnabled = true

        let data = LineChartData(dataSet: set1)

        chartView.data = data
    }
    
    private func setup(_ dataSet: LineChartDataSet) {
        if dataSet.isDrawLineWithGradientEnabled {
            dataSet.lineDashLengths = nil
            dataSet.highlightLineDashLengths = nil
            dataSet.setColors(.black, ColorConstants.Primary_color!, .white)
            dataSet.setCircleColor(ColorConstants.Secondry_color!)
            dataSet.gradientPositions = [0, 40, 100]
            dataSet.lineWidth = 1
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = nil
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
        } else {
            dataSet.lineDashLengths = [5, 2.5]
            dataSet.highlightLineDashLengths = [5, 2.5]
            dataSet.setColor(.black)
            dataSet.setCircleColor(ColorConstants.Secondry_color!)
            dataSet.gradientPositions = nil
            dataSet.lineWidth = 1
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = [5, 2.5]
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
        }
    }
    
    @IBAction func slidersValueChanged(_ sender: Any?) {
        sliderTextX.text = "\(Int(sliderX.value))"
        sliderTextY.text = "\(Int(sliderY.value))"
        self.updateChartData()
    }
    
    
}
