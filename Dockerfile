FROM golang:1.21 as base

WORKDIR /app

COPY go.mod go.sum ./