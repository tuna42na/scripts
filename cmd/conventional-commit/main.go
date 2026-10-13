package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"

	"github.com/charmbracelet/huh"
)

func getBranchInfo() (defaultPR string) {
	out, err := exec.Command("git", "rev-parse", "--abbrev-ref", "HEAD").Output()
	if err != nil {
		return ""
	}
	branch := strings.TrimSpace(string(out))
	parts := []string{}
	// Sometimes branch names are prefixed with a remote or category, e.g., "feature/ABC-123-description"
	if strings.Contains(branch, "/") {
		branch = strings.SplitN(branch, "/", 2)[0]
		parts = strings.SplitN(branch, "-", 3)
	} else if strings.Contains(branch, "-") {
		parts = strings.SplitN(branch, "-", 3)
	} else {
		parts = []string{"2na"}
	}
	if len(parts) >= 2 {
		return parts[0] + "-" + parts[1]
	}
	return branch
}

func main() {
	defaultPR := getBranchInfo()

	var (
		action         string
		pr             = defaultPR
		message        string
		breakingChange bool
	)

	commitTypes := []string{
		"build", "chore", "ci", "docs", "feat", "fix",
		"perf", "refactor", "revert", "style", "test",
	}
	typeOptions := make([]huh.Option[string], len(commitTypes))
	for i, t := range commitTypes {
		typeOptions[i] = huh.NewOption(t, t)
	}

	form := huh.NewForm(
		huh.NewGroup(
			huh.NewSelect[string]().
				Title("Commit type").
				Options(typeOptions...).
				Value(&action),
			huh.NewInput().
				Title("PR number").
				Placeholder(defaultPR).
				Value(&pr),
		), huh.NewGroup(
			huh.NewInput().
				Title("Commit message").
				Placeholder("added a commit message...").
				Value(&message),
			huh.NewConfirm().
				Title("Breaking change?").
				Affirmative("yup").
				Negative("nope").
				Value(&breakingChange),
		),
	)

	if err := form.Run(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	bang := ""
	if breakingChange {
		bang = "!"
	}

	commitMsg := fmt.Sprintf("[%s] %s%s: %s", pr, bang, action, message)
	fmt.Println("→", commitMsg)

	cmd := exec.Command("git", "commit", "-m", commitMsg)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		os.Exit(1)
	}
}
