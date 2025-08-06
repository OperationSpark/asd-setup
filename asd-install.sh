# this script most recently updated/maintained in august 2025
# extract username from current working directory (expects format: username.github.io)
current_dir=$(basename "$PWD")
username="${current_dir%%.*}"

if [ -d "project-instructions/asd" ]; then
  echo "The script has already been run. Please ask your instructor for assistance."
  exit 1
fi

# clone student-owned asd-projects repo
git clone https://github.com/$username/asd

# remove git references from cloned repo if the asd folder exists
if [ -d "asd" ]; then
  echo "Preparing asd projects and instructions..."
else
  echo "asd folder does not exist. Cancelling operation."
  echo "Please check with your instructor to help troubleshoot."
  exit 1
fi

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
