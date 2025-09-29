# Конфигурации
XCODEGEN_CONFIG = project.yml
SWIFTGEN_CONFIG = ModulePackages/ApplicationResources/swiftgen.yml
SWIFTGEN_GENERATED = ModulePackages/ApplicationResources/Sources/ApplicationResources/Generated

# SwiftGen
generate_resources:
	@echo "Running SwiftGen"
	mkdir -p $(SWIFTGEN_GENERATED)
	swiftgen config run --config $(SWIFTGEN_CONFIG)

# XCodeGen
generate_project:
	@echo "Running XCodeGen"
	xcodegen generate --spec $(XCODEGEN_CONFIG)
