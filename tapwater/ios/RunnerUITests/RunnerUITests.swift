import XCTest

@MainActor
final class RunnerUITests: XCTestCase {

  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  func testCaptureScreenshots() throws {
    let app = XCUIApplication()
    setupSnapshot(app)

    app.launchArguments += ["--ui-testing"]
    app.launch()

    // Main storefront screens.
    snapshot("01_Home")
    captureHistoryScreens(app)
    if captureTabIfExists(app, tabLabel: "Settings", snapshotName: "04_Settings") {
      capturePaywallFromSettings(app)
      captureExportFromSettings(app)
    }
  }

  @discardableResult
  private func captureTabIfExists(_ app: XCUIApplication, tabLabel: String, snapshotName: String) -> Bool {
    let tab = app.tabBars.buttons[tabLabel]
    guard tab.waitForExistence(timeout: 2) else { return false }
    tab.tap()
    sleep(1)
    snapshot(snapshotName)
    return true
  }

  private func captureHistoryScreens(_ app: XCUIApplication) {
    guard captureTabIfExists(app, tabLabel: "History", snapshotName: "02_History") else { return }

    let yearViewButton = app.buttons["Year view"]
    guard yearViewButton.waitForExistence(timeout: 2) else { return }

    yearViewButton.tap()
    sleep(1)

    // After toggling to year/bubble mode, the button tooltip changes to "List view".
    if app.buttons["List view"].waitForExistence(timeout: 2) {
      snapshot("03_History_Bubble")
    }
  }

  private func capturePaywallFromSettings(_ app: XCUIApplication) {
    var opened = false
    let knownPlanLabels = [
      "Upgrade to Pro",
      "Current Plan: pro",
      "Current Plan: insights",
      "Current Plan: Pro",
      "Current Plan: Insights",
    ]

    for label in knownPlanLabels {
      if tapCellIfVisible(app, text: label) {
        opened = true
        break
      }
    }

    if !opened {
      let currentPlanText = app.staticTexts.matching(
        NSPredicate(format: "label BEGINSWITH 'Current Plan:'")
      ).firstMatch
      if currentPlanText.waitForExistence(timeout: 1) {
        currentPlanText.tap()
        opened = true
      }
    }

    guard opened else { return }

    if app.navigationBars["Upgrade"].waitForExistence(timeout: 3) {
      sleep(1)
      snapshot("05_Paywall")
      tapBackIfPossible(app)
    }
  }

  private func captureExportFromSettings(_ app: XCUIApplication) {
    guard scrollToAndTapCell(app, text: "Export Data (CSV)") else { return }

    if app.navigationBars["Export Data"].waitForExistence(timeout: 3) {
      sleep(1)
      snapshot("06_Export")
      tapBackIfPossible(app)
      return
    }

    // Free tier can be redirected to paywall from the Export entry.
    if app.navigationBars["Upgrade"].waitForExistence(timeout: 3) {
      sleep(1)
      snapshot("06_Export_Locked")
      tapBackIfPossible(app)
    }
  }

  private func tapCellIfVisible(_ app: XCUIApplication, text: String) -> Bool {
    let cell = app.cells.containing(.staticText, identifier: text).firstMatch
    guard cell.waitForExistence(timeout: 1) else { return false }
    cell.tap()
    return true
  }

  private func scrollToAndTapCell(_ app: XCUIApplication, text: String, maxSwipes: Int = 8) -> Bool {
    for _ in 0...maxSwipes {
      let cell = app.cells.containing(.staticText, identifier: text).firstMatch
      if cell.exists {
        cell.tap()
        return true
      }
      app.swipeUp()
      sleep(1)
    }
    return false
  }

  private func tapBackIfPossible(_ app: XCUIApplication) {
    let navBar = app.navigationBars.firstMatch
    guard navBar.exists else { return }

    let backButton = navBar.buttons.element(boundBy: 0)
    if backButton.exists && backButton.isHittable {
      backButton.tap()
      return
    }

    if app.buttons["Back"].exists && app.buttons["Back"].isHittable {
      app.buttons["Back"].tap()
    }
  }
}
