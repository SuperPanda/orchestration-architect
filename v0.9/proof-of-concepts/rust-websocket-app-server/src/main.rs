mod handlers;
mod websocket;

use warp::Filter;
use handlers::{index, ws_route};

#[tokio::main]
async fn main() {
    let routes = warp::path::end()
        .map(index)
        .or(ws_route());
    
    warp::serve(routes).run(([0, 0, 0, 0], 3030)).await;
}
