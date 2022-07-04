// SPDX-License-Identifier: MIT
/*
 *
 * This file is part of termux-container, with ABSOLUTELY NO WARRANTY.
 *
 * MIT License
 *
 * Copyright (c) 2022-2023 Moe-hacker
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 *
 *
 */
// This is a very simple implementation of a shell.
// It can do:
// Built in commands highlighting.
// Up/Down to show history.
// Call to termux-container.
// It works, so do not touch anything.

package main

import (
	"bufio"
	"fmt"
	"github.com/charmbracelet/bubbles/textinput"
	tea "github.com/charmbracelet/bubbletea"
	"golang.org/x/sys/unix"
	"os"
	"os/exec"
	"strings"
	"syscall"
)

// Edit this list to use it in your own program.
// Built in command list, for highlighting.
var list []string = []string{"help", "exit", "new", "search", "pull", "rmi", "cp", "ls", "rm", "login", "import", "export", "info"}

// File to store history command.
var historyfile = "/data/data/com.termux/files/home/.container_history"

type (
	errMsg error
)

type model struct {
	textInput   textinput.Model
	historyline int
	err         error
}

// Configure the console.
func initialModel() model {
	ti := textinput.New()
	ti.Focus()
	// Limitation
	ti.CharLimit = 256
	ti.Width = 20
	// The prompt of console.
	ti.Prompt = "\033[1;38;2;254;228;208m[] container@termux >\033[0m "
	ti.Cursor.Blink = false
	return model{
		textInput:   ti,
		historyline: 1,
		err:         nil,
	}
}

// Show greetings.
func init() {
	ws, err := unix.IoctlGetWinsize(syscall.Stdout, unix.TIOCGWINSZ)
	if err != nil {
		panic(err)
	}
	wscol := int(ws.Col)
	if wscol%2 == 1 {
		wscol -= 1
	}
	// For centering output.
	space := ""
	if wscol > 46 {
		wscol /= 2
		wscol -= 22
		for i := 1; i <= wscol; i++ {
			space += " "
		}
	}
	fmt.Printf("%s%s\n", space, "\033[1;38;2;66;66;66m               ▅▅▀▀▀▀▀▀▀▀▀▀▀▀▅")
	fmt.Printf("%s%s\n", space, "          ▅▅▀▀▀               ▀▀▅▅")
	fmt.Printf("%s%s\n", space, "     ▅▅▅▀▀            ▅           ▀▅")
	fmt.Printf("%s%s\n", space, "      ▅▀      ▅▀█▅▅▀▀▅▀▅        ▅▅  ▀▅")
	fmt.Printf("%s%s\n", space, "     ▅▀   █▅▀▀  ▀     ▀ ▀▀▅▅    █ ▀▀▅ █")
	fmt.Printf("%s%s\n", space, "    ▅▀   ▅▀  ▅▀      ▀▅    ▀▅   █▅███▀█")
	fmt.Printf("%s%s\n", space, "  ▅▅█▀▅ █ ▅▅▀          ▀▀   █   ████   █")
	fmt.Printf("%s%s\n", space, "      █ █ ▅▅▅▅▅        ▅▅▅▅▅ █  ▀█▀    █")
	fmt.Printf("%s%s\n", space, "      █ █▀ ▅▅▅ ▀      ▀ ▅▅▅ ▀█   █     █")
	fmt.Printf("%s%s\n", space, "      █ █ █\033[40;31m█▀█\033[0m\033[1;38;2;66;66;66m█        █\033[40;31m█▀█\033[0m\033[1;38;2;66;66;66m█ █   █     █")
	fmt.Printf("%s%s\n", space, "     █  █ █\033[31m███\033[1;38;2;66;66;66m█        █\033[31m███\033[1;38;2;66;66;66m█ █   █     ▀▅")
	fmt.Printf("%s%s\n", space, "    ▅▀  █  ▀▀▀          ▀▀▀  █   █      █")
	fmt.Printf("%s%s\n", space, "  ▅▀▅▀ █                     █   █      █")
	fmt.Printf("%s%s\n", space, " █   █ ▀▅ ▅▀▅   ▅▀▅   ▅▅     █   █      ▀▅")
	fmt.Printf("%s%s\n", space, "▅█▅▅██▅ ▅██  ▀███ ▅████ ▀▅█▀▅▀   █       ▀▅")
	fmt.Printf("%s%s\n", space, "███████ ▀██████████████████▀▀             █")
	fmt.Printf("%s%s\n", space, " █    ▀▅  ██▀ ▀██▀▀██▀▀██▀█     █▀         █")
	fmt.Printf("%s%s\n", space, " ▀▅     ▀▀█              ▅▀     █          █")
	fmt.Printf("%s%s\n", space, "   ▀▅    █               █     ██        ▅▀")
	fmt.Printf("%s%s\n", space, "     ▀▅▅▅▀                ▀▀▀▀▀ █        █")
	fmt.Printf("%s%s\n", space, "        ▀                       ▀        ▀")
	fmt.Printf("%s\n", "\033[1;38;2;254;228;208m")
	fmt.Printf("%s%s\n", space, "       The Console Of Termux-container")
	fmt.Printf("%s%s\n", space, "          Made With  By Moe-hacker")
	fmt.Printf("%s%s\n", space, "            Powered By Bubble Tea")
	fmt.Printf("%s%s\n", space, "          WARNING: NO WARRANTY HERE")
	fmt.Printf("%s%s\n", space, "            Type `help` For Usage\033[0m")

}
func (m model) Init() tea.Cmd {
	return nil
}

