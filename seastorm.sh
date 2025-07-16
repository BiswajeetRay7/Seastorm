#!/bin/bash

# ─────────────────────────────────────────────────────────────
# Seastorm - A tool dedicated to my VS7 ❤️
# AI-Inspired Nuclei Automation Fuzzer | Ocean & Star Themed
# Author: Biswajeet Ray | https://github.com/BiswajeetRay7
# Dependencies: gau, gauplus, waybackurls, hakrawler, katana, uro, httpx, nuclei, python3, ParamSpider, urlfinder
# Templates Used: https://github.com/projectdiscovery/fuzzing-templates
# ─────────────────────────────────────────────────────────────

# ───── Colors ─────
RED='\033[91m'
GREEN='\033[92m'
YELLOW='\033[93m'
BLUE='\033[94m'
RESET='\033[0m'
BOLD='\033[1m'

# ───── Spinner ─────
spin() {
  sp=("🌊" "✨" "🌟" "🌌" "💫" "⭐")
  sc=0
  printf "\033[s"
  while :; do
    printf "\033[u${sp[sc++]} "
    ((sc==${#sp[@]})) && sc=0
    sleep 0.15
  done
}
start_spinner() { spin & SPIN_PID=$!; disown; }
stop_spinner() { kill "$SPIN_PID" &>/dev/null; wait "$SPIN_PID" 2>/dev/null; printf "\n"; }

# ───── Countdown ─────
countdown_timer() {
  secs=$1
  while [ $secs -gt 0 ]; do
    echo -ne "${YELLOW}⏳ Countdown: $secs seconds remaining...\r${RESET}"
    sleep 1
    : $((secs--))
  done
  echo -ne "\n"
}

ascii_banner() {
echo -e "${BLUE}"
cat << "EOF"
███████╗███████╗ █████╗ ███████╗████████╗ ██████╗ ██████╗ ███╗   ███╗     ☆
██╔════╝██╔════╝██╔══██╗██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗████╗ ████║   ★
███████╗█████╗  ███████║███████╗   ██║   ██║   ██║██████╔╝██╔████╔██║     🌊 W A V E   O F   S C A N S
╚════██║██╔══╝ V██╔══██║╚════██║  S██║   ██║ 7 ██║██╔══██╗██║╚██╔╝██║   ⋆
███████║███████╗██║  ██║███████║   ██║   ╚██████╔╝██║  ██║██║ ╚═╝ ██║     ☆
╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝   ★

🌀 S E A S T O R M   |  MADE WITH LOVE BY BISWAJEET 💖  🌀
EOF
echo -e "${RESET}"
}

# ───── Quotes ─────
quotes=(
  "Growth comes from knowledge, not validation. — Biswajeet"
  "Stay curious. The ocean of vulnerabilities is infinite."
  "Real hackers don't guess. They observe."
  "One well-placed payload speaks louder than 1000 scans."
  "Silence is golden. Until you miss a bug."
)

random_quote() {
  quote=${quotes[$RANDOM % ${#quotes[@]}]}
  echo -e "${YELLOW}💡 Quote: \"$quote\"${RESET}"
}

# ───── Config ─────
OUTPUT_DIR="./output"
TEMPLATE_DIR="$HOME/fuzzing-templates"
RATE_LIMIT=50
CONCURRENCY=10
FAST_FETCH=false
TARGET_FILE=""
SINGLE_DOMAIN=""
INSTALL_MODE=false

# ───── Usage ─────
usage() {
  echo -e "${YELLOW}Usage: $0 [-f <targets.txt> | -d <domain>] [options]${RESET}"
  echo "  -f <file>           Target file"
  echo "  -d <domain>         Single domain to scan"
  echo "  -o <dir>            Output directory (default: ./output)"
  echo "  -t <template_dir>   Nuclei template directory"
  echo "  --fast-fetch        Quick mode with gau + httpx"
  echo "  -r <rate>           Rate limit (default: 50)"
  echo "  -c <concurrency>    Concurrency (default: 10)"
  echo "  --install           Install all dependencies"
  echo "  -h                  Show help"
  exit 1
}

# ───── Argument Parsing ─────
while [[ $# -gt 0 ]]; do
  case "$1" in
    -f) TARGET_FILE="$2"; shift 2;;
    -d) SINGLE_DOMAIN="$2"; shift 2;;
    -o) OUTPUT_DIR="$2"; shift 2;;
    -t) TEMPLATE_DIR="$2"; shift 2;;
    --fast-fetch) FAST_FETCH=true; shift;;
    -r) RATE_LIMIT="$2"; shift 2;;
    -c) CONCURRENCY="$2"; shift 2;;
    --install) INSTALL_MODE=true; shift;;
    -h) usage;;
    *) echo -e "${RED}[!] Unknown option: $1${RESET}"; usage;;
  esac
done

[[ -z "$TARGET_FILE" && -z "$SINGLE_DOMAIN" && "$INSTALL_MODE" != true ]] && echo -e "${RED}[!] Target required.${RESET}" && usage
mkdir -p "$OUTPUT_DIR"
RAW_URLS="$OUTPUT_DIR/raw.txt"
FILTERED_URLS="$OUTPUT_DIR/filtered.txt"
RESULTS_FILE="$OUTPUT_DIR/nuclei_results.txt"

