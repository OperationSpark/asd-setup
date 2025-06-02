# Set up your Github Codespace

Below, you will find instructions for adding the ASD course's projects into your repository. Read all instructions carefully before moving on. If you get stuck, encounter an issue, or simply need help, reach out to your instructor.

## Step 0: Pre-requisites:

Before continuing on to the next steps, make sure that you have done the following:

- Created an account on Greenlight
- Created an account on GitHub
- Joined the OperationSpark GitHub Team

All of the above should already have been done if you are in the advanced course, but if they are not, see the <a href="https://github.com/OperationSpark/fsd-setup">fsd-setup instructions</a> for how to do so.

<br><br><br>

## Step 1: Create New Repository

- Right click [this link](https://github.com/new?template_name=asd-projects-template&template_owner=OperationSpark) and select "Open Link in New Tab".
- Ensure that `"OperationSpark/asd-projects-template"` is the selected template in the "Repository template" dropdown.
- Click the "Choose an owner" dropdown and select your username
- Name your new repository `asd` in the "Repository name" input
  - **Important**: this name should be all lowercase, and without any spaces or symbols
- Confirm with your teacher that all setup steps are complete before clicking "Create repository" at the bottom of the page
- The repository will take 10-15 seconds to load (since code is being copied from another spot). After the repsitory is set up, you can close the tab that contains your newly created repository and switch back to your codespace

<br><br><br>

## Step 2: Open Your GitHub Codespace

- Go to [GitHub Codespaces](https://github.com/codespaces). Scroll to the bottom of the webpage and open your existing GitHub codespace for your `.github.io` repository.
- If you do not have a GitHub codespace, you can create a new one through the green "New Codespace" button at the top right of the page.
  - If you create a new codespace, you'll need to install the `"Prettier"` and `"Live Server"` extensions. [Find documentation for adding extensions here](https://docs.github.com/en/codespaces/getting-started/quickstart#personalizing-with-an-extension).

<br><br><br>

## Step 3: Add Script to Install New Projects

**NOTE**: If your repo already contains a `scripts` folder with a `asd-install.sh` file inside of it, skip ahead to [Step 4](#step-4-install-asd-projects-into-codespace)

Copy and paste each of the following commands into your codespace's terminal, pressing enter after pasting each command to run it.

```bash copy
mkdir scripts
```

```bash copy
printf "# this script most recently updated/maintained in may 2025\n\n# clone student-owned asd-projects repo\ngit clone https://github.com/\$1/asd\n\n# remove git references from cloned repo if the asd folder exists\nif [ -d \"asd\" ]; then\n  echo \"Preparing asd projects and instructions...\"\nelse\n  echo \"asd folder does not exist. Cancelling operation.\"\n  echo \"Please check with your instructor to help troubleshoot.\"\n  exit 1\nfi\n\ncd asd\nrm -rf .git*\ncd ..\n\n# create subfolders in project-instructions folder\nmv project-instructions fsd\nmkdir project-instructions\nmv fsd project-instructions/\nmv asd/project-instructions project-instructions/asd/\n\n# move asd projects to root\nmv asd/asd-projects asd-projects/\n\n# remove cloned asd repo once all projects are installed\nrm -rf asd" > scripts/asd-install.sh
```

<br><br><br>

## Step 4: Install ASD Projects into Codespace

Copy and paste the following command into your terminal, then press enter.

```bash copy
chmod +x scripts/asd-install.sh
```

Type out the following command into the terminal, **making sure to modify it to include your GitHub username**, and then press enter.

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
    <li><a href="asd-projects/sorting">Sorting Exercise: An exercise on sorting algorithms</a></li>
</ul>
```

Open your home page with Live Server, navigate to your portfolio, and ensure that the new links work before moving on.

<br><br><br>

## Step 6 - Push Up Your Code

Run the following commands in your terminal to push up your code to GitHub.

- `git add .`
- `git commit -m "add ASD projects"`
- `git push`
