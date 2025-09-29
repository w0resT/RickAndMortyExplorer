# Конфигурации
XCODEGEN_CONFIG = project.yml
SWIFTGEN_CONFIG = ModulePackages/ApplicationResources/swiftgen.yml
SWIFTGEN_GENERATED = ModulePackages/ApplicationResources/Sources/ApplicationResources/Generated

# Скрипты
SWIFTLINT_SCRIPT = Scripts/swiftlint.sh

# SwiftGen
generate_resources:
	@echo "Running SwiftGen"
	mkdir -p $(SWIFTGEN_GENERATED)
	swiftgen config run --config $(SWIFTGEN_CONFIG)

# XCodeGen
generate_project:
	@echo "Running XCodeGen"
	xcodegen generate --spec $(XCODEGEN_CONFIG)

# SwiftLint
lint:
	@echo "Running SwiftLint"
	$(SWIFTLINT_SCRIPT)

# All-in
all: lint generate_resources generate_project
	
# Cleaning
clean:
	@echo "Cleaning"
	find . -type d -name "$(BUILD_DIR)" -print -exec rm -rf {} + 2>/dev/null || true
