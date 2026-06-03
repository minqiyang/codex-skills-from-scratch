# Prompt Templates

## Full Skill-first prompt

```text
请先使用 $skill-maker 处理这个任务。

任务如下：
<你的真实任务>

要求：
1. 先判断是否已有相关 Skill 可用。
2. 如果有，先读取并按它执行。
3. 如果没有，但这个任务未来可能复用，请先创建一个最小可用 Skill。
4. 然后照着 Skill 执行任务。
5. 完成后做一次 retrospective。
6. 只把本次实际学到、未来可复用的知识更新回 Skill。
7. 最后告诉我：用了哪个 Skill、是否新建/更新了 Skill、更新了什么。
```

## Short daily prompt

```text
请使用 $skill-maker：先判断这个任务是否值得沉淀成 Skill；如果值得，先写 Skill，再按它执行；做完后根据本次实际经验更新 Skill。

任务是：
<你的任务>
```

## Existing Skill prompt

```text
请使用 $<skill-name> 完成下面任务。做完后复盘，如果发现 Skill 缺少关键成功标准、踩坑点或稳定工具，请更新该 Skill。

任务是：
<你的任务>
```

## Explicit new Skill prompt

```text
请使用 $skill-maker，为下面这个可复用任务先创建一个最小可用 Skill，然后按该 Skill 执行任务。完成后只把本次验证过的经验更新回 Skill。

Skill 存放位置：
<个人全局：~/.agents/skills/<name>/SKILL.md；或项目级：.agents/skills/<name>/SKILL.md>

任务是：
<你的任务>
```
