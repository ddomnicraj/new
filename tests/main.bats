#!/usr/bin/env bats

load ../common

@test "010 Image is present and healthy" {
    docker image inspect ${maintainer}/${imagename}
}

@test "030 Port 443/https is listening" {
    docker run -d ${maintainer}/${imagename}
    sleep 25
    #get cont id
    contid=$(docker ps | grep ${maintainer}/${imagename} | cut -f 1 -d ' ')
    run docker exec -i ${contid} sh -c 'cat < /dev/null > /dev/tcp/127.0.0.1/443'
    docker kill ${contid} &>/dev/null
    docker rm ${contid} &>/dev/null
    [ "$status" -eq 0 ]
}

@test "040 The Grouper Status page is present" {
    docker run -d ${maintainer}/${imagename}
    sleep 60
    contid2=$(docker ps | grep ${maintainer}/${imagename} | cut -f 1 -d ' ')
    run docker exec -i ${contid2} sh -c 'curl -I -k -s -f https://127.0.0.1/grouper/status?diagnosticType=trivial'
    docker kill ${contid2} &>/dev/null
    docker rm ${contid2} &>/dev/null
    [ "$status" -eq 0 ]
}


@test "070 There are no known security vulnerabilities" {
    ./tests/clairscan.sh ${maintainer}/${imagename}
}
