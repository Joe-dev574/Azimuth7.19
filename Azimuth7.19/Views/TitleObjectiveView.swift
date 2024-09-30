//
//  TitleObjectiveView.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI

struct TitleObjectiveView: View {
    var size: CGSize
    var objective: Objective
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(.footnoteGray)
            VStack(alignment: .center, spacing: 7){
                        objective.icon
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.blue)
                            .padding(4)
                            Text(objective.title)
                                .lineLimit(1)
                                .font(.title2)
                                .foregroundStyle(.volsOrange)
                                .fontWeight(.bold)
                                .padding(4)
                            Text(objective.remark)
                                .font(.callout)
                                .lineLimit(3)
                                .foregroundStyle(.gray)
                            Text(objective.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                                .font(.caption2)
                                .fontWeight(.light)
                                .foregroundStyle(.blue)
                                .offset(x: 0, y: 7)
                        }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .frame(width: size.width, height: size.height)
            }
     
            
        }
       
    }

    
   
