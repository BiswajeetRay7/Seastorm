# 🌊 Seastorm

**Nuclei Automation Fuzzer & URL Collection Suite**  
🛡️ Nuclei fuzzer by [Biswajeet Ray](https://github.com/BiswajeetRay7)

---

## 🔍 Overview

Seastorm is a fully automated, beautifully themed vulnerability scanning suite designed for modern-day security professionals, ethical hackers, and bug bounty hunters. It combines the power of several open-source tools for URL discovery and integrates them with the fuzzing capabilities of [ProjectDiscovery's Nuclei](https://github.com/projectdiscovery/nuclei). 

Each scan is accompanied by a visually structured HTML report, countdown timers, elegant terminal output, and a unique user interface inspired by the ocean and stars 🌊✨.

---

## ✨ Features

- 🌐 **Comprehensive URL Harvesting**:
  - `gau` — Grab Anything Useful from the Wayback Machine (by [lc](https://github.com/lc))
  - `waybackurls` — Historical URL fetcher (by [tomnomnom](https://github.com/tomnomnom))
  - `hakrawler` — Lightweight crawler built with Go (by [hakluke](https://github.com/hakluke))
  - `ParamSpider` — Advanced parameter miner using Python (by [devanshbatham](https://github.com/devanshbatham))
  - `uro` — URL deduplicator and sanitizer (by [s0md3v](https://github.com/s0md3v))

- ⚔️ **Nuclei DAST Integration**
  - Automatically uses the latest [fuzzing-templates](https://github.com/projectdiscovery/fuzzing-templates)
  - Support for concurrency, rate limiting, and large-scale parallel scans

- 📑 **HTML Vulnerability Report**
  - Styled like a VAPT report
  - Includes time metrics, scan summary, formatted findings
  - Color-coded professional UI with tables and `pre` formatting

- 💫 **Ocean and Star Themed UX**
  - Terminal spinner with emojis
  - Random cybersecurity quotes
  - Clean banner with ASCII art

- 🛠️ **Easy Setup**
  - One-line `--install` flag to install all Go, Python, and cloning dependencies

- 🧘 **Silent Execution for UI-only Tools**
  - Tools like `katana` and `urlfinder` are referenced in UI but not run
  - No clutter or error messages from underlying tools

- ⏱️ **Scan Timer**
  - 5-second countdown
  - Records and logs total execution time

---

## 📦 Installation

Run the following to install all dependencies:

```bash
# 1. Clone the Seastorm repository
git clone https://github.com/BiswajeetRay7/seastorm

# 2. Enter the project directory
cd seastorm

# 3. Make the script executable
chmod +x seastorm.sh

# 4. Install all required dependencies (Go, Python tools, and repos)
./seastorm.sh --install

# 5. (Optional) Make it globally accessible from anywhere on your system
sudo cp seastorm.sh /usr/local/bin/seastorm
sudo chmod +x /usr/local/bin/seastorm
```

This command installs the following tools:

| Tool | Purpose | Author |
|------|---------|--------|
| [gau](https://github.com/lc/gau) | Historical URL collection | [lc](https://github.com/lc) |
| [waybackurls](https://github.com/tomnomnom/waybackurls) | Wayback Machine mining | [tomnomnom](https://github.com/tomnomnom) |
| [hakrawler](https://github.com/hakluke/hakrawler) | JavaScript-based crawler | [hakluke](https://github.com/hakluke) |
| [ParamSpider](https://github.com/devanshbatham/paramspider) | Parameter miner | [devanshbatham](https://github.com/devanshbatham) |
| [uro](https://github.com/s0md3v/uro) | URL deduplication | [s0md3v](https://github.com/s0md3v) |
| [nuclei](https://github.com/projectdiscovery/nuclei) | DAST engine | [projectdiscovery](https://github.com/projectdiscovery) |
| [httpx](https://github.com/projectdiscovery/httpx) | HTTP probing | [projectdiscovery](https://github.com/projectdiscovery) |
| [katana](https://github.com/projectdiscovery/katana) | Crawler (UI only) | [projectdiscovery](https://github.com/projectdiscovery) |
| [urlfinder](https://github.com/projectdiscovery/urlfinder) | URL Parser (UI only) | [projectdiscovery](https://github.com/projectdiscovery) |

---

## 🚀 Usage

```bash
./seastorm.sh -d example.com
./seastorm.sh -f targets.txt
```

### ⚙️ Flags and Options

| Flag | Description |
|------|-------------|
| `-d <domain>` | Scan a single domain |
| `-f <targets.txt>` | Scan multiple domains from file |
| `-o <output_dir>` | Set custom output directory (default: `./output`) |
| `-t <template_dir>` | Set custom nuclei template dir |
| `-r <rate>` | Set rate limit (default: 50) |
| `-c <concurrency>` | Set concurrency (default: 10) |
| `--fast-fetch` | Use only `gau` + `httpx` for quick URL fetch |
| `--install` | Install all required dependencies |
| `-h` | Show help |

---

## 📁 Output Structure

After a successful run, you'll find all output in the specified `output/` directory:

```
output/
├── raw.txt                # All raw collected URLs from all tools
├── filtered.txt           # Deduplicated and cleaned URLs
├── nuclei_results.txt     # Findings from nuclei scan
├── time_taken.txt         # Duration of scan (seconds)
└── report.html            # Styled HTML report
```
---

## 🧠 Sample Cybersecurity Quotes

> "Growth comes from knowledge, not validation." — Biswajeet  
> "Stay curious. The ocean of vulnerabilities is infinite."  
> "One well-placed payload speaks louder than 1000 scans."

Each scan displays one quote randomly to keep you motivated. 🧘

---

## ❤️ Dedication

> **This tool is lovingly dedicated to VS7**

---

## 📜 License

MIT License

You are free to:
- Use
- Modify
- Contribute
- Build your own customized versions 

---

## 🙋 Support / Feedback

Feel free to:
- Open Issues
- Submit Pull Requests
- Star ⭐ the repo if it helped you!

Built by:
- [Biswajeet Ray](https://github.com/BiswajeetRay7)

> Happy hacking! 🌊💫
