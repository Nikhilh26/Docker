package main

import (
    "encoding/json"
    "fmt"
    "net/http"
    "os"

    "github.com/gorilla/mux"
    "github.com/joho/godotenv"
)

type User struct {
    ID   int    `json:"id"`
    Name string `json:"name"`
}

var users = []User{
    {ID: 1, Name: "Alice"},
    {ID: 2, Name: "Bob"},
    {ID: 3, Name: "Charlie"},
}

func helloHandler(w http.ResponseWriter, r *http.Request) {
    greeting := os.Getenv("GREETING")
    if greeting == "" {
        greeting = "Hello, World!"
    }
    fmt.Fprintln(w, greeting)
}

func getUsersHandler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(users)
}

func main() {
    // Load environment variables from .env file
    err := godotenv.Load()
    if err != nil {
        fmt.Println("Error loading .env file")
    }

    r := mux.NewRouter()
    r.HandleFunc("/", helloHandler).Methods("GET")
    r.HandleFunc("/users", getUsersHandler).Methods("GET")

    fmt.Println("Starting server on :8080")
    if err := http.ListenAndServe(":8080", r); err != nil {
        fmt.Println("Failed to start server:", err)
    }
}
