
enum Const {
    enum Title: String {
        case focus = "Фокусировка"
        case smallRest = "Короткий перерыв"
        case bigRest = "Длинный перерыв"
    }
    enum Control: String {
        case startButton = "Начать"
        case pauseButton = "Пауза"
        case resumeButton = "Дальше"
    }
    enum Segue: String {
        case toFocusSettings
        case toSmallRestSettings
        case toBigRestSettings
    }
    enum SettingsKey: String {
        case soundAtCompletion
        case notifyAtCompletion
        case focusTime
        case smallRestTime
        case bigRestTime
        // Internal settings
        case initialSetup
        case timeLeft
        case focusTimeRange
        case smallRestTimeRange
        case bigRestTimeRange
    }
}
