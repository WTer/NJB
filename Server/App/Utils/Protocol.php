<?php
function sendSuccess($msgData, $statusCode = 200) {
    global $app;
    $app->response->status($statusCode);
    $app->response->headers->set('Content-Type', 'application/json');

    if (is_null($msgData)) {
        $msgData = array();
    }

    echo json_encode($msgData, JSON_UNESCAPED_SLASHES);//JSON_UNESCAPED_UNICODE);
}


function sendFail($msgData, $statusCode = 400) {
    global $app;
    $app->response->headers->set('Content-Type', 'application/json');

    if (is_null($msgData)) {
        $msgData = array();
    }

    echo json_encode($msgData, JSON_UNESCAPED_UNICODE);
}
