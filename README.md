# Set up your Github / Gitpod Workspace

Below, you will find instructions for creating a github repository and setting up your Gitpod workspace. Read all instructions carefully before moving on. If you get stuck, encounter an issue, or simply need help, reach out to your instructor immediately.

## 0) Pre-requisites:

Before continuing on to the next steps, make sure that you have done the following:

- Created a personal email account on Gmail.
- Created an account on Greenlight
- Created an account on GitHub
- Created an account on Gitpod
- Joined the Operation Spark GitHub Team

All of the above should already have been done if you are in the advanced course, but if they are not, see the <a href="https://github.com/OperationSpark/fsd-setup">fsd-setup instructions</a> for how to do so.

## 1) Install your projects

Open your Gitpod workspace. With your workspace open, find the bash terminal and enter these commands one at a time:

- `git clone https://github.com/OperationSpark/asd-setup.git`
- `chmod +x asd-setup/setup.sh`
- `./asd-setup/setup.sh`
- `rm -rf ./asd-setup`

## 2) Update your Portfolio

Open your `portfolio.html` file. Below the `<h1>Portfolio</h1>` tags, add a `<h2>Fundamentals Projects</h2>` element.

Below the closing `</ul>` tag inside of the `main` element, add the following html:

```HTML
<h2>Advanced Projects</h2>
<ul id ="portfolio">
    <li><a href="asd-projects/data-shapes"> Data Shapes: Iteration practice with patterns</a></li>
    <li><a href="asd-projects/debugging-exercise"> Debugging Exercise: A debugging exercise</a></li>
    <li><a href="asd-projects/snake">Snake: Feed the snake or be fed upon</a></li>
    <li><a href="asd-projects/walker">Walker: Practice user input by animating walking boxes</a></li>
    <li><a href="asd-projects/image-filtering">Image Filtering: Filter images using loops</a></li>
    <li><a href="asd-projects/sorting-exercise">Sorting Exercise: An exercise on sorting algorithms</a></li>
</ul>
```

## 3) Push your code

Down in the bash terminal, enter these commands:

`git add -A`

`git commit -m "add ASD projects and update portfolio"`

`git push`
