package config

import future.keywords.in

default allow := false

allow {
    input.Configuration.engine in {"aurora-postgresql", "postgres"}
    input.Configuration.engineVersion in {
        "10.20",
        "10.21",
        "11.15",
        "11.16",
        "12.10",
        "12.11",
        "13.6",
        "13.7",
        "14.3",
        "14.4",
    }
}

allow {
    input.Configuration.engine in {"sqlserver-ee", "sqlserver-se"}
    input.Configuration.engineVersion in {
        "15.00.4236.7.v1",
        "15.00.4198.2.v1",
        "14.00.3451.2.v1",
        "14.00.3421.10.v1",
        "13.00.6419.1.v1",
        "13.00.6300.2.v1",
        "12.00.6439.10.v1",
        "12.00.6433.1.v1",
    }
}
