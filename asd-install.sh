#!/bin/bash
# ASD Projects Installer - Pre-bundled Version
# Usage: curl -sSL https://raw.githubusercontent.com/OperationSpark/asd-setup/main/asd-install.sh | bash

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SETUP_REPO="OperationSpark/asd-setup"
TEMP_DIR="temp-asd-$$"

# Logging functions
log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }

# Main installation function
install_asd_projects() {
    log_info "ASD Projects Installer - Pre-bundled Version"
    echo "=================================================="
    log_info "This installer downloads pre-bundled template files - no authentication needed!"
    echo
    
    # Step 1: Validate environment
    validate_environment
    
    # Step 2: Extract username and validate
    USERNAME=$(extract_username)
    log_info "Detected username: $USERNAME"
    
    # Step 3: Check for existing installation
    check_existing_installation
    
    # Step 4: Download pre-bundled template files
    download_template_files
    
    # Step 5: Update portfolio
    update_portfolio
    
    # Step 6: Commit and push changes
    commit_changes
    
    # Step 7: Final success message
    show_completion_message
}

# Validate that we're in the right environment
validate_environment() {
    log_info "Validating environment..."
    
    # Check if we're in a .github.io directory
    if [[ ! "$PWD" =~ \.github\.io$ ]]; then
        log_error "This script must be run from your .github.io directory"
        log_error "Current directory: $(basename "$PWD")"
        log_error "Expected format: username.github.io"
        exit 1
    fi
    
    # Check if git is available
    if ! command -v git &> /dev/null; then
        log_error "Git is not installed or not in PATH"
        exit 1
    fi
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        log_error "Not in a git repository. Please ensure you're in your .github.io repo"
        exit 1
    fi
    
    # Check if curl is available
    if ! command -v curl &> /dev/null; then
        log_error "curl is not installed or not in PATH"
        exit 1
    fi
    
    log_success "Environment validation passed"
}

# Extract username from current directory
extract_username() {
    local current_dir=$(basename "$PWD")
    
    if [[ "$current_dir" =~ ^([^.]+)\.github\.io$ ]]; then
        echo "${BASH_REMATCH[1]}"
    else
        log_error "Could not extract username from directory: $current_dir"
        log_error "Directory must be in format: username.github.io"
        exit 1
    fi
}

# Check if ASD projects are already installed
check_existing_installation() {
    if [ -d "asd-projects" ]; then
        log_warning "ASD projects directory already exists"
        read -p "Do you want to reinstall? This will overwrite existing projects (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Installation cancelled"
            exit 0
        fi
        log_info "Removing existing installation..."
        rm -rf asd-projects
        rm -rf project-instructions/asd 2>/dev/null || true
    fi
}

# Download pre-bundled template files
download_template_files() {
    log_info "Downloading pre-bundled ASD template files..."
    log_info "Source: github.com/$SETUP_REPO/template-files/"
    
    # Create temporary directory
    mkdir -p "$TEMP_DIR"
    
    # Download the template files as a zip
    log_info "Downloading template archive..."
    if ! curl -L -s "https://github.com/$SETUP_REPO/archive/refs/heads/main.zip" -o "$TEMP_DIR/template.zip"; then
        log_error "Failed to download template files from: https://github.com/$SETUP_REPO"
        log_error "This might be a network issue. Please try again in a moment."
        cleanup_temp_files
        exit 1
    fi
    
    # Extract the zip file
    log_info "Extracting template files..."
    if ! command -v unzip &> /dev/null; then
        log_error "unzip is not installed. Installing template files requires unzip."
        cleanup_temp_files
        exit 1
    fi
    
    cd "$TEMP_DIR"
    if ! unzip -q template.zip; then
        log_error "Failed to extract template files"
        cd ..
        cleanup_temp_files
        exit 1
    fi
    cd ..
    
    # Find the extracted directory (will be asd-setup-setup-revamp or asd-setup-main)
    local extracted_dir=$(find "$TEMP_DIR" -maxdepth 1 -type d -name "*asd-setup*" | head -n 1)
    if [ -z "$extracted_dir" ]; then
        log_error "Could not find extracted template directory"
        cleanup_temp_files
        exit 1
    fi
    
    log_info "Setting up project structure..."
    
    # Move ASD projects to root
    if [ -d "$extracted_dir/template-files/asd-projects" ]; then
        mv "$extracted_dir/template-files/asd-projects" ./
        log_success "ASD projects installed from pre-bundled template"
    else
        log_error "asd-projects directory not found in template files"
        log_error "Expected location: $extracted_dir/template-files/asd-projects"
        cleanup_temp_files
        exit 1
    fi
    
    # Setup project instructions
    setup_project_instructions "$extracted_dir"
    
    # Cleanup
    cleanup_temp_files
}

