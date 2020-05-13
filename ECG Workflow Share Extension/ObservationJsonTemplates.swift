//
//  ObservationJsonTemplates.swift
//  ServerConnectionTest
//
//  Created by Yannick Börner on 12.03.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ObservationJsonTemplates {
    
    public let observationTemplate: JSON = [
      "resourceType": "Observation",
      "status": "final",
      "category": [
        [
          "coding": [
            [
              "system": "https://www.hl7.org/fhir/procedure.html",
              "code": "procedure",
              "display": "Procedure"
            ]
          ]
        ]
      ],
      "code": [
        "coding": [
          [
            "system": "urn:oid:2.16.840.1.113883.6.24",
            "code": "131328",
            "display": "MDC_ECG_ELEC_POTL"
          ]
        ]
      ],
      "subject": [
        "reference": "",
        "display": ""
      ],
      "effectiveDateTime": "",
      "performer": [
        [
          "reference": "",
          "display": ""
        ]
      ],
      "device": [
        "display": ""
      ],
      "component": [
        [
          "code": [
            "coding": [
              [
                "system": "urn:oid:2.16.840.1.113883.6.24",
                "code": "131329",
                "display": "MDC_ECG_ELEC_POTL_I"
              ]
            ]
          ],
          "valueSampledData": [
            "period": 2,
            "dimensions": 1,
            "origin": [
              "value": 0
            ],
            "data": "data"
          ]
        ]
      ]
    ]

    public let symptomComponentTemplate: JSON = [
      "code": [
        "coding": [
          [
            "system": "https://loinc.org",
            "code": "75325-1",
            "display": "Symptom"
          ]
        ]
      ],
      "valueCodeableConcept": [
          "coding": [
              [
                  "system": "",
                  "code": "",
                  "display": ""
              ]
          ],
          "text": ""
      ]
    ]

    public let symptomsAskedButDeclinedComponentTemplate: JSON = [
      "code": [
        "coding": [
          [
            "system": "https://loinc.org",
            "code": "75325-1",
            "display": "Symptom"
          ]
        ]
      ],
      "valueCodeableConcept": [
          "coding": [
              [
                  "system": "https://www.hl7.org/fhir/codesystem-data-absent-reason.html",
                  "code": "asked-declined",
                  "display": "Asked But Declined"
              ]
          ],
          "text": "The source was asked but declined to answer."
      ]
    ]

    public let classificationComponentTemplate: JSON =     [
      "code": [
        "coding": [
          [
            "system": "http://snomed.info/sct",
            "code": "271921002",
            "display": "Electrocardiogram finding"
          ]
        ]
      ],
      "valueCodeableConcept": [
          "coding": [
              [
                  "system": "http://snomed.info/sct",
                  "code": "",
                  "display": ""
              ]
          ],
          "text": "classification"
      ]
    ]
    
}
