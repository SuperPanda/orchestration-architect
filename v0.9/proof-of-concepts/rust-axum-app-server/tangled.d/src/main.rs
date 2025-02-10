// file: src/main.rs
use axum::{
    routing::{get, get_service},
    Router,
    response::Html
};
use std::sync::Arc;
use tokio::sync::broadcast;

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
        .with_state(Arc::new(tx));

    // Run the server
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3030").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}