# Setup project instructions directory structure
setup_project_instructions() {
    local extracted_dir="$1"
    
    log_info "Setting up project instructions..."
    
    # Create project-instructions structure if needed
    if [ ! -d "project-instructions/asd" ]; then
        # If project-instructions exists but no asd subfolder
        if [ -d "project-instructions" ]; then
            # Rename existing to fsd if it contains FSD projects
            if [ ! -d "project-instructions/fsd" ]; then
                log_info "Reorganizing existing project instructions..."
                mv project-instructions temp-fsd
                mkdir project-instructions
                mv temp-fsd project-instructions/fsd
            fi
        else
            mkdir -p project-instructions
        fi
        mkdir -p project-instructions/asd
    fi
    
    # Move ASD instructions
    if [ -d "$extracted_dir/template-files/project-instructions" ]; then
        cp -r "$extracted_dir/template-files/project-instructions"/* project-instructions/asd/ 2>/dev/null || true
        log_success "Project instructions organized"
    fi
}

# Update portfolio.html with ASD projects
update_portfolio() {
    log_info "Updating portfolio.html..."
    
    if [ ! -f "portfolio.html" ]; then
        log_error "portfolio.html not found in current directory"
        log_error "Please ensure you're in your .github.io repository root"
        exit 1
    fi
    
    # Check if ASD projects are already in portfolio
    if grep -q "Advanced Projects" portfolio.html; then
        log_warning "Advanced Projects section already exists in portfolio"
        log_info "Skipping portfolio update"
        return 0
    fi
    
    # Create backup
    cp portfolio.html portfolio.html.backup
    log_info "Created backup: portfolio.html.backup"
    
    # Add "Fundamentals Projects" header if missing
    if ! grep -q "Fundamentals Projects" portfolio.html; then
        log_info "Adding Fundamentals Projects header..."
        sed -i.bak '/<h1>Portfolio<\/h1>/a\
          <h2>Fundamentals Projects</h2>' portfolio.html
    fi
    
    # Use Python to reliably update the HTML
    python3 -c "
import sys, re

try:
    with open('portfolio.html', 'r') as f:
        content = f.read()
except Exception as e:
    print('Error reading portfolio.html:', e)
    sys.exit(1)

# ASD projects HTML
asd_html = '''          <h2>Advanced Projects</h2>
          <ul id=\"portfolio\">
            <li>
              <a href=\"asd-projects/data-shapes\">
                Data Shapes: Iteration practice with patterns</a>
            </li>
            <li>
              <a href=\"asd-projects/debugging-exercise\">
                Debugging Exercise: A debugging exercise</a>
            </li>
            <li>
              <a href=\"asd-projects/snake\">Snake: Feed the snake or be fed upon</a>
            </li>
            <li>
              <a href=\"asd-projects/walker\">
                Walker: Practice user input by animating walking boxes</a>
            </li>
            <li>
              <a href=\"asd-projects/image-filtering\">
                Image Filtering: Filter images using loops</a>
            </li>
            <li>
              <a href=\"asd-projects/sorting\">
                Sorting Exercise: An exercise on sorting algorithms</a>
            </li>
          </ul>
          <h2>Mini Projects</h2>
          <ul id=\"portfolio\">
            <li>
              <a href=\"asd-projects/dice-app\">
                Dice App: A simple, interactive dice app built using jQuery</a>
            </li>
          </ul>'''

# Find the last closing </ul> before the closing </div> of main content
pattern = r'(\s*</ul>\s*)(\s*</div>\s*</main>)'

if re.search(pattern, content):
    new_content = re.sub(pattern, r'\1' + asd_html + r'\n\2', content)
    try:
        with open('portfolio.html', 'w') as f:
            f.write(new_content)
        print('SUCCESS')
    except Exception as e:
        print('Error writing portfolio.html:', e)
        sys.exit(1)
else:
    print('PATTERN_NOT_FOUND')
    sys.exit(1)
" 2>/dev/null

    local update_result=$?
    
    if [ $update_result -eq 0 ]; then
        log_success "Portfolio updated with ASD projects"
        rm -f portfolio.html.backup portfolio.html.bak
    else
        log_warning "Could not automatically update portfolio.html"
        log_info "Please manually add the ASD projects section to your portfolio"
        # Restore backup if update failed
        if [ -f "portfolio.html.backup" ]; then
            mv portfolio.html.backup portfolio.html
        fi
        return 1
    fi
}

# Cleanup temporary files
cleanup_temp_files() {
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
        log_info "Cleaned up temporary files"
    fi
}

# Commit and push changes
commit_changes() {
    log_info "Committing changes to git..."
    
    # Check if there are any changes to commit
    if git diff --quiet && git diff --cached --quiet; then
        log_info "No changes to commit"
        return 0
    fi
    
    # Add all changes
    git add .
    
    # Commit with descriptive message
    if git commit -m "feat: add ASD projects and update portfolio

- Added ASD project files to asd-projects/ (from pre-bundled template)
- Organized project instructions in project-instructions/asd/
- Updated portfolio.html with Advanced Projects and Mini Projects sections
- Installed via streamlined ASD installer script"; then
        log_success "Changes committed successfully"
    else
        log_error "Failed to commit changes"
        return 1
    fi
    
    # Attempt to push changes
    log_info "Pushing changes to GitHub..."
    if git push; then
        log_success "Changes pushed to GitHub successfully"
    else
        log_warning "Failed to push changes automatically"
        log_info "Please run 'git push' manually when ready"
        return 1
    fi
}

# Show completion message and next steps
show_completion_message() {
    echo
    log_success "🎉 ASD Projects installation completed successfully!"
    echo
    log_info "What was installed:"
    log_info "  ✓ ASD project files in 'asd-projects/' directory"
    log_info "  ✓ Project instructions in 'project-instructions/asd/'"
    log_info "  ✓ Updated portfolio.html with new project links"
    log_info "  ✓ Changes committed and pushed to GitHub"
    echo
    log_info "📁 Projects installed from pre-bundled template:"
    log_info "  • Data Shapes"
    log_info "  • Debugging Exercise" 
    log_info "  • Snake"
    log_info "  • Walker"
    log_info "  • Image Filtering"
    log_info "  • Sorting Exercise"
    log_info "  • Dice App"
    echo
    log_info "Next steps:"
    log_info "  1. Open Live Server to view your updated portfolio"
    log_info "  2. Test the new project links to ensure they work"
    log_info "  3. Begin working on your ASD projects!"
    echo
    log_info "Need help? Contact your instructor or check the project instructions."
    echo
}

# Handle script interruption
cleanup_on_exit() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log_error "Installation interrupted or failed"
        log_info "Cleaning up any temporary files..."
        cleanup_temp_files
        if [ -f "portfolio.html.backup" ]; then
            log_info "Restoring portfolio.html backup..."
            mv portfolio.html.backup portfolio.html
        fi
    fi
    exit $exit_code
}

# Set up cleanup trap
trap cleanup_on_exit EXIT INT TERM

# Verify this script is being run correctly
if [ "$0" = "${BASH_SOURCE[0]}" ]; then
    install_asd_projects
elif [ -n "$BASH_VERSION" ]; then
    install_asd_projects  
else
    echo "This script should be run with bash"
    exit 1
fi