package main

import (
	"fmt"
	"log/slog"
	"net/http"
)

func main() {
	slog.Info("starting the silly dogu")
	handleRequests()
}

func handleRequests() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", echoAllTheThings)

	adressAndPort := ":8080"
	err := http.ListenAndServe(adressAndPort, mux)
	slog.Error(err.Error())

}

func echoAllTheThings(w http.ResponseWriter, r *http.Request) {
	slog.Info("request incoming", "request", r.URL.String())
	defer r.Body.Close()

	w.WriteHeader(http.StatusOK)
	_, _ = fmt.Fprintf(w, fmt.Sprintf("Echo: %s", r.URL.String()))
}
