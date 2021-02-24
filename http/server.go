package main

import (
	"encoding/json"
	"github.com/segmentio/ksuid"
	"net/http"
)

type Order struct {
	Id      string `json:"id,omitempty"`
	Flavour string `json:"flavour,omitempty"`
	Size    string `json:"size,omitempty"`
}

type OrderService struct {
	storage Storage
}

func (service *OrderService) createOrder(res http.ResponseWriter, req *http.Request) {
	var order Order
	err := json.NewDecoder(req.Body).Decode(&order)
	if err != nil {
		http.Error(res, err.Error(), http.StatusBadRequest)
		return
	}

	order.Id = ksuid.New().String()
	err = service.storage.CreateOrder(order)
	if err != nil {
		http.Error(res, err.Error(), http.StatusInternalServerError)
		return
	}

	js, err := json.Marshal(order)
	if err != nil {
		http.Error(res, err.Error(), http.StatusInternalServerError)
		return
	}
	res.Write(js)
}

func main() {
	storage := NewStorage()
	service := OrderService{storage}
	http.HandleFunc("/orders/create", service.createOrder)

	err := http.ListenAndServe(":9292", nil)
	if err != nil {
		panic(err)
	}
}
