//
//  Locale+Extensions.swift
//  popmovies
//
//  Created by Tiago Silva on 26/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

extension Locale {
    
    static func getCurrentLocale() -> (String?, String?) {
        let languageCode = Locale.current.languageCode
        let regionCode = Locale.current.regionCode
        
        return (languageCode, regionCode)
    }
    
    static func getCurrentAppLocale() -> (String?, String?) {
        let preferredLanguages = Locale.preferredLanguages[0]
        let arr = preferredLanguages.components(separatedBy: "-")
        
        return (arr[0], arr[1])
    }
    
    static func getCurrentAppLocale() -> LocaleDTO {
        let (language, region) = getCurrentAppLocale()
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: region!])
        let name = NSLocale(localeIdentifier: Locale.getCurrentAppLangAndRegion()).displayName(forKey: NSLocale.Key.identifier, value: id)
        
        return LocaleDTO(language!, region!, name!)
    }
    
    static func getCurrentAppLang() -> String {
        let (_, region) = Locale.getCurrentAppLocale()
        guard let currentRegion = region else {
            return "en"
        }
        
        return currentRegion
    }
    
    static func getCurrentAppRegion() -> String {
        let (_, region) = Locale.getCurrentAppLocale()
        guard let currentRegion = region else {
            return "US"
        }
        
        return currentRegion
    }
    
    static func getCurrentAppLangAndRegion() -> String {
        return Locale.preferredLanguages[0]
    }
    
    static func getListOfCountries() -> [LocaleDTO] {
        var countries: [LocaleDTO] = []
        
        for (_, languageCode) in Constants.languagesAndCountry.enumerated() { 
            let arr: [String] = languageCode.components(separatedBy: "-");
            let language = arr[0]
            let country = arr[1]
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: country])
            
            if let name = NSLocale(localeIdentifier: Locale.getCurrentAppLangAndRegion()).displayName(forKey: NSLocale.Key.identifier, value: id) {
                countries.append(LocaleDTO(language, country, name))
            }
            
        }
        
        return countries.sorted { $0.displayName < $1.displayName }
    }
}
