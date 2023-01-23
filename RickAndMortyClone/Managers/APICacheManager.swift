//
//  APICacheManager.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 14/1/2023.
//
 
import Foundation

/// Manages in memory session scoped API Caches
final class APICacheManager {
    //API URL: Data
    
    private var cacheDictionary: [
        NetworkEndpoint: NSCache<NSString, NSData>
    ] = [:]
    
    init() {
        setUpCache()
    }
    
    //MARK: - Public
    public func cachedResponse(for endpoint: NetworkEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: NetworkEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    //MARK: - private function
    private func setUpCache() {
        NetworkEndpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        })
    }
    
    
    
}
