# FhirEcg

This project is an iOS application that permits users to send their ECG records captured on their Apple Watch directly to a FHIR server. It was developed during the corresponding bachelor thesis 'Implementing an ECG Data Workflow'. 

Features: 
- Conversion of ECG records to FHIR observations
- Transmission of converted records to a FHIR server (e.g. VONK)
- Custom server address and patient reference

# Usage

1. Clone the repository
2. Install the application on your iPhone via Xcode
3. Follow the on-screen instructions in the main app

# Next up

The next step is to move away from JSON to Swift-SMART for the creation of the observations. This will allow for authentication and more features in the future. Feel free to open a pull request!