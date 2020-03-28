//
//  CsvParser.swift
//  ServerConnectionTest
//
//  Created by Yannick Börner on 12.03.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import CSV

class CsvParser {
    var csv: CSVReader
    var language: String?
    var name: String?
    var reference: String?
    var date: String?
    var device: String?
    var measurements = [Double]()
    var sampleRateInHz: Double?
    var period: Double?
    var classification: String?
    var symptoms = [String]()
    
    init(csv: CSVReader) {
        self.csv = csv
        parseCsv()
        validateData()
    }
    
    private func validateData() {
        if (name == nil) {
            self.name = "No name supplied"
        }
    }
    
    func parseCsv() {
        
        while let row = csv.next() {
            // Skip, if there are missing values in the row
            if (row.count < 2) {
                continue
            }
            
            // Extract key and value
            let key = row[0]
            let value = row[1]
            
            if key == "Name" {
                self.name = value
                
                // TODO: Dynamically add the reference
                self.reference = "Patient/e5100d62-be0a-4515-8aa1-5280aad185f5"
            }

            else if key == "Device" || key == "Gerät" {
                self.device = value
            }
            
            else if key == "Recorded Date" || key == "Aufzeichnungsdatum" {
                getFormattedDate(row: row)
            }
                
            else if key == "Sample Rate" || key == "Messrate" {
                getSampleRateFromRow(row: row)
                getPeriodFromSampleRate(sampleRate: self.sampleRateInHz!)
            }
                
            else if key == "Classification" || key == "Klassifizierung" {
                self.classification = value
            }
                
            else if key == "Symptoms" || key == "Symptome" {
                getSymptomsFromRow(row: row)
            }
            else {
                // Check if both are integers. If so, concatenate them with the string holding all the values and continue the loop
                if (Int(key) != nil && Int(value) != nil) {
                    let value = Double(key + "." + value)
                    measurements.append(value!)
                    continue
                }
            }
        }
    }
    
    private func getFormattedDate(row: [String]) {
        var dateInRightFormat = row[1].replacingOccurrences(of: " ", with: "T")
        dateInRightFormat = dateInRightFormat.replacingOccurrences(of: "T+", with: "+")
        dateInRightFormat = dateInRightFormat.replacingOccurrences(of: "T-", with: "-")
        self.date = dateInRightFormat
    }
    
    private func getSymptomsFromRow(row: [String]) {
        for i in 1...row.count-1 {
            symptoms.append(row[i])
        }
    }
    
    private func getSampleRateFromRow(row: [String]) {
        let valueOne = row[1]
        let valueTwo = row[2]
        let hz = Double(valueOne.westernArabicNumeralsOnly + "." + valueTwo.westernArabicNumeralsOnly)
        self.sampleRateInHz = hz!
    }
    
    private func getPeriodFromSampleRate(sampleRate: Double) {
        // Formula converting hz to period in ms
        self.period = 1/sampleRate * 1000
    }
}

extension String {
    var westernArabicNumeralsOnly: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .compactMap { pattern ~= $0 ? Character($0) : nil })
    }
}
