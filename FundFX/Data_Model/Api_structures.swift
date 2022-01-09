//
//  api_structures.swift
//  FundFX
//
//  Created by Gokul Gopalakrishnan on 25/12/21.
//


import Foundation

struct articles: Codable
{
    internal init(topNews: [news?], totals: [news?], dailybrief: [news?], technicalAnalysis: [news?], specialReport: [news?]) {
        self.topNews = topNews
        self.dailybrief = dailybrief
        self.technicalAnalysis = technicalAnalysis
        self.specialReport = specialReport
        
        self.totals = totals
        
    }
    
    var topNews: [news?]
    var dailybrief: [news?]
    var technicalAnalysis: [news?]
    var specialReport:[news?]
    var totals: [news?]
    
  
    enum Outerkeys: String, CodingKey
    {
        case topNews
        case dailyBriefings = "dailyBriefings"
        case technicalAnalysis
        case specialReport
    }
    
    enum secondcodingwork: String, CodingKey
            {
                case eu = "eu"
                case asia = "asia"
                case us = "us"
            }
    
    
    init(from decoder: Decoder) throws {
        
      let outerContainer = try decoder.container(keyedBy: Outerkeys.self)
           
      let contactContainer = try outerContainer.nestedContainer(keyedBy: secondcodingwork.self, forKey: .dailyBriefings)
            
      self.dailybrief = try (contactContainer.decode([news].self, forKey: .eu) + contactContainer.decode([news].self, forKey: .asia) + contactContainer.decode([news].self, forKey: .us))
        
        self.topNews = try outerContainer.decode([news].self, forKey: .topNews)
        
        self.technicalAnalysis = try outerContainer.decode([news].self, forKey: .technicalAnalysis)
        
        self.specialReport = try outerContainer.decode([news].self, forKey: .specialReport)
         
        self.totals = self.specialReport + self.technicalAnalysis + self.topNews + self.dailybrief
    }
   
}


struct news: Codable, Hashable, Equatable
{
    static func == (lhs: news, rhs: news) -> Bool {
      return lhs.title == rhs.title && lhs.url == rhs.url && lhs.description == rhs.description && lhs.headlineImageUrl == rhs.headlineImageUrl
    }
    
    
    let title: String?
    let url: String?
    let description: String?
    let headlineImageUrl: String?
    let authors: [author_list?]
}

struct author_list: Codable, Hashable
{
    let name: String?
    let title: String?
    let bio: String?
}


var search_detail = [news_search]()


struct news_search: Codable, Hashable
{
    var total: news
    var index : Int

}
