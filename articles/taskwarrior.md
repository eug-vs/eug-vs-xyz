# TaskWarrior :taskwarrior: is all you need to be productive

Nowadays there is an **ocean** of different productivity tools, systems and methodologies. The secret is - you only need one!

# The problem
I always wanted to come up with a standartized system to manage my life. I bet you too!

## TickTick
I've tried different approaches and tools and finally ended up with [TickTick](https://ticktick.com) (*and even bought a premium subscription*).

It provided me with many features, including:
 - *Calendar* - this was a must-have to me, I wanted to be able to see top-down view of my week and be able to do "time blocking"
 - *Disctinction between tasks and notes* - that was important because back then I already wanted to start accumulating my knowledge somewhere
 - *Markdown support* - plaintext is good, but `Markdown` is just so much better for notetaking
 - *Arbitrary folder hierarchy* - allowed me to have full control over the structure
 - *Tags and complex filtering system*

It has even more cool stuff, like reminding you about tasks when you arrive at their location, voice input and excellent UI/UX.

## So why did I switch?
`TickTick` covered all my use-cases (*and even more*), so why did I switch?

Well, there are a couple reasons for that:
 - They have all your data. Ideally I want my management system to be **private** and available offline.
 - Keeping notes there just felt like it's too much. The question is: how is it different from writing in plaintext `Markdown` files on mobile phone or laptop?

# Discovering Vimwiki
At this point I was already using `Vim` a lot and when I learned about [vimwiki](https://githbu.com/vimwiki/vimwiki) I immediately migrated all my notes into the local folder on my computer.
It provides you with much broader functionality than just keeping notes - well, this website is build using `vimwiki`, but I won't go into details here, because I plan to do a separate article about it.

Also, vimwiki provides you with folder hierarchy for free! Why overuse any other software when your filesystem has it covered?


# Discovering TaskWarrior
After using `TickTick` for two years, I finally discovered [TaskWarrior](https://taskwarrior.org):
 - Terminal application (*but it has frontends if you can't live without it*)
 - Deadly simple
 - Data is stored locally
 - Scriptable and hackable
 - Methodology-agnostic
 - Focused on doing one thing

<p align="center">
<img src="https://upload.wikimedia.org/wikipedia/en/5/59/Taskwarrior_logo.png">
</p>

When I saw it first time - I knew that was it.  You see, since I was already not keeping notes in `TickTick`, I was only using it only to keep track of my tasks. And `TaskWarrior` actually does a better job in managing tasks - it's the software that follows *Unix philosophy* - **it does one thing and does it well**.

I won't do a guide about `TaskWarrior` here, because they have an amazing documentation on their website. I suggest you go ahead and [learn this powerful tool](https://taskwarrior.org/docs/30second.html) in 30 seconds!

# Choosing methodology
Having `TaskWarrior` ready, you may get stunned by the amount of choice you have in managing your tasks. It's time to choose a methodology and stick to it. I prefer [Getting Things Done](https://hamberg.no/gtd) (or **GTD**) - it has a very precise set of rules that you have to follow and they acutally make sense.

**GTD** is focused, well, on *getting things done*. It's a general approach to organizing tasks and projects. I'd say it's an **interface** which can have multiple **implementations** (like in `TickTick`, `Google Calendar`, `TaskWarrior` etc.).
It's aim is to make you have 100% trust in a system for collecting tasks, ideas, and projects.

Main advantage of **GTD** is that it only works with **actionable** visible items. E.g. you don't keep a task `Get a driver lisence` - it's stupid from such point of view. "Do I get it right now or what?" Instead you create a project `driver-lisence` with following tasks:
 - Ask Michael to recommend a driving course
 - Assign to driving course
 - Pass rules exam
 - Pass driving exam
 - Pass final exam

Hopefully you get the point. Learn more about GTD [here](https://hamberg.no/gtd).

# Putting it all together
`TaskWarrior` + `vimwiki` is an ultimate replacement for `TickTick` or any other productivity tool you can imagine. **GTD** eliminates the problem with calendar - according to **GTD**, you only assign deadlines to the tasks that actually have them. With that considered, TaskWarrior's built-in calendar works perfectly.

And the good thing is: you don't need be using `vimwiki` for it to work - you can write your notes any way you like (*I actually suggest pen & paper*). The same for methodology - if you don't like *GTD* - choose any system that fits you (or adapt already existing one). The point is: **TaskWarrior will play nicely with everything**. It's an ultimate tool that you only have to learn once in your life.

# PS
There's also **TimeWarrior**, but I recommend getting familliar with **TaskWarrior** first. The main difference - TaskWarrior focuses on the tasks you have to do in future, while TimeWarrior analyzes the past.

I will do an artcile focused specifically on my productivity workflow later, stay tuned!
