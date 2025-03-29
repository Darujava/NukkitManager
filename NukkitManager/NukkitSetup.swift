import Foundation

func setupNukkit() {
    let result = installJDK17()
    let javaPath = result.0
    let log = result.1

    if javaPath == nil {
        print("🚨 JDK 17 のインストールに失敗しました。")
        print(log) // エラー内容をログに出力
        return
    }

    downloadNukkit()

    let nukkitDir = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("NukkitServer").path

    // Nukkit サーバーを初回起動
    runCommand("cd \(nukkitDir) && \(javaPath!) -jar nukkit.jar")
}
