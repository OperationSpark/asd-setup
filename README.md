# Set up your Github Codespace

Below, you will find instructions for adding the ASD course's projects into your repository. Read all instructions carefully before moving on. If you get stuck, encounter an issue, or simply need help, reach out to your instructor.

## Step 0: Pre-requisites:

Before continuing on to the next steps, make sure that you have done the following:

- Created an account on Greenlight
- Created an account on GitHub
- Joined the OperationSpark GitHub Team

All of the above should already have been done if you are in the advanced course, but if they are not, see the <a href="https://github.com/OperationSpark/fsd-setup">fsd-setup instructions</a> for how to do so.

<br><br><br>

## Step 1: Open Your GitHub Codespace

- Go to [GitHub Codespaces](https://github.com/codespaces). Scroll to the bottom of the webpage and open your existing GitHub codespace for your `.github.io` repository.
- If you do not have a GitHub codespace, you can create a new one through the green "New Codespace" button at the top right of the page.
  - If you create a new codespace, you'll need to install the `"Prettier"` and `"Live Server"` extensions. [Find documentation for adding extensions here](https://docs.github.com/en/codespaces/getting-started/quickstart#personalizing-with-an-extension).

<br><br><br>

## Step 2: Add Script to Install New Projects

**NOTE**: If your repo already contains a `scripts` folder with a `asd-install.sh` file inside of it, you can skip ahead to [Step 3](#step-3-create-new-repository)

Enter the following commands into your terminal one at a time to create a script that will run your

```bash copy
mkdir scripts
touch scripts/asd-install.sh
code scripts/asd-install.sh
```

Next, copy and paste the following code into your `asd-install.sh` file:

```bash copy
# clone student-owned asd-projects repo
git clone https://github.com/$1/asd

# remove git references from cloned repo
cd asd
rm -rf .git*
cd ..

# create subfolders in project-instructions folder
mv project-instructions fsd
mkdir project-instructions
mv fsd project-instructions/
mv asd/project-instructions project-instructions/asd/

# move asd projects to root
mv asd/asd-projects asd-projects/

# remove cloned asd repo once all projects are installed
rm -rf asd
```

<br><br><br>

## Step 3: Create New Repository

- Right click [this link](https://github.com/new?template_name=asd-projects-template&template_owner=OperationSpark) and select "Open Link in New Tab".
- Ensure that `"OperationSpark/asd-projects-template"` is the selected template in the "Repository template" dropdown.
- Click the "Choose an owner" dropdown and select your username
- Name your new repository `asd` in the "Repository name" input
  - **Important**: this name should be all lowercase, and without any spaces or symbols
- Confirm with your teacher that all setup steps are complete before clicking "Create repository" at the bottom of the page
- The repository will take 10-15 seconds to load (since code is being copied from another spot). After the repsitory is set up, you can close the tab that contains your newly created repository and switch back to your codespace

<br><br><br>

## Step 4: Install ASD Projects into Codespace

Back in your GitHub codespace, enter the following commandsDown in the bash terminal, enter these commands:

- `chmod +x scripts/asd-install.sh`

- `bash scripts/asd-install.sh YOUR_GITHUB_USERNAME`
  - For this command, replace the text `YOUR_GITHUB_USERNAME` with your actual GitHub username. Double check that your spelling is correct before running this command!

<br><br><br>

## Step 5 - Add Projects to Portfolio

Open your `portfolio.html` file. Below the `<h1>Portfolio</h1>` element, add a `<h2>Fundamentals Projects</h2>` element.

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

<br><br><br>

## Step 6 - Push Up Your Code

Run the following commands in your terminal to push up your code to GitHub.

- `git add -A`
- `git commit -m "add ASD projects"`
- `git push`
