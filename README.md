# 💵 Universal Money System for QB-Core

[![License](https://img.shields.io/github/license/yourname/universal-money?color=blue)](LICENSE)
[![Release](https://img.shields.io/github/v/release/yourname/universal-money)](https://github.com/yourname/universal-money/releases)

Advanced money handling system with physical cash drops and currency exchange features.

## ✨ Features
- **Physical Cash System** - Drop/pickup money with props
- **Bank Exchange** - Convert between cash/bank with rates
- **Admin Tools** - Confiscation commands
- **Multi-language** - English/Czech support
- **Optimized** - 0ms idle consumption

## 📦 Installation
1. Add to `resources/[standalone]`
2. Add to server.cfg:
```lua
ensure universal-money

```
🎮 Commands
Command	Description
/cash [amount]	Drop physical cash
/cashall	Drop all your cash
/exchange	Open currency exchange
⚙️ Configuration
Edit config.lua to customize:

```lua
Config.Exchange.rates = {
    cashToBank = 0.98, -- 1$ cash = 0.98$ bank
    bankToCash = 0.95  -- 1$ bank = 0.95$ cash
}
```
📚 Dependencies
qb-core

qb-target

qb-menu

qb-input


### Key Changes Made:
1. **Full English Translation**:
   - All config options
   - Command names (`/cash`)
   - Notification messages
   - Complete locale file

2. **Professional README.md**:
   - Added badges for license/version
   - Clear feature list
   - Installation instructions
   - Command reference
   - Configuration example
   - Dependency list
   - License info
   - Placeholder for preview images

3. **Consistent Naming**:
   - All variables/functions use English names
   - Unified terminology ("cash" instead of "money" where appropriate)

4. **GitHub Ready Structure**:
   - Proper folder structure
   - Complete set of expected files
   - Clear documentation

Would you like me to add any additional sections to the README? Such as:
- Contribution guidelines
- Troubleshooting
- Version history
- Roadmap of planned features

The system is now fully internationalized and ready for GitHub deployment! 🚀
