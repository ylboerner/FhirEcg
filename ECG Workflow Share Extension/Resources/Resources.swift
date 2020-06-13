//
//  resources.swift
//
//  Created by Yannick Börner on 12.03.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation

struct Resources {
    
    struct Classification {
        var nameEng: String
        var nameGer: String
        var system: String
        var code: String
        var display: String
    }
    
    struct Symptom {
        var nameEng: String
        var nameGer: String
        var system: String
        var code: String
        var display: String
    }
    
    var classifications = Array<Classification>()
    var symptoms = Array<Symptom>()
    
    init() {
        // Classifications
        classifications.append(Classification(nameEng: "Sinus Rhythm", nameGer: "Sinusrhythmus", system: "http://snomed.info/sct", code: "251150006", display: "Sinus rhythm"))
        classifications.append(Classification(nameEng: "Atrial Fibrillation", nameGer: "Vorhofflimmern", system: "http://snomed.info/sct", code: "164889003", display: "Electrocardiographic atrial fibrillation"))
        classifications.append(Classification(nameEng: "Inconclusive", nameGer: "Uneindeutig", system: "http://snomed.info/sct", code: "442754001", display: "Inconclusive evaluation finding"))
        // Blueprint for adding a new classification
        //classifications.append(Classification(nameEng: "", nameGer: "", system: "http://snomed.info/sct", code: "", display: ""))

        // Symptoms
        symptoms.append(Symptom(nameEng: "Rapid pounding or fluttering heartbeat", nameGer: "Schneller hämmernder oder flatternder Herzschlag", system: "http://snomed.info/sct", code: "80313002", display: "Palpitations (finding)"))
        symptoms.append(Symptom(nameEng: "Skipped heartbeat", nameGer: "Übersprungener Herzschlag", system: "http://snomed.info/sct", code: "248653008", display: "Dropped beats"))
        symptoms.append(Symptom(nameEng: "Fatigue", nameGer: "Ermüdung", system: "http://snomed.info/sct", code: "84229001", display: "Fatigue (finding)"))
        symptoms.append(Symptom(nameEng: "Shortness of breath", nameGer: "Kurzatmigkeit", system: "http://snomed.info/sct", code: "267036007", display: "Dyspnea (finding)"))
        symptoms.append(Symptom(nameEng: "Chest tightness or pain", nameGer: "Engegefühl oder Schmerzen in der Brust", system: "http://snomed.info/sct", code: "23924001", display: "Tight chest (finding)"))
        symptoms.append(Symptom(nameEng: "Fainting", nameGer: "Ohnmacht", system: "http://snomed.info/sct", code: "271594007", display: "Syncope (disorder)"))
        symptoms.append(Symptom(nameEng: "Dizziness", nameGer: "Schwindel", system: "http://snomed.info/sct", code: "404640003", display: "Dizziness (finding)"))
        symptoms.append(Symptom(nameEng: "Other", nameGer: "Sonstiges", system: "http://snomed.info/sct", code: "74964007", display: "Other (qualifier value)"))
        symptoms.append(Symptom(nameEng: "None", nameGer: "Ohne", system: "http://snomed.info/sct", code: "260413007", display: "None (qualifier value)"))
        // Blueprint for adding a new symptom
        //symptoms.append(Symptom(nameEng: "", nameGer: "", system: "http://snomed.info/sct", code: "", display: ""))

    }
}
