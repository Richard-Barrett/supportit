package main

import (
	"fmt"
	"os"

	"github.com/Richard-Barrett/supportit/cmd"
)

func main() {
	if err := cmd.NewLabCommand().Execute(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	os.Exit(0)
}