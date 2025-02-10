// [dependencies]
// axum = { version = "0.6", features = ["ws"] }
// tokio = { version = "1.0", features = ["macros", "rt-multi-thread"] }
// futures-util = "0.3"
// tokio-stream = "0.1"

=== START OF FILE: src/main.rs ===
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
=== END OF FILE: src/main.rs ===

=== START OF FILE: src/handlers.rs ===
// file: src/handlers.rs
use axum::{
    extract::{ws::WebSocketUpgrade, State},
    response::{Html, IntoResponse},
};
use tokio::sync::broadcast;

use crate::websocket::handle_websocket;

// Handler for serving HTML that reloads live
pub async fn index() -> Html<String> {
    // Read fresh version from disk on each request
    tokio::fs::read_to_string("static/index.html")
        .await
        .map(Html)
        .expect("Failed to read index.html")
}

// WebSocket handler with shared broadcast channel
pub async fn ws_handler(
    ws: WebSocketUpgrade,
    State(state): State<broadcast::Sender<String>>,
) -> impl IntoResponse {
    // Upgrade to WebSocket connection
    ws.on_upgrade(move |socket| handle_websocket(socket, state.clone()))
}
=== END OF FILE: src/handlers.rs ===

=== START OF FILE: src/websocket.rs ===
// file: src/websocket.rs
use axum::extract::ws::{Message, WebSocket};
use futures::{SinkExt, StreamExt};
use tokio::sync::broadcast;

// Handle active WebSocket connection
pub async fn handle_websocket(socket: WebSocket, tx: broadcast::Sender<String>) {
    // Split socket into sender/receiver
    let (mut ws_tx, mut ws_rx) = socket.split();
    
    // Subscribe to broadcast channel
    let mut rx = tx.subscribe();

    // Task: Forward WebSocket messages to broadcast channel
    let send_task = async move {
        while let Some(Ok(Message::Text(text))) = ws_rx.next().await {
            // Convert the received text to a String before sending.
            let _ = tx.send(text.to_string());
        }
    };

    // Task: Forward broadcast messages to WebSocket
    let recv_task = async move {
        while let Ok(msg) = rx.recv().await {
            // Convert the String message into the expected type.
            if ws_tx.send(Message::Text(msg.into())).await.is_err() {
                break;
            }
        }
    };

    // Run both tasks concurrently
    tokio::join!(send_task, recv_task);
}
=== END OF FILE: src/websocket.rs ===
