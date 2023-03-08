package config

import future.keywords

test_pass_with_current_aurora_postgres_11 if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "11.16",
        },
    }
}

test_aurora_postgres__pass_with_current_10_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "10.21",
        },
    }
}

test_aurora_postgres__pass_with_previous_10_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "10.20",
        },
    }
}

test_aurora_postgres__fail_with_old_10_version if {
    not allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "10.19",
        },
    }
}

test_aurora_postgres__pass_with_current_11_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "11.16",
        },
    }
}

test_aurora_postgres__pass_with_previous_11_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "11.15",
        },
    }
}

test_aurora_postgres__fail_with_old_11_version if {
    not allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "11.14",
        },
    }
}

test_aurora_postgres__pass_with_current_12_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "12.11",
        },
    }
}

test_aurora_postgres__pass_with_previous_12_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "12.10",
        },
    }
}

test_aurora_postgres__fail_with_old_12_version if {
    not allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "12.9",
        },
    }
}

test_aurora_postgres__pass_with_current_13_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "13.7",
        },
    }
}

test_aurora_postgres__pass_with_previous_13_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "13.6",
        },
    }
}

test_aurora_postgres__fail_with_old_13_version if {
    not allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "13.5",
        },
    }
}

test_aurora_postgres__pass_with_current_14_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "14.4",
        },
    }
}

test_aurora_postgres__pass_with_previous_14_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "aurora-postgresql",
            "engineVersion": "14.3",
        },
    }
}

test_rds_postgres__pass_with_current_10_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "10.21",
        },
    }
}

test_rds_postgres__pass_with_previous_10_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "10.20",
        },
    }
}

test_rds_postgres__fail_with_old_10_version if {
    not allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "10.19",
        },
    }
}

test_rds_postgres__pass_with_current_11_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "11.16",
        },
    }
}

test_rds_postgres__pass_with_previous_11_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "11.15",
        },
    }
}

test_rds_postgres__fail_with_old_11_version if {
    not allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "11.14",
        },
    }
}

test_rds_postgres__pass_with_current_12_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "12.11",
        },
    }
}

test_rds_postgres__pass_with_previous_12_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "12.10",
        },
    }
}

test_rds_postgres__fail_with_old_12_version if {
    not allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "12.9",
        },
    }
}

test_rds_postgres__pass_with_current_13_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "13.7",
        },
    }
}

test_rds_postgres__pass_with_previous_13_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "13.6",
        },
    }
}

test_rds_postgres__fail_with_old_13_version if {
    not allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "13.5",
        },
    }
}

test_rds_postgres__pass_with_current_14_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "14.4",
        },
    }
}

test_rds_postgres__pass_with_previous_14_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "postgres",
            "engineVersion": "14.3",
        },
    }
}

test_sql_server_ee__pass_with_current_15_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "sqlserver-ee",
            "engineVersion": "15.00.4236.7.v1",
        },
    }
}

test_sql_server_ee__pass_with_previous_15_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "sqlserver-ee",
            "engineVersion": "15.00.4198.2.v1",
        },
    }
}

test_sql_server_ee__fail_with_old_15_version if {
    not allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "sqlserver-ee",
            "engineVersion": "15.00.4153.1.v1",
        },
    }
}

test_sql_server_ee__pass_with_current_14_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "sqlserver-ee",
            "engineVersion": "14.00.3451.2.v1",
        },
    }
}

test_sql_server_ee__pass_with_previous_14_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "sqlserver-ee",
            "engineVersion": "14.00.3421.10.v1",
        },
    }
}

test_sql_server_ee__fail_with_old_14_version if {
    not allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "sqlserver-ee",
            "engineVersion": "14.00.3401.7.v1",
        },
    }
}

test_sql_server_ee__pass_with_current_13_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "sqlserver-ee",
            "engineVersion": "13.00.6419.1.v1",
        },
    }
}

test_sql_server_ee__pass_with_previous_13_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "sqlserver-ee",
            "engineVersion": "13.00.6300.2.v1",
        },
    }
}

test_sql_server_ee__pass_with_current_12_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "sqlserver-ee",
            "engineVersion": "12.00.6439.10.v1",
        },
    }
}

test_sql_server_ee__pass_with_previous_12_version if {
    allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "sqlserver-ee",
            "engineVersion": "12.00.6433.1.v1",
        },
    }
}

test_sql_server_ee__fail_with_old_12_version if {
    not allow with input as {
        "ResourceType": "AWS::RDS::DBInstance",
        "Configuration": {
            "engine": "sqlserver-ee",
            "engineVersion": "12.00.6329.1.v1",
        },
    }
}
