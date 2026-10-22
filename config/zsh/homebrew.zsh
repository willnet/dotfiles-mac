if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
else
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# Homebrew's curl is keg-only, so prefer it explicitly over macOS's curl.
export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/curl/bin:$PATH"
