import Foundation

func downloadNukkit() {
    let nukkitDir = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("NukkitServer").path
    let nukkitURL = "https://github.com/PetteriM1/NukkitPetteriM1Edition/releases/latest/download/nukkit.jar"

    runCommand("mkdir -p \(nukkitDir)")
    runCommand("curl -L -o \(nukkitDir)/nukkit.jar \(nukkitURL)")
}
