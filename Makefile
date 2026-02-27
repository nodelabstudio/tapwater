.PHONY: screenshots screenshots-free screenshots-pro screenshots-insights screenshots-all upload-screenshots

FASTLANE ?= fastlane

screenshots:
	cd tapwater && $(FASTLANE) ios screenshots_fast $(if $(LANGUAGES),languages:"$(LANGUAGES)") $(if $(DEVICES),devices:"$(DEVICES)")

screenshots-free:
	cd tapwater && $(FASTLANE) ios screenshots_free_fast $(if $(LANGUAGES),languages:"$(LANGUAGES)") $(if $(DEVICES),devices:"$(DEVICES)")

screenshots-pro:
	cd tapwater && $(FASTLANE) ios screenshots_pro_fast $(if $(LANGUAGES),languages:"$(LANGUAGES)") $(if $(DEVICES),devices:"$(DEVICES)")

screenshots-insights:
	cd tapwater && $(FASTLANE) ios screenshots_insights_fast $(if $(LANGUAGES),languages:"$(LANGUAGES)") $(if $(DEVICES),devices:"$(DEVICES)")

screenshots-all:
	$(MAKE) screenshots-free LANGUAGES="$(LANGUAGES)" DEVICES="$(DEVICES)"
	$(MAKE) screenshots-pro LANGUAGES="$(LANGUAGES)" DEVICES="$(DEVICES)"
	$(MAKE) screenshots-insights LANGUAGES="$(LANGUAGES)" DEVICES="$(DEVICES)"

upload-screenshots:
	cd tapwater && $(FASTLANE) ios upload_screenshots
