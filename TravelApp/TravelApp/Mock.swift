//
//  Location.swift
//  TravelApp
//
//  Created by Agripino Gabriel on 25/10/20.
//

import Foundation

struct Location {
    let name: String
    let imageName: String
    let date: String
    let daysBefore: String
}

let locations = [
    Location(
        name: "Siargao island, Philippines",
        imageName: "philippines",
        date: "2020.10.10 15:43",
        daysBefore: "5 days before departure"
    ),
    Location(
        name: "Nerja, Spain",
        imageName: "nerja",
        date: "2020.10.10 15:43",
        daysBefore: "5 days before departure"
    ),
    Location(
        name: "Veligandu Island, Maldives",
        imageName: "maldives",
        date: "2020.10.10 15:43",
        daysBefore: "5 days before departure"
    ),
    Location(
        name: "Manarola, Italy",
        imageName: "manarola",
        date: "2020.10.10 15:43",
        daysBefore: "5 days before departure"
    ),
    Location(
        name: "Tian Tan Buddha, Hong Kong",
        imageName: "hong-kong",
        date: "2020.10.10 15:43",
        daysBefore: "5 days before departure"
    ),
]
