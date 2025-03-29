import SwiftUI

struct ContentView: View {
    @State private var setupLog = ""
    @State private var isServerRunning = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Nukkit サーバー管理")
                .font(.title)

            // サーバーセットアップボタン
            Button("Nukkit サーバーをセットアップ") {
                DispatchQueue.global().async {
                    let result = installJDK17()
                    let javaPath = result.0
                    let log = result.1

                    DispatchQueue.main.async {
                        setupLog = log
                        if let path = javaPath {
                            setupLog += "\n🎉 セットアップ成功！"
                            setupNukkit() // 起動も自動で行いたくなければここを外す
                        } else {
                            setupLog += "\n⚠️ セットアップに失敗しました。"
                        }
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            // サーバー起動ボタン
            Button("サーバーを起動") {
                let nukkitDir = FileManager.default.homeDirectoryForCurrentUser
                    .appendingPathComponent("NukkitServer").path
                let javaPath = getOutputFromCommand("which java")

                DispatchQueue.global().async {
                    runCommand("cd \(nukkitDir) && \(javaPath) -jar nukkit.jar")
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)

            // ログ表示
            ScrollView {
                Text(setupLog)
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 300)
            .background(Color.black.opacity(0.05))
            .cornerRadius(8)
        }
        .padding()
    }
}
