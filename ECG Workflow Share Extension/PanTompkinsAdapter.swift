//
//  PanTompkinsAdapter.swift
//  ServerConnectionTest
//
//  Created by Yannick Börner on 26.02.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation

/*
struct PanTompkinsAdapter {
    
    func detectQrsComplexes(measurements: [Float]) -> String {
        // Prepare the input
        writeInput(input: convertMeasurementsToInput(measurements: measurements))
        
        // Initiate the algorithm and execute it
        initFiles(strdup(getInputUrl()), strdup(getOutputUrl()))
        panTompkins()
        
        //printFile(url: getOutputUrl())
        
        // Capture Output
        let output = returnOutput()
        return output
    }
    
    func writeInput(input: String) {
        do {
            try input.write(to: URL(fileURLWithPath: getInputUrl()), atomically: false, encoding: .utf8)
        }
        catch {
            print("Error writing input to file")
        }
    }
    
    func returnOutput() -> String {
        let output = readOutputFromFile()
        let formattedOutput = convertOutputToSingleParagraphString(output: output)
        return formattedOutput
    }
    
    func readOutputFromFile() -> String {
        var output = ""
        do {
            output = try String(contentsOf: URL(fileURLWithPath: getOutputUrl()), encoding: .utf8)
        }
        catch {
            print("Error reading output")
        }
        return output
    }
    
    func convertOutputToSingleParagraphString(output: String) -> String {
        let outputFormatted = output.replacingOccurrences(of: "\n", with: " ")
        return outputFormatted
    }
    
    func convertMeasurementsToInput(measurements: [Float]) -> String {
        var fileContent = ""
        for measurement in measurements {
            let measurementAsInt = Int(measurement)
            fileContent = fileContent + String(measurementAsInt) + "\n"
        }
        return fileContent
    }
    
    func getInputUrl() -> String {
        let documentsPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let fileUrlAsString = documentsPathString! + "/test_input.txt"
        return fileUrlAsString
    }
    
    func getOutputUrl() -> String {
        let documentsPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let fileURL = documentsPathString! + "/test_output.txt"
        return fileURL
    }
    
    // For debugging purposes
    func printFile(url: String) {
        do {
            let text = try String(contentsOf: URL(fileURLWithPath: url), encoding: .utf8)
            print(text)
        }
        catch {/* error handling here */}
    }
}

 */
