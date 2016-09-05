#!/usr/bin/env bats

load ../common

@test "MariaDB repo provisioned" {
  docker run -i $maintainer/$imagename find /etc/yum.repos.d/MariaDB.repo
}

@test "Grouper directory created" {
  docker run -i $maintainer/$imagename find /opt/grouper/$version/grouper.installer.properties
}

@test "Grouper installer properties in correct position" {
  docker run -i $maintainer/$imagename find /etc/yum.repos.d/MariaDB.repo
}

@test "Grouper hibernate properties template available" {
  docker run -i $maintainer/$imagename find /opt/etc/grouper.hibernate.properties
}

@test "Grouper whitelist properties template available" {
  docker run -i $maintainer/$imagename find /opt/etc/grouper.properties
}

@test "API binary directory created" {
  docker run -i $maintainer/$imagename find /opt/grouper/$version/grouper.apiBinary-$version
}

@test "Client binary directory created" {
  docker run -i $maintainer/$imagename find /opt/grouper/$version/grouper.clientBinary-$version
}

@test "UI directory created" {
  docker run -i $maintainer/$imagename find /opt/grouper/$version/grouper.ui-$version
}

@test "WS directory created" {
  docker run -i $maintainer/$imagename find /opt/grouper/$version/grouper.ws-$version
}