// How we use the key pressed.
func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	var cmd tea.Cmd
	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.Type {
		case tea.KeyEnter:
			to_exec := m.textInput.Value()
			fmt.Printf("%s\n", strings.ReplaceAll(m.View(), "\033[7m", ""))
			m.textInput.SetValue("")
			m.historyline = 1
			return m, execCommand(to_exec)
		// Exit.
		case tea.KeyCtrlD, tea.KeyCtrlC:
			m.textInput.SetValue("exit")
			return m, tea.Quit
		case tea.KeyUp:
			m.historyline++
			m.textInput.SetValue(Readline(m.historyline))
			m.textInput.CursorEnd()
		case tea.KeyDown:
			m.historyline--
			m.textInput.SetValue(Readline(m.historyline))
		}
	case errMsg:
		m.err = msg
		return m, nil
	}
	m.textInput, cmd = m.textInput.Update(msg)
	return m, cmd
}

// Read history file.
func Readline(linenumber int) string {
	file, _ := os.Open(historyfile)
	filescanner := bufio.NewScanner(file)
	total_lines := 1
	for filescanner.Scan() {
		total_lines++
	}
	file.Close()
	file, _ = os.Open(historyfile)
	filescanner = bufio.NewScanner(file)
	linenumber = total_lines - linenumber
	if linenumber < 0 {
		linenumber = 1
	}
	if linenumber > total_lines {
		linenumber = total_lines
	}
	linecount := 0
	for filescanner.Scan() {
		if linecount == linenumber {
			file.Close()
			return filescanner.Text()
		}
		linecount++
	}
	file.Close()
	return ""
}

// Run the command.
func execCommand(cmd string) tea.Cmd {
	if cmd == "" {
		return nil
	}
	// Write history file.
	f, _ := os.OpenFile(historyfile, os.O_WRONLY|os.O_CREATE|os.O_APPEND, 0666)
	f.WriteString(cmd + "\n")
	// Command to execute.
	c := exec.Command("/data/data/com.termux/files/usr/bin/bash", "-c", "container -e container_console_main "+cmd)
	out, _ := c.CombinedOutput()
	fmt.Printf("%s", string(out))
	fmt.Printf("%s", "\n")
	return tea.ExecProcess(c, func(err error) tea.Msg {
		return nil
	})
}
func (m model) View() string {
	view := strings.Fields(m.textInput.View())
	value := strings.Fields(m.textInput.Value())
	var ret string
	if len(value) == 0 {
		ret = m.textInput.View()
	} else {
		/*
		 * As we need to highlight the built in commands,
		 * we need to edit the m.textInput.Value()
		 * The following value 3 is based on the parts of prompt + 1
		 * for example, the prompt is "[] container@termux >"
		 * then set it to 3
		 * the prompt is "">"
		 * then set it to 1.
		 */
		ret += "\033[0m" + m.textInput.Prompt
		highlight := false
		for j := 0; j < len(list); j++ {
			if value[0] == list[j] {
				ret += "\033[1;38;2;152;245;225m" + strings.ReplaceAll(view[3], "\033[0m", "\033[0m\033[1;38;2;152;245;225m") + " " + "\033[0m"
				highlight = true
				break
			}
		}
		if highlight == false {
			ret += "\033[1m" + view[3] + " " + "\033[0m"
		}
		for i := 1; i < len(value); i++ {
			ret += "\033[1m" + view[i+3] + " " + "\033[0m"
		}
		if m.textInput.Value()[len(m.textInput.Value())-1] == ' ' {
			ret += "\033[7m \033[0m"
		}
	}
	return ret
}

// The console.
func main() {
	print("\n")
	p := tea.NewProgram(initialModel())
	_, err := p.Run()
	if err != nil {
		fmt.Println("Error:", err)
	}
}
