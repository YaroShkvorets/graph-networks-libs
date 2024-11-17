package main

import (
	"fmt"
	"log"

	registry "github.com/graphprotocol/networks-registry-libs/packages/golang"
)

func main() {
    // Load from local file
    reg, err := registry.FromFile("../../../../registry/TheGraphNetworksRegistry.json")
    if err != nil {
        log.Fatalf("Failed to load registry: %v", err)
    }
    fmt.Printf("Successfully loaded %d networks\n", len(reg.Networks))

    // Get network by ID
    if mainnet := reg.GetNetworkById("mainnet"); mainnet != nil {
        fmt.Printf("Found mainnet: %s\n", mainnet.FullName)
    }

    // Get network by alias
    if ethereum := reg.GetNetworkByAlias("eth"); ethereum != nil {
        fmt.Printf("Found ethereum by alias: %s\n", ethereum.FullName)
    }
}