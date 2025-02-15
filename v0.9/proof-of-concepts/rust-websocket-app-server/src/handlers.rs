use warp::{reply::{html, Html}, Filter, Rejection};
use tokio::sync::broadcast;
use crate::websocket::handle_websocket;
// pub fn index() -> impl Reply {
//    html(include_str!("../static/index.html"))
//}
//

pub async fn index() -> Result<Html<String>, Rejection> {
        tokio::fs::read_to_string("static/index.html")
        .   await.map(html).map_err(|_| warp::reject::not_found())
}

pub fn ws_route() -> impl Filter<Extract = (impl warp::Reply,), Error = Rejection> + Clone {
    let (tx, _) = broadcast::channel(100);
    
    warp::path("ws")
        .and(warp::ws())
        .map(move |ws: warp::ws::Ws| {
            let tx = tx.clone();
            ws.on_upgrade(|socket| handle_websocket(socket, tx))
        })
}
