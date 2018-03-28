extension Double {
    func round(toDecimalPlaces decimalPlaces: Int) -> Double {
        return Double(Int(self * pow(10, Double(decimalPlaces)))) / pow(10, Double(decimalPlaces))
    }
}
