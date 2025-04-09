// file: src/main.rs
use axum::{ routing::get, Router };
use tokio::sync::broadcast;
use std::net::SocketAddr;

mod handlers;
mod websocket;

#[tokio::main]
async fn main() {
    // Create channel for WebSocket communication
    let (tx, _) = broadcast::channel(100);
    
    // Build our application with the routes and shared state
    let app = Router::new()
        .route("/", get(handlers::index))
        .route("/ws", get(handlers::ws_handler))
        .with_state(tx);

    // Run the server
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3030").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}
