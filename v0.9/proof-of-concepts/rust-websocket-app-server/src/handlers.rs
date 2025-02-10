use warp::{Reply, reply::html, Filter};
use tokio::sync::broadcast;
use crate::websocket::handle_websocket;

pub fn index() -> impl Reply {
    html(include_str!("../static/index.html"))
}

pub fn ws_route() -> impl Filter<Extract = (impl warp::Reply,), Error = warp::Rejection> + Clone {
    let (tx, _) = broadcast::channel(100);
    
    warp::path("ws")
        .and(warp::ws())
        .map(move |ws: warp::ws::Ws| {
            let tx = tx.clone();
            ws.on_upgrade(|socket| handle_websocket(socket, tx))
        })
}
