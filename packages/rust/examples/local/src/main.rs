use graph_networks::NetworksRegistry;

fn main() {
    let url = NetworksRegistry::get_latest_version_url();
    println!("Latest version URL: {}", url);

    let registry: NetworksRegistry = NetworksRegistry::from_file("TheGraphNetworksRegistry_v0_5_3.json")
        .expect("Failed to parse registry");

    println!("Successfully loaded {} networks", registry.networks.len());

}