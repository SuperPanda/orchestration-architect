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
