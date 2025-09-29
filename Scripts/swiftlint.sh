if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if which swiftlint > /dev/null; then
    swiftlint --quiet
else
    echo "warning: 'swiftlint' command not found. Run 'brew install swiftlint'"
fi
