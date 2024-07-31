# Stage 1: Build the Go app
# Creating a Alias for Golang
# The version is important here
FROM golang:1.22.5 AS base

WORKDIR /app

# Dependencies of a Go application are stored in a go.mod file
COPY go.mod .

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy everything from the current directory to the working Directory inside the container
COPY . .

# Build the Go app
RUN go build -o main .

# Stage 2: Distroless image
FROM gcr.io/distroless/base

# Copy the Pre-built binary file from the Stage 1
COPY --from=base /app/main .

# Copying the static files, they are not bundled in the binary
# Therefore, we need to copy them manually
COPY --from=base /app/static /static

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
