//
//  SelectPartView.swift
//  MemberMatch
//
//  Created by Kensuke Nakagawa on 2024/07/22.
//

import SwiftUI

struct SelectWantedPartView: View {
    @Binding var selectionPart: [Part]
    @Environment(\.dismiss) private var dismiss

    private var partIconSize: CGFloat {
        ScreenUtil.deviceWidth / CGFloat(columnsCount) - 40
    }
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: columnsCount)
    }
    private let columnsCount: Int = 2
    private let columnsSpacingHeight: CGFloat = 20

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: columnsSpacingHeight) {
                    ForEach(selectionPart, id: \.self) { part in
                        VStack(spacing: 10) {
                            Image(part.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: partIconSize, height: partIconSize)
                                .scaleEffect(part.isWanted ? 1.05 : 1)
                                .shadow(radius: 3)
                                .opacity(part.isWanted ? 1 : 0.3)
                                .onTapGesture { toggleWantedStatus(part) }
                                .overlay(alignment: .topTrailing) {
                                    if part.isWanted {
                                        Menu {
                                            Button(Gender.male.text) {
                                                changeWantedPartGender(part, Gender.male)
                                            }
                                            Button(Gender.female.text) {
                                                changeWantedPartGender(part, Gender.female)
                                            }
                                            Button(Constants.Strings.selectGenderUnknownMenuText) {
                                                changeWantedPartGender(part, Gender.unknown)
                                            }
                                        } label: {
                                            Image(part.gender.iconName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .padding(2)
                                                .background {
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .foregroundStyle(.white)
                                                        .shadow(radius: 10)
                                                }
                                        }
                                    }
                                }
                            HStack(spacing: 0) {
                                Text(part.instrument.text)
                                    .font(.subheadline)
                                if part.gender != Gender.unknown {
                                    Text("(\(part.gender.text))")
                                        .font(.caption)
                                }
                            }
                            .opacity(part.isWanted ? 1 : 0.4)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }.padding()
            }
            .navigationTitle(Constants.Strings.selectWantedPartPageTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(Constants.Strings.sheetDismissButtonText) {
                        dismiss()
                    }
                }
            }
        }
    }

    private func toggleWantedStatus(_ part: Part) {
        if let index = selectionPart.firstIndex(where: { $0.instrument == part.instrument }) {
            selectionPart[index].isWanted.toggle()
        }
    }
    private func changeWantedPartGender(_ part: Part, _ gender: Gender) {
        if let index = selectionPart.firstIndex(where: { $0.instrument == part.instrument }) {
            selectionPart[index].gender = gender
        }
    }
}

#Preview {
    NavigationStack {
        SelectWantedPartView(selectionPart: .constant([]))
    }
}
