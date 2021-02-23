package main

import (
	"fmt"
	"net/http"
)

func createOrder(res http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(res, "hello\n")
}

func main() {
	http.HandleFunc("/orders/create", createOrder)
	http.ListenAndServe(":8090", nil)
}
