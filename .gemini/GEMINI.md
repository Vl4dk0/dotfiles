# Gemini Configuration: My Personal Context and Preferences

This document outlines my preferences and technical environment to ensure our interactions are as efficient and helpful as possible. Please read and internalize this context for all our conversations.

---

## About Me & My Environment

- **Role:** I am a university student studying Computer Science and also work a coding job.
- **Location:** I am based in Slovakia. I may occasionally ask questions in Slovak, but unless I specifically ask for a response in Slovak (e.g., for translation or content creation), **please always reply in English.**
- **Operating System:** I use Linux, specifically Ubuntu 24.04 with the Wayland display server. 
- **Shell:** I use zsh, so I have my config in `.zshrc`.
- **Hardware:** My machine is a Lenovo ThinkPad E15 Gen 4 with a Ryzen 7 CPU and integrated graphics.
- **Package Management:** I use **Homebrew** for installing system-wide tools whenever possible.
- **Python:** I manage Python versions with `pyenv`. Please always use the `python` command, not `python3`.
- **Node.js:** I use `fnm` (Fast Node Manager) to manage Node.js versions.
- **Code Editor:** My primary editor is **Neovim** with **Lazy** package manager. I may ask for help with my configuration from time to time.

---

## Core Principles & Coding Style

- **Simplicity is Key:** I strongly prefer code that is simple, clean, and easy to understand. Prioritize readability and maintainability over overly clever or complex solutions.
- **Reusability:** I value utility functions and reusable code blocks. If you see an opportunity to create a reusable function, please do so.
- **Don't Delete, Comment:** When refactoring or suggesting changes, please do not delete code you think is unnecessary. Instead, comment it out and explain why you believe it might be redundant. I will remove it myself once I am sure. This aligns with my "measure twice, cut once" philosophy.
- **Sequential Thinking:** I appreciate it when you think through problems step-by-step. Outlining a plan before diving into the solution is very helpful.

---

## Interaction & Collaboration Preferences

- **Ask for Clarification:** Please be proactive in asking for more details. If a request is ambiguous, don't make assumptions. It's much better for you to ask me questions to get the full context than to provide a solution that misses the mark.
- **Example of Good Clarification:** If I say, *"There is a function in `download.py` that failed for some URLs, implement retry logic,"* I expect you to ask clarifying questions like:
    - "How many retries should I implement?"
    - "Should we use exponential backoff between retries? If so, what's the initial delay?"
    - "Should we log a message each time a retry occurs?"
- **Context is King:** I expect you to be able to read files, understand the existing code, and act based on that understanding. I will provide you with the necessary context or file contents.
- **Problem-Solving:** I rely on you to help me with a wide range of tasks, from fixing bugs and setting up development environments to solving university homework. I trust your ability to plan, figure things out, and provide robust solutions.

By following these guidelines, you will be able to assist me much more effectively. Thank you!
