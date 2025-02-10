use warp::ws::{Message, WebSocket};
use tokio::sync::broadcast;
use futures::{SinkExt, StreamExt};

pub async fn handle_websocket(socket: WebSocket, tx: broadcast::Sender<String>) {
    let (mut ws_tx, mut ws_rx) = socket.split();
    let mut rx = tx.subscribe();

    // Send incoming messages to broadcast channel
    let send_task = async move {
        while let Some(Ok(msg)) = ws_rx.next().await {
            if let Ok(text) = msg.to_str() {
                let _ = tx.send(text.to_string());
            }
        }
    };

    // Receive messages from broadcast channel
    let recv_task = async move {
        while let Ok(msg) = rx.recv().await {
            if ws_tx.send(Message::text(msg)).await.is_err() {
                break;
            }
        }
    };

    tokio::join!(send_task, recv_task);
}
