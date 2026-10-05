package unleash

import (
	"fmt"
	"os"
	"path/filepath"
)

func unleash() {
	// Get the current working directory
	workingDir, err := os.Getwd()
	if err != nil {
		fmt.Println("Error getting current working directory:", err)
		return
	}
	// Get the absolute path of the current working directory
	absPath, err := filepath.Abs(workingDir)
	if err != nil {
		fmt.Println("Error getting absolute path:", err)
		return
	}
	// Print the absolute path
	fmt.Println("Absolute path of the current working directory:", absPath)
}
