package main

import (
	"net/http"
	"testing"
)

func Test_echoAllTheThings(t *testing.T) {
	type args struct {
		writer  http.ResponseWriter
		request *http.Request
	}
	tests := []struct {
		name string
		args args
	}{
		// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			echoAllTheThings(tt.args.writer, tt.args.request)
		})
	}
}
