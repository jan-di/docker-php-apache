<?php

$reasonPhrases = [
  100 => "Continue",
  101 => "Switching Protocols",
  102 => "Processing",
  200 => "OK",
  201 => "Created",
  202 => "Accepted",
  203 => "Non-authoritative Information",
  204 => "No Content",
  205 => "Reset Content",
  206 => "Partial Content",
  207 => "Multi-Status",
  208 => "Already Reported",
  226 => "IM Used",
  300 => "Multiple Choices",
  301 => "Moved Permanently",
  302 => "Found",
  303 => "See Other",
  304 => "Not Modified",
  305 => "Use Proxy",
  307 => "Temporary Redirect",
  308 => "Permanent Redirect",
  400 => "Bad Request",
  401 => "Unauthorized",
  402 => "Payment Required",
  403 => "Forbidden",
  404 => "Not Found",
  405 => "Method Not Allowed",
  406 => "Not Acceptable",
  407 => "Proxy Authentication Required",
  408 => "Request Timeout",
  409 => "Conflict",
  410 => "Gone",
  411 => "Length Required",
  412 => "Precondition Failed",
  413 => "Payload Too Large",
  414 => "Request-URI Too Long",
  415 => "Unsupported Media Type",
  416 => "Requested Range Not Satisfiable",
  417 => "Expectation Failed",
  418 => "I'm a teapot",
  421 => "Misdirected Request",
  422 => "Unprocessable Entity",
  423 => "Locked",
  424 => "Failed Dependency",
  426 => "Upgrade Required",
  428 => "Precondition Required",
  429 => "Too Many Requests",
  431 => "Request Header Fields Too Large",
  444 => "Connection Closed Without Response",
  451 => "Unavailable For Legal Reasons",
  499 => "Client Closed Request",
  500 => "Internal Server Error",
  501 => "Not Implemented",
  502 => "Bad Gateway",
  503 => "Service Unavailable",
  504 => "Gateway Timeout",
  505 => "HTTP Version Not Supported",
  506 => "Variant Also Negotiates",
  507 => "Insufficient Storage",
  508 => "Loop Detected",
  510 => "Not Extended",
  511 => "Network Authentication Required",
  599 => "Network Connect Timeout Error",
];

$statusCode = $_GET['code'] ?? 200;
$statusReason = $reasonPhrases[$statusCode] ?? "(Unknown Status)";
$title = $statusCode . " - " . $statusReason;

?>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title><?= $title ?></title>
  <style type="text/css">
    @import url("https://fonts.googleapis.com/css?family=Eczar:800");
    @import url("https://fonts.googleapis.com/css?family=Poppins:600");

    body {
      font-family: "Poppins";
      height: 100vh;
      background: #121212;
      padding: 1em;
      overflow: hidden;
    }

    .background-wrapper {
      position: relative;
      width: 100%;
      height: 100%;
      user-select: none;
    }

    .background-wrapper h1 {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%) rotate(-10deg);
      font-family: "Eczar";
      font-size: 55vmax;
      color: #585858;
      letter-spacing: 0.025em;
      margin: 0;
      transition: 750ms ease-in-out;
    }

    p {
      color: #dadada;
      font-size: calc(1em + 3vmin);
      position: fixed;
      bottom: 1rem;
      right: 1.5rem;
      margin: 0;
      text-align: right;
      text-shadow: -1px -1px 0 #121212, 1px 1px 0 #121212, -1px 1px 0 #121212, 1px -1px 0 #121212;
    }

    @media screen and (min-width: 340px) {
      p {
        width: 70%;
      }
    }

    @media screen and (min-width: 560px) {
      p {
        width: 50%;
      }
    }

    @media screen and (min-width: 940px) {
      p {
        width: 30%;
      }
    }

    @media screen and (min-width: 1300px) {
      p {
        width: 25%;
      }
    }
  </style>
</head>

<body>
  <!-- based on https://codepen.io/theyve/pen/zpxrLG -->
  <div class="background-wrapper">
    <h1 id="visual"><?= $statusCode ?></h1>
  </div>
  <p><?= $statusReason ?></p>
  <!--
    - Unfortunately, Microsoft has added a clever new
    - "feature" to Internet Explorer. If the text of
    - an error's message is "too small", specifically
    - less than 512 bytes, Internet Explorer returns
    - its own error message. You can turn that off,
    - but it's pretty tricky to find switch called
    - "smart error messages". That means, of course,
    - that short error messages are censored by default.
    - IIS always returns error messages that are long
    - enough to make Internet Explorer happy. The
    - workaround is pretty simple: pad the error
    - message with a big comment like this to push it
    - over the five hundred and twelve bytes minimum.
    - Of course, that's exactly what you're reading
    - right now.
  -->
</body>

</html>
