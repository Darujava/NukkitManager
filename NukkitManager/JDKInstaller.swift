import Foundation


func installJDK17() -> (String?, String) {
    var log = ""

    // Step 1: brew を探す
    let brewCommandPath = getOutputFromCommand("/usr/bin/which brew")
    if brewCommandPath.isEmpty {
        log += "🚨 Homebrew が見つかりません。以下のコマンドを実行してください：\n"
        log += """
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        """
        return (nil, log)
    }

    log += "🍺 Homebrew を検出: \(brewCommandPath)\n"

    // Step 2: JDK17 インストール確認
    let javaHomePath = getOutputFromCommand("\(brewCommandPath) --prefix openjdk@17")
    if javaHomePath.isEmpty {
        log += "📦 JDK17 をインストール中...\n"
        runCommand("\(brewCommandPath) install openjdk@17")
    } else {
        log += "✅ JDK17 は既にインストール済みです。\n"
    }

    let newJavaHomePath = getOutputFromCommand("\(brewCommandPath) --prefix openjdk@17")
    let javaExecutable = "\(newJavaHomePath)/bin/java"
    if FileManager.default.fileExists(atPath: javaExecutable) {
        log += "✅ Java 実行ファイル検出: \(javaExecutable)\n"
        return (javaExecutable, log)
    } else {
        log += "🚨 Java 実行ファイルが見つかりませんでした: \(javaExecutable)\n"
        return (nil, log)
    }
}
