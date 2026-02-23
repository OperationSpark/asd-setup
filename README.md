# Set up your Github Codespace

Below, you will find instructions for adding the ASD course's projects into your repository. Read all instructions carefully before moving on. If you get stuck, encounter an issue, or simply need help, reach out to your instructor.

## Step 0: Pre-requisites:

Before continuing on to the next steps, make sure that you have done the following:

- Created an account on Greenlight
- Created an account on GitHub
- Joined the OperationSpark GitHub Team

All of the above should already have been done if you are in the advanced course, but if they are not, see the <a href="https://github.com/OperationSpark/fsd-setup">fsd-setup instructions</a> for how to do so.

<br><br><br>

## Step 1: Complete the ASD Setup TODO on Greenlight

Follow through the setup slides with your teacher to complete the following steps on Greenlight:

- Enter a join code for your ASD course (provided by your instructor)
- Complete the "ASD Setup" TODO on Greenlight. For this todo, you'll click the "Install ASD Projects" button, which will add a new set of projects to your GitHub repository in a new folder named `asd-projects`.

<br><br><br>

## Step 2: Open Your GitHub Codespace

- Go to [GitHub Codespaces](https://github.com/codespaces). Scroll to the bottom of the webpage and open your existing GitHub codespace for your `.github.io` repository.
- If you do not have a GitHub codespace, you can create a new one through the green "New Codespace" button at the top right of the page.
  - Select your `<username>.github.io` repository that you worked on in the FSD course as the target repo to create the codespace from.
  - If you create a new codespace, you'll need to install the `"Prettier"` and `"Live Server"` extensions. [Find documentation for adding extensions here](https://docs.github.com/en/codespaces/getting-started/quickstart#personalizing-with-an-extension).

<br><br><br>

## Step 3 - Pull your asd projects from your GitHub repository into your Codespace

In your Codespace terminal, type the following command, then press enter:

```bash copy
git pull
```

After running this command, confirm that your codespace now has a folder named `asd-projects`. If you do not see the folder, or if you encounter any errors, reach out to your instructor for help.

<br><br><br>

## Step 4 - Add Projects to Portfolio

In your Codespace, open your `portfolio.html` file. Below the `<h1>Portfolio</h1>` element, add a `<h2>Fundamentals Projects</h2>` element.

Next, find the closing `</ul>` tag just above the closing `</main>` tag. Below the closing '</ul>' tag, add the following html:

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
<h2>Mini Projects</h2>
<ul id ="portfolio">
    <li><a href="asd-projects/dice-app"> Dice App: A simple, interactive dice app built using jQuery</a></li>
</ul>
```

Open your home page with Live Server, navigate to your portfolio, and ensure that the new links work before moving on.

<br><br><br>

## Step 5 - Push Up Your Code

Run the following commands in your terminal to push up your code to GitHub.

- `git add .`
- `git commit -m "add ASD projects"`
- `git push`