# ───── Installer ─────
if [[ "$INSTALL_MODE" == true ]]; then
  echo -e "${GREEN}🔧 Installing dependencies...${RESET}"
  sudo apt update
  sudo apt install -y python3 python3-pip git
  pip3 install --break-system-packages uro requests urllib3
  go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
  go install github.com/projectdiscovery/httpx/cmd/httpx@latest
  go install github.com/projectdiscovery/katana/cmd/katana@latest
  go install github.com/tomnomnom/waybackurls@latest
  go install github.com/bp0lr/gauplus@latest
  go install github.com/hakluke/hakrawler@latest
  go install -v github.com/projectdiscovery/urlfinder/cmd/urlfinder@latest
  git clone https://github.com/0xKayala/ParamSpider "$HOME/ParamSpider"
  git clone https://github.com/projectdiscovery/fuzzing-templates "$HOME/fuzzing-templates"
  echo -e "${GREEN}[✓] Installation complete.${RESET}"
  exit 0
fi

# ───── URL Collection ─────
collect_urls() {
  echo -e "${BLUE}🌐 Collecting URLs with all tools...${RESET}"
  > "$RAW_URLS.tmp"
  start_spinner
  input=$( [[ -n "$SINGLE_DOMAIN" ]] && echo "$SINGLE_DOMAIN" || cat "$TARGET_FILE" )
  while IFS= read -r domain; do
    echo -e "${YELLOW}🔎 Collecting for: $domain${RESET}"
    echo "$domain" | gau 2>&1 | grep -v 'Error parsing URL' >> "$RAW_URLS.tmp"
    echo "$domain" | waybackurls 2>/dev/null >> "$RAW_URLS.tmp"
    echo "$domain" | hakrawler 2>/dev/null >> "$RAW_URLS.tmp"
    python3 "$HOME/ParamSpider/paramspider.py" -d "$domain" >> "$RAW_URLS.tmp" 2>/dev/null
  done <<< "$input"
  cat "$RAW_URLS.tmp" | uro | sort -u > "$FILTERED_URLS"
  rm -f "$RAW_URLS.tmp"
  stop_spinner
  echo -e "${GREEN}[✓] Collected $(wc -l < "$FILTERED_URLS") unique URLs${RESET}"
}

# ───── Nuclei Scanner ─────
run_nuclei() {
  echo -e "${GREEN}⚡ Running Nuclei with fuzzing-templates...${RESET}"
  start_time=$(date +%s)
  countdown_timer 5
  start_spinner
  nuclei -l "$FILTERED_URLS" -t "$TEMPLATE_DIR" -rl "$RATE_LIMIT" -c "$CONCURRENCY" | tee "$RESULTS_FILE"
  stop_spinner
  end_time=$(date +%s)
  duration=$((end_time - start_time))
  echo "$duration" > "$OUTPUT_DIR/time_taken.txt"
}

# ───── HTML Vulnerability Report ─────
generate_html_report() {
  echo -e "${BLUE}📝 Generating HTML report...${RESET}"
  echo "<html><head><title>Seastorm Report</title><style>
    body {font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background:#f0f4f8; color:#333; margin:20px;}
    h1 {color:#007acc; border-bottom: 3px solid #007acc; padding-bottom:10px;}
    h3 {color:#005f73;}
    table {width: 100%; border-collapse: collapse; margin-top: 20px;}
    th, td {border: 1px solid #ccc; padding: 10px; text-align: left;}
    th {background-color: #023047; color: white;}
    tr:nth-child(even) {background-color: #f8f9fa;}
    pre {background-color: #e0f7fa; padding: 15px; border-radius: 6px; overflow-x: auto;}
    p {font-size: 1rem; margin-top: 10px;}
  </style></head><body>" > "$OUTPUT_DIR/report.html"
  echo "<h1>Seastorm Scan Results</h1>" >> "$OUTPUT_DIR/report.html"
  echo "<h3>Scan Date: $(date)</h3>" >> "$OUTPUT_DIR/report.html"
  if [[ -f "$OUTPUT_DIR/time_taken.txt" ]]; then
    echo "<p><strong>Total Time Taken:</strong> $(cat "$OUTPUT_DIR/time_taken.txt") seconds</p>" >> "$OUTPUT_DIR/report.html"
  fi
  echo "<h2>Vulnerability Findings</h2>" >> "$OUTPUT_DIR/report.html"
  echo "<pre>" >> "$OUTPUT_DIR/report.html"
  cat "$RESULTS_FILE" >> "$OUTPUT_DIR/report.html"
  echo "</pre>" >> "$OUTPUT_DIR/report.html"
  echo "</body></html>" >> "$OUTPUT_DIR/report.html"
  echo -e "${GREEN}[✓] HTML report saved to $OUTPUT_DIR/report.html${RESET}"
}

# ───── Main ─────
ascii_banner
random_quote
echo -e "${BLUE}📅 Started on: $(date +"%A, %d %B %Y %r")${RESET}"

collect_urls
run_nuclei
generate_html_report

echo -e "${GREEN}🎉 Seastorm Scan Complete! 🌊💖${RESET}"
