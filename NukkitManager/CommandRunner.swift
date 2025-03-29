//
//  CommandRunner.swift
//  NukkitManager
//
//  Created by Ayumu Urakami on 2025/03/28.
//

import Foundation

func runCommand(_ command: String) {
    let process = Process()
    process.launchPath = "/bin/zsh"
    process.arguments = ["-c", command]
    process.launch()
    process.waitUntilExit()
}

func getOutputFromCommand(_ command: String) -> String {
    let process = Process()
    let pipe = Pipe()

    process.launchPath = "/bin/zsh"
    process.arguments = ["-c", command]
    process.standardOutput = pipe

    do {
        try process.run()
        process.waitUntilExit()
    } catch {
        return ""
    }

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    return String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
}
