// file: src/handlers.rs
use axum::{
    extract::{ws::WebSocketUpgrade, State},
    response::Html,
};
use std::sync::Arc;
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
    State(state): State<Arc<broadcast::Sender<String>>>,
) -> impl axum::response::IntoResponse {
    // Upgrade to WebSocket connection
    ws.on_upgrade(|socket| handle_websocket(socket, state.clone()))
}
