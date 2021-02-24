package main

import (
	"database/sql"
	_ "github.com/lib/pq"
)

type Storage struct {
	db *sql.DB
}

func NewStorage() Storage {
	db, err := sql.Open("postgres", "database=pancakes user=postgres password=pancakes sslmode=disable")
	if err != nil {
		panic(err)
	}
	return Storage{db}
}

func (s *Storage) CreateOrder(order Order) error {
	const query = "INSERT INTO orders(id, flavour, size) VALUES ($1, $2, $3);"
	if _, err := s.db.Exec(query, order.Id, order.Flavour, order.Size); err != nil {
		return err
	}
	return nil
}
