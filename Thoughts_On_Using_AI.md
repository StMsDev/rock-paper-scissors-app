# 🧠 Thoughts on AI Tooling & Model Selection

During the development of this application, I experimented with different LLM models to optimize both the speed of development and the quality of the resulting architecture. Treating AI as an engineering resource requires understanding the strengths, limitations, and compute costs associated with different models.

Here is my takeaway on how to best orchestrate these tools:

## The Scaffolding Phase: Haiku
I began the project using the Haiku model.
* **Strengths:** It is incredibly fast and highly efficient for generating structural boilerplate, basic classes, and initial setups.
* **Limitations:** It is not ideal for end-to-end service implementation or complex architectural boundaries. The code it generates often requires human oversight, manual refactoring, and rewriting to meet production-grade standards.
* **Best Use Case:** Fast structure generation where the developer acts as the primary reviewer and refactorer.

## The Architectural Phase: Opus
When transitioning to the more complex requirements of this project (like RSpec Mocking vs. Stubbing boundaries and Docker orchestration), I switched to the Opus model.
* **Strengths:** Everything changed here. In my experience, it is currently one of the best models available for deep reasoning. It generates and executes complex architectural plans exceptionally well, anticipating edge cases and significantly minimizing the risk of bugs.
* **Limitations:** It is computationally expensive, meaning prompts must be engineered very deliberately. You do not want to waste Opus compute cycles on simple typo fixes.
* **Best Use Case:** Generating high-level architectural plans, strict testing strategies, and complex orchestration.

## 💡 The Ideal Workflow
Based on this experience, the most efficient, cost-effective engineering workflow is a hybrid approach:
1. **Architect with Opus:** Use the heavyweight reasoning model to generate the overarching technical plan, define the strict constraints, and design the interface boundaries.
2. **Execute with Haiku / Sonnet:** Delegate the step-by-step implementation of that master plan to the faster, more cost-effective models.
