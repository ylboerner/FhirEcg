//
//  CsvImport.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 18.04.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import CSV

struct DataCsvImport {
    var urlToCSV: URL
    var csvReader: CSVReader
}
