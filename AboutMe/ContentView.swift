//
//  ContentView.swift
//  AboutMe
//
//  Created by Louis Chang on 2024/9/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderView()
                ProfileView()
                CompanyView(name: "Zip2", symbol: "zip2",
                            description: "1995年創立，是一家軟體公司，主要是為新聞提供線上的城市導航與指南資訊。1999年被Compaq收購。",
                            images: ["zip2_1"], companyLink: " ")
                
                CompanyView(name: "PayPal", symbol: "paypal",
                            description: "1998年創立，是由Confinity及X.com兩家公司合併而成，主要提供第三方支付服務。2002年被eBay收購。",
                            images: ["paypal2_1", "paypal2_2"], companyLink: " ")
                
                CompanyView(name: "SpaceX", symbol: "spacex",
                            description: "是一家民營航太製造商和太空運輸公司。2002年創辦，其目標是降低太空運輸的成本，並最終進行火星殖民。",
                            images: ["spacex2_1", "spacex2_2"], companyLink: "https://www.spacex.com")
                
                CompanyView(name: "Tesla", symbol: "tesla",
                            description: "美國最大的電動汽車及太陽板公司。特斯拉是世界上最早的自動駕駛汽車生產商，至2018年，特斯拉汽車已經成為世界最暢銷充電式汽車公司。",
                            images: ["tesla2_1", "tesla2_2", "tesla2_3"], companyLink: "https://www.tesla.com")
                
                CompanyView(name: "SolarCity", symbol: "solarCity", description: "美國最大的太陽能發電公司，專門發展家用及商業光伏發電項目，2016年11月17日，特斯拉汽車以26億美元收購SolarCity，為太陽能業史上最龐大的交易，SolarCity亦正式成為特斯拉汽車旗下的公司。",
                            images: [], companyLink: " ")
                
                CompanyView(name: "The Boring Company", symbol: "TBC",
                            description: "美國一家基礎設施和隧道建設公司，其目前的專案是為城市內部交通系統而設計，最終目標為城際超級高鐵。",
                            images: ["bor2_1", "bor2_2", "bor2_3"], companyLink: "https://www.boringcompany.com")
                
                CompanyView(name: "OpenAI", symbol: "OpenAI",
                            description: "2015年創立，是一個美國人工智慧研究實驗室，目的是促進和發展友好的人工智慧，使人類整體受益。2018年馬斯克已因為利基不合而退出OpenAI管理層。",
                            images: [], companyLink: " ")
                
                CompanyView(name: "Neuralink", symbol: "neuralinkLogo",
                            description: "神腦科技和腦機接口公司，負責研發植入式腦機介面技術。2016年6月，馬斯克曾經探討過一個科幻小說概念「neural lace」，即人腦與機器交互。於隔年公之於眾",
                            images: ["neu2_1"], companyLink: "https://neuralink.com")
                
                CompanyView(name: "Twitter", symbol: "twitter",
                            description: "2022年4月14日，美國企業家伊隆·馬斯克提議以430億美元的價格收購社群媒體公司推特。10月27日，馬斯克完成以440億美元將推特私有化的交易。",
                            images: [], companyLink: " ")
                FooterView()
                ContactView()
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}

struct HeaderView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2)
            VStack {
                Text("Elon Musk")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Image(systemName: "sparkles")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.yellow)
                    .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false), value: isAnimating)
                    .onAppear {
                        isAnimating = true
                    }
            }
        }
        .frame(height: 150)
        .cornerRadius(15)
    }
}

struct ProfileView: View {
    var body: some View {
        HStack {
            Image("elon_musk")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
            
            VStack(alignment: .leading) {
                Text("Entrepreneur & Innovator")
                    .font(.headline)
                Text("Born: June 28, 1971")
                    .font(.subheadline)
                Text("Pretoria, South Africa")
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}

struct CompanyView: View {
    let name: String
    let symbol: String
    let description: String
    let images: [String]
    let companyLink: String
    
    @State private var isExpanded = false
    private let companiesWithLink = ["SpaceX", "Tesla", "The Boring Company", "Neuralink"]
    
    var body: some View {
        VStack {
            HStack {
                
                Image(symbol)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                
                Text(name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                Text(description)
                    .font(.body)
                    .padding(.top)
                
                if !images.isEmpty{
                    TabView {
                        ForEach(images, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                                .cornerRadius(10)
                        }
                    }
                    .frame(height: 300)
                    .tabViewStyle(PageTabViewStyle())
                }
                
                if companiesWithLink.contains(name) {
                    Link(destination: URL(string: companyLink)!) {
                        Text("訪問 \(name) 官網")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
                
                
                
                /*
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(images, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.top)
                */
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}

struct FooterView: View {
    var body: some View {
        HStack {
            Image(systemName: "lightbulb.fill")
                .foregroundColor(.yellow)
            Text("外部連結")
            Image(systemName: "lightbulb.fill")
                .foregroundColor(.yellow)
        }
    }
}

struct ContactView: View {
    var body: some View {
        HStack(spacing: 20) {
            Link(destination: URL(string: "https://weibo.com/ElonMusk")!) {
                Image(.wiebo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
                    .font(.title)
                    .foregroundColor(.red)
            }
            
            Link(destination: URL(string: "https://x.com/elonmusk")!) {
                Image(.X)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
                    .font(.title)
                    .foregroundColor(.purple)
            }
            
            Link(destination: URL(string: "https://www.ted.com/speakers/elon_musk")!) {
                Image(.ted)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
                    .font(.title)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
