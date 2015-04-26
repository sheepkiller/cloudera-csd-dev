package main

import (
	"io"
	"log"
	"net/http"
	"os"
)

// hello world, the web server
func PrintVar(w http.ResponseWriter, req *http.Request) {
	for _, e := range os.Environ() {
		io.WriteString(w, e+"\n")
	}
}

func PrintIndex(w http.ResponseWriter, req *http.Request) {
	Index := `
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>CSD_DEV</title>
</head>
<body>
  <h1>Links</h1>
  <li><a href="/env">Print environment variables</a></li>
  <li><a href="/files/">Browse Files in current directory</a></li>
</body>
</html>
`
	io.WriteString(w, Index)
}
func main() {
	cwd := os.Getenv("PWD")
	if cwd == "" {
		log.Fatal("PWD env var is not set")
	}
	http.HandleFunc("/env", PrintVar)
	http.HandleFunc("/", PrintIndex)
	http.Handle("/files/", http.StripPrefix("/files", http.FileServer(http.Dir("."))))
	port := os.Getenv("PORT")
	if port == "" {
		log.Fatal("PORT env var is not set")
	}
	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
