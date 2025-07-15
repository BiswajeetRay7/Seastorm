# 🌊 Seastorm - AI-Powered Nuclei Automation Fuzzer

> **Dedicated to VS7 💖**  
> Ocean-themed vulnerability scanner with full automation, animations, AI fuzzing, ParamSpider support, HTML reports, real-time stats, and more.

---

## 🌀 Overview

**Seastorm** is a beautiful and powerful Bash-based automation wrapper built on top of [Nuclei](https://github.com/projectdiscovery/nuclei) with full integration of:

- 🌐 Multi-source URL gathering: `gau`, `gauplus`, `waybackurls`, `hakrawler`, `katana`, `ParamSpider`
- ⚡ Fast or Full fetch modes
- ✨ Real-time emoji animations & counters
- 🤖 Optional AI fuzzing with custom query sets
- 🧾 Auto HTML report generation
- 💡 Random terminal quotes
- 📊 Target summary and counts
- 🎨 Ocean & Star-themed ASCII UI

---

## ⚙️ Features

| Feature                     | Description |
|----------------------------|-------------|
| 🔗 Multi-tool URL fetching | gau, gauplus, waybackurls, hakrawler, katana, ParamSpider |
| 🧠 AI Mode                 | AI-based Nuclei fuzzing using `--ai` and categories |
| 📄 HTML Report             | Auto-generated report saved to `output/report.html` |
| 🌀 Spinner & Emoji Flow     | Clean UI with loading animations |
| 📅 Timestamp               | Full date & time on scan start |
| 💬 Random Quotes           | Inspirational hacking wisdom |
| 📈 Target Summary          | Real-time URL count and completion status |
| 💥 Lightweight Shell Tool  | No bloat, pure bash script |

---

## 🧰 Dependencies

> Make sure the following tools are installed:

- [Nuclei](https://github.com/projectdiscovery/nuclei)
- [gau](https://github.com/lc/gau)
- [gauplus](https://github.com/bp0lr/gauplus)
- [waybackurls](https://github.com/tomnomnom/waybackurls)
- [hakrawler](https://github.com/hakluke/hakrawler)
- [katana](https://github.com/projectdiscovery/katana)
- [ParamSpider](https://github.com/0xKayala/ParamSpider)
- [httpx](https://github.com/projectdiscovery/httpx)
- [uro](https://github.com/s0md3v/uro)
- Python 3, Git, and `pip`

You can install them all via:

```bash
./seastorm.sh --install
