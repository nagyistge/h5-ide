var API_DATA_LIST = {
  "Forge" : {
    "Account" : {
      "register" : {
        "method"  : "/account:register",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "password" : {
            "type"   : "String",
            "value"  : "null"
          },
          "email" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "update_account" : {
        "method"  : "/account:update_account",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attributes" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "reset_password" : {
        "method"  : "/account:reset_password",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "update_password" : {
        "method"  : "/account:update_password",
        "param"   : {
          "key" : {
            "type"   : "String",
            "value"  : "null"
          },
          "new_pwd" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "check_repeat" : {
        "method"  : "/account:check_repeat",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "email" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "check_validation" : {
        "method"  : "/account:check_validation",
        "param"   : {
          "key" : {
            "type"   : "String",
            "value"  : "null"
          },
          "flag" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "reset_key" : {
        "method"  : "/account:reset_key",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "flag" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "del_account" : {
        "method"  : "/account:del_account",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "email" : {
            "type"   : "String",
            "value"  : "null"
          },
          "password" : {
            "type"   : "String",
            "value"  : "null"
          },
          "force_delete" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "Log" : {
      "put_user_log" : {
        "method"  : "/log:put_user_log",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "user_logs" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "Public" : {
      "get_hostname" : {
        "method"  : "/public:get_hostname",
        "param"   : {
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "get_dns_ip" : {
        "method"  : "/public:get_dns_ip",
        "param"   : {
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "Request" : {
      "init" : {
        "method"  : "/request:init",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "update" : {
        "method"  : "/request:update",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "timestamp" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "Session" : {
      "login" : {
        "method"  : "/session:login",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "password" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "logout" : {
        "method"  : "/session:logout",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "set_credential" : {
        "method"  : "/session:set_credential",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "access_key" : {
            "type"   : "String",
            "value"  : "null"
          },
          "secret_key" : {
            "type"   : "String",
            "value"  : "null"
          },
          "account_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "sync_redis" : {
        "method"  : "/session:sync_redis",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "guest" : {
        "method"  : "/session:guest",
        "param"   : {
          "guest_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "guestname" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "App" : {
      "create" : {
        "method"  : "/app:create",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "spec" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "update" : {
        "method"  : "/app:update",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "spec" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "rename" : {
        "method"  : "/app:rename",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "new_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "terminate" : {
        "method"  : "/app:terminate",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "start" : {
        "method"  : "/app:start",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "stop" : {
        "method"  : "/app:stop",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "reboot" : {
        "method"  : "/app:reboot",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "info" : {
        "method"  : "/app:info",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "list" : {
        "method"  : "/app:list",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "resource" : {
        "method"  : "/app:resource",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "summary" : {
        "method"  : "/app:summary",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "Favorite" : {
      "add" : {
        "method"  : "/favorite:add",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "resource" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "remove" : {
        "method"  : "/favorite:remove",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "resource_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "info" : {
        "method"  : "/favorite:info",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "provider" : {
            "type"   : "String",
            "value"  : "null"
          },
          "service" : {
            "type"   : "String",
            "value"  : "null"
          },
          "resource" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "Guest" : {
      "invite" : {
        "method"  : "/guest:invite",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "cancel" : {
        "method"  : "/guest:cancel",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "guest_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "access" : {
        "method"  : "/guest:access",
        "param"   : {
          "guestname" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "guest_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "end" : {
        "method"  : "/guest:end",
        "param"   : {
          "guestname" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "guest_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "info" : {
        "method"  : "/guest:info",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "guest_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "Stack" : {
      "create" : {
        "method"  : "/stack:create",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "spec" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "remove" : {
        "method"  : "/stack:remove",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "save" : {
        "method"  : "/stack:save",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "spec" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "rename" : {
        "method"  : "/stack:rename",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "new_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "run" : {
        "method"  : "/stack:run",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_desc" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_component" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_property" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_layout" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "save_as" : {
        "method"  : "/stack:save_as",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "new_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "info" : {
        "method"  : "/stack:info",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "list" : {
        "method"  : "/stack:list",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "export_cloudformation" : {
          "method"  : "/stack:export_cloudformation",
          "param"   : {
              "username" : {
                  "type"   : "String",
                  "value"  : "null"
              },
              "session_id" : {
                  "type"   : "String",
                  "value"  : "null"
              },
              "region_name" : {
                  "type"   : "String",
                  "value"  : "null"
              },
              "stack_id" : {
                  "type"   : "String",
                  "value"  : "null"
              }
          }
       },
      "verify" : {
        "method"  : "/stack:verify",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "spec" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "State" : {
      "module" : {
        "method"  : "/state:module",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "status" : {
        "method"  : "/state:status",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "log" : {
        "method"  : "/state:log",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "res_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    }
  },
  "AutoScaling" : {
    "AutoScaling" : {
      "DescribeAdjustmentTypes" : {
        "method"  : "/aws/autoscaling:DescribeAdjustmentTypes",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeAutoScalingGroups" : {
        "method"  : "/aws/autoscaling:DescribeAutoScalingGroups",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeAutoScalingInstances" : {
        "method"  : "/aws/autoscaling:DescribeAutoScalingInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeAutoScalingNotificationTypes" : {
        "method"  : "/aws/autoscaling:DescribeAutoScalingNotificationTypes",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeLaunchConfigurations" : {
        "method"  : "/aws/autoscaling:DescribeLaunchConfigurations",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "config_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeMetricCollectionTypes" : {
        "method"  : "/aws/autoscaling:DescribeMetricCollectionTypes",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeNotificationConfigurations" : {
        "method"  : "/aws/autoscaling:DescribeNotificationConfigurations",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribePolicies" : {
        "method"  : "/aws/autoscaling:DescribePolicies",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "policy_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeScalingActivities" : {
        "method"  : "/aws/autoscaling:DescribeScalingActivities",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "activity_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeScalingProcessTypes" : {
        "method"  : "/aws/autoscaling:DescribeScalingProcessTypes",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeScheduledActions" : {
        "method"  : "/aws/autoscaling:DescribeScheduledActions",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "action_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "start_time" : {
            "type"   : "String",
            "value"  : "null"
          },
          "end_time" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeTags" : {
        "method"  : "/aws/autoscaling:DescribeTags",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    }
  },
  "AWSUtil" : {
    "AWS" : {
      "quickstart" : {
        "method"  : "/aws:quickstart",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "public" : {
        "method"  : "/aws:public",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "info" : {
        "method"  : "/aws:info",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "resource" : {
        "method"  : "/aws:resource",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "resources" : {
            "type"   : "String",
            "value"  : "null"
          },
          "filter" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "price" : {
        "method"  : "/aws:price",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "status" : {
        "method"  : "/aws:status",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "vpc_resource" : {
        "method"  : "/aws:vpc_resource",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "vpc_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "stat_resource" : {
        "method"  : "/aws:stat_resource",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "resources" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "property" : {
        "method"  : "/aws:property",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    }
  },
  "CloudWatch" : {
    "CloudWatch" : {
      "GetMetricStatistics" : {
        "method"  : "/aws/cloudwatch:GetMetricStatistics",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "metric_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "namespace" : {
            "type"   : "String",
            "value"  : "null"
          },
          "start_time" : {
            "type"   : "String",
            "value"  : "null"
          },
          "end_time" : {
            "type"   : "String",
            "value"  : "null"
          },
          "period" : {
            "type"   : "int",
            "value"  : "null"
          },
          "unit" : {
            "type"   : "String",
            "value"  : "null"
          },
          "statistics" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "dimensions" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ListMetrics" : {
        "method"  : "/aws/cloudwatch:ListMetrics",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "metric_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "namespace" : {
            "type"   : "String",
            "value"  : "null"
          },
          "dimensions" : {
            "type"   : "String",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeAlarmHistory" : {
        "method"  : "/aws/cloudwatch:DescribeAlarmHistory",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "alarm_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "start_date" : {
            "type"   : "String",
            "value"  : "null"
          },
          "end_date" : {
            "type"   : "String",
            "value"  : "null"
          },
          "history_item_type" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeAlarms" : {
        "method"  : "/aws/cloudwatch:DescribeAlarms",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "alarm_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "alarm_name_prefix" : {
            "type"   : "String",
            "value"  : "null"
          },
          "action_prefix" : {
            "type"   : "String",
            "value"  : "null"
          },
          "state_value" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeAlarmsForMetric" : {
        "method"  : "/aws/cloudwatch:DescribeAlarmsForMetric",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "metric_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "namespace" : {
            "type"   : "String",
            "value"  : "null"
          },
          "dimension_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "period" : {
            "type"   : "int",
            "value"  : "null"
          },
          "statistic" : {
            "type"   : "String",
            "value"  : "null"
          },
          "unit" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    }
  },
  "EC2" : {
    "AMI" : {
      "CreateImage" : {
        "method"  : "/aws/ec2/ami:CreateImage",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ami_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ami_desc" : {
            "type"   : "String",
            "value"  : "null"
          },
          "no_reboot" : {
            "type"   : "String",
            "value"  : "null"
          },
          "bd_mappings" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "RegisterImage" : {
        "method"  : "/aws/ec2/ami:RegisterImage",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ami_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ami_desc" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DeregisterImage" : {
        "method"  : "/aws/ec2/ami:DeregisterImage",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ami_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ModifyImageAttribute" : {
        "method"  : "/aws/ec2/ami:ModifyImageAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ResetImageAttribute" : {
        "method"  : "/aws/ec2/ami:ResetImageAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ami_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attribute_name" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeImageAttribute" : {
        "method"  : "/aws/ec2/ami:DescribeImageAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ami_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attribute_name" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeImages" : {
        "method"  : "/aws/ec2/ami:DescribeImages",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ami_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "owners" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "executable_by" : {
            "type"   : "String",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "EBS" : {
      "CreateVolume" : {
        "method"  : "/aws/ebs/volume:CreateVolume",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "zone_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "snapshot_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "volume_size" : {
            "type"   : "int",
            "value"  : "null"
          },
          "volume_type" : {
            "type"   : "String",
            "value"  : "null"
          },
          "iops" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DeleteVolume" : {
        "method"  : "/aws/ebs/volume:DeleteVolume",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "volume_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "AttachVolume" : {
        "method"  : "/aws/ebs/volume:AttachVolume",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "volume_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "device" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DetachVolume" : {
        "method"  : "/aws/ebs/volume:DetachVolume",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "volume_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "device" : {
            "type"   : "String",
            "value"  : "null"
          },
          "force" : {
            "type"   : "Boolean",
            "value"  : "null"
          }
        }
      },
      "DescribeVolumes" : {
        "method"  : "/aws/ebs/volume:DescribeVolumes",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "volume_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeVolumeAttribute" : {
        "method"  : "/aws/ebs/volume:DescribeVolumeAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "volume_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attribute_name" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeVolumeStatus" : {
        "method"  : "/aws/ebs/volume:DescribeVolumeStatus",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "volume_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "max_result" : {
            "type"   : "String",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ModifyVolumeAttribute" : {
        "method"  : "/aws/ebs/volume:ModifyVolumeAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "volume_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "auto_enable_IO" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "EnableVolumeIO" : {
        "method"  : "/aws/ebs/volume:EnableVolumeIO",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "volume_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "CreateSnapshot" : {
        "method"  : "/aws/ebs/snapshot:CreateSnapshot",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "volume_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "description" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DeleteSnapshot" : {
        "method"  : "/aws/ebs/snapshot:DeleteSnapshot",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "snapshot_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ModifySnapshotAttribute" : {
        "method"  : "/aws/ebs/snapshot:ModifySnapshotAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "snapshot_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "user_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "group_names" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "ResetSnapshotAttribute" : {
        "method"  : "/aws/ebs/snapshot:ResetSnapshotAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "snapshot_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attribute_name" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeSnapshots" : {
        "method"  : "/aws/ebs/snapshot:DescribeSnapshots",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "snapshot_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "owners" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "restorable_by" : {
            "type"   : "String",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeSnapshotAttribute" : {
        "method"  : "/aws/ebs/snapshot:DescribeSnapshotAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "snapshot_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attribute_name" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "EC2" : {
      "CreateTags" : {
        "method"  : "/aws/ec2:CreateTags",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "resource_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "tags" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DeleteTags" : {
        "method"  : "/aws/ec2:DeleteTags",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "resource_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "tags" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeTags" : {
        "method"  : "/aws/ec2:DescribeTags",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeRegions" : {
        "method"  : "/aws/ec2:DescribeRegions",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeAvailabilityZones" : {
        "method"  : "/aws/ec2:DescribeAvailabilityZones",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "zone_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "EIP" : {
      "AllocateAddress" : {
        "method"  : "/aws/ec2/eip:AllocateAddress",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "domain" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ReleaseAddress" : {
        "method"  : "/aws/ec2/eip:ReleaseAddress",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ip" : {
            "type"   : "String",
            "value"  : "null"
          },
          "allocation_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "AssociateAddress" : {
        "method"  : "/aws/ec2/eip:AssociateAddress",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DisassociateAddress" : {
        "method"  : "/aws/ec2/eip:DisassociateAddress",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ip" : {
            "type"   : "String",
            "value"  : "null"
          },
          "association_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeAddresses" : {
        "method"  : "/aws/ec2/eip:DescribeAddresses",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ips" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "allocation_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "Instance" : {
      "RunInstances" : {
        "method"  : "/aws/ec2/instance:RunInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "StartInstances" : {
        "method"  : "/aws/ec2/instance:StartInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "StopInstances" : {
        "method"  : "/aws/ec2/instance:StopInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "force" : {
            "type"   : "Boolean",
            "value"  : "null"
          }
        }
      },
      "RebootInstances" : {
        "method"  : "/aws/ec2/instance:RebootInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "TerminateInstances" : {
        "method"  : "/aws/ec2/instance:TerminateInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "MonitorInstances" : {
        "method"  : "/aws/ec2/instance:MonitorInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "UnmonitorInstances" : {
        "method"  : "/aws/ec2/instance:UnmonitorInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "BundleInstance" : {
        "method"  : "/aws/ec2/instance:BundleInstance",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "s3_bucket" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "CancelBundleTask" : {
        "method"  : "/aws/ec2/instance:CancelBundleTask",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "bundle_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ModifyInstanceAttribute" : {
        "method"  : "/aws/ec2/instance:ModifyInstanceAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ResetInstanceAttribute" : {
        "method"  : "/aws/ec2/instance:ResetInstanceAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attribute_name" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "ConfirmProductInstance" : {
        "method"  : "/aws/ec2/instance:ConfirmProductInstance",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "product_code" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeInstances" : {
        "method"  : "/aws/ec2/instance:DescribeInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeInstanceStatus" : {
        "method"  : "/aws/ec2/instance:DescribeInstanceStatus",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "include_all_instances" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_results" : {
            "type"   : "String",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeBundleTasks" : {
        "method"  : "/aws/ec2/instance:DescribeBundleTasks",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "bundle_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeInstanceAttribute" : {
        "method"  : "/aws/ec2/instance:DescribeInstanceAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attribute_name" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "GetConsoleOutput" : {
        "method"  : "/aws/ec2/instance:GetConsoleOutput",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "GetPasswordData" : {
        "method"  : "/aws/ec2/instance:GetPasswordData",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "key_data" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "KeyPair" : {
      "CreateKeyPair" : {
        "method"  : "/aws/ec2/keypair:CreateKeyPair",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "key_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DeleteKeyPair" : {
        "method"  : "/aws/ec2/keypair:DeleteKeyPair",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "key_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ImportKeyPair" : {
        "method"  : "/aws/ec2/keypair:ImportKeyPair",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "key_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "key_data" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeKeyPairs" : {
        "method"  : "/aws/ec2/keypair:DescribeKeyPairs",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "key_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "upload" : {
        "method"  : "/aws/ec2/keypair:upload",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "key_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "key_data" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "download" : {
        "method"  : "/aws/ec2/keypair:download",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "key_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "remove" : {
        "method"  : "/aws/ec2/keypair:remove",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "key_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "list" : {
        "method"  : "/aws/ec2/keypair:list",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "PlacementGroup" : {
      "CreatePlacementGroup" : {
        "method"  : "/aws/ec2/placementgroup:CreatePlacementGroup",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "strategy" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DeletePlacementGroup" : {
        "method"  : "/aws/ec2/placementgroup:DeletePlacementGroup",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribePlacementGroups" : {
        "method"  : "/aws/ec2/placementgroup:DescribePlacementGroups",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "SecurityGroup" : {
      "CreateSecurityGroup" : {
        "method"  : "/aws/ec2/securitygroup:CreateSecurityGroup",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_desc" : {
            "type"   : "String",
            "value"  : "null"
          },
          "vpc_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DeleteSecurityGroup" : {
        "method"  : "/aws/ec2/securitygroup:DeleteSecurityGroup",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "AuthorizeSecurityGroupIngress" : {
        "method"  : "/aws/ec2/securitygroup:AuthorizeSecurityGroupIngress",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "RevokeSecurityGroupIngress" : {
        "method"  : "/aws/ec2/securitygroup:RevokeSecurityGroupIngress",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeSecurityGroups" : {
        "method"  : "/aws/ec2/securitygroup:DescribeSecurityGroups",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "group_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "group_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    }
  },
  "ELB" : {
    "ELB" : {
      "DescribeInstanceHealth" : {
        "method"  : "/aws/elb:DescribeInstanceHealth",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "elb_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeLoadBalancerPolicies" : {
        "method"  : "/aws/elb:DescribeLoadBalancerPolicies",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "elb_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "policy_names" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeLoadBalancerPolicyTypes" : {
        "method"  : "/aws/elb:DescribeLoadBalancerPolicyTypes",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "policy_type_names" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeLoadBalancers" : {
        "method"  : "/aws/elb:DescribeLoadBalancers",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "elb_names" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "marker" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    }
  },
  "IAM" : {
    "IAM" : {
      "GetServerCertificate" : {
        "method"  : "/aws/iam:GetServerCertificate",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "servercer_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ListServerCertificates" : {
        "method"  : "/aws/iam:ListServerCertificates",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "marker" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_items" : {
            "type"   : "int",
            "value"  : "null"
          },
          "path_prefix" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    }
  },
  "OpsWorks" : {
    "OpsWorks" : {
      "DescribeApps" : {
        "method"  : "/aws/opsworks/opsworks:DescribeApps",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "stack_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeStacks" : {
        "method"  : "/aws/opsworks/opsworks:DescribeStacks",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeCommands" : {
        "method"  : "/aws/opsworks/opsworks:DescribeCommands",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "command_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "deployment_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeDeployments" : {
        "method"  : "/aws/opsworks/opsworks:DescribeDeployments",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "deployment_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "stack_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeElasticIps" : {
        "method"  : "/aws/opsworks/opsworks:DescribeElasticIps",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "ips" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeInstances" : {
        "method"  : "/aws/opsworks/opsworks:DescribeInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "app_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "layer_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeLayers" : {
        "method"  : "/aws/opsworks/opsworks:DescribeLayers",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "layer_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeLoadBasedAutoScaling" : {
        "method"  : "/aws/opsworks/opsworks:DescribeLoadBasedAutoScaling",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "layer_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribePermissions" : {
        "method"  : "/aws/opsworks/opsworks:DescribePermissions",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "iam_user_arn" : {
            "type"   : "String",
            "value"  : "null"
          },
          "stack_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeRaidArrays" : {
        "method"  : "/aws/opsworks/opsworks:DescribeRaidArrays",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "raid_array_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeServiceErrors" : {
        "method"  : "/aws/opsworks/opsworks:DescribeServiceErrors",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "service_error_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "stack_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeTimeBasedAutoScaling" : {
        "method"  : "/aws/opsworks/opsworks:DescribeTimeBasedAutoScaling",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeUserProfiles" : {
        "method"  : "/aws/opsworks/opsworks:DescribeUserProfiles",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "iam_user_arns" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeVolumes" : {
        "method"  : "/aws/ebs/volume:DescribeVolumes",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "raid_array_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "volume_ids" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    }
  },
  "RDS" : {
    "Instance" : {
      "DescribeDBInstances" : {
        "method"  : "/aws/rds/instance:DescribeDBInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "instance_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "marker" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          }
        }
      }
    },
    "OptionGroup" : {
      "DescribeOptionGroupOptions" : {
        "method"  : "/aws/rds/optiongroup:DescribeOptionGroupOptions",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeOptionGroups" : {
        "method"  : "/aws/rds/optiongroup:DescribeOptionGroups",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "ParameterGroup" : {
      "DescribeDBParameterGroups" : {
        "method"  : "/aws/rds/parametergroup:DescribeDBParameterGroups",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "pg_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "marker" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          }
        }
      },
      "DescribeDBParameters" : {
        "method"  : "/aws/rds/parametergroup:DescribeDBParameters",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "pg_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "source" : {
            "type"   : "String",
            "value"  : "null"
          },
          "marker" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          }
        }
      }
    },
    "RDS" : {
      "DescribeDBEngineVersions" : {
        "method"  : "/aws/rds/rds:DescribeDBEngineVersions",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeOrderableDBInstanceOptions" : {
        "method"  : "/aws/rds/rds:DescribeOrderableDBInstanceOptions",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeEngineDefaultParameters" : {
        "method"  : "/aws/rds/rds:DescribeEngineDefaultParameters",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "pg_family" : {
            "type"   : "String",
            "value"  : "null"
          },
          "marker" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          }
        }
      },
      "DescribeEvents" : {
        "method"  : "/aws/rds/rds:DescribeEvents",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "ReservedInstance" : {
      "DescribeReservedDBInstances" : {
        "method"  : "/aws/rds/reservedinstance:DescribeReservedDBInstances",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "DescribeReservedDBInstancesOfferings" : {
        "method"  : "/aws/rds/reservedinstance:DescribeReservedDBInstancesOfferings",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "SecurityGroup" : {
      "DescribeDBSecurityGroups" : {
        "method"  : "/aws/rds/securitygroup:DescribeDBSecurityGroups",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "sg_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "marker" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          }
        }
      }
    },
    "Snapshot" : {
      "DescribeDBSnapshots" : {
        "method"  : "/aws/ebs/snapshot:DescribeDBSnapshots",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "SubnetGroup" : {
      "DescribeDBSubnetGroups" : {
        "method"  : "/aws/rds/subnetgroup:DescribeDBSubnetGroups",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "sg_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "marker" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_records" : {
            "type"   : "int",
            "value"  : "null"
          }
        }
      }
    }
  },
  "SDB" : {
    "SDB" : {
      "DomainMetadata" : {
        "method"  : "/aws/sdb/sdb:DomainMetadata",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "doamin_name" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "GetAttributes" : {
        "method"  : "/aws/sdb/sdb:GetAttributes",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "domain_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "item_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attribute_name" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "consistent_read" : {
            "type"   : "Boolean",
            "value"  : "null"
          }
        }
      },
      "ListDomains" : {
        "method"  : "/aws/sdb/sdb:ListDomains",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "max_domains" : {
            "type"   : "int",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    }
  },
  "SNS" : {
    "SNS" : {
      "GetSubscriptionAttributes" : {
        "method"  : "/aws/sns/sns:GetSubscriptionAttributes",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "subscription_arn" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "GetTopicAttributes" : {
        "method"  : "/aws/sns/sns:GetTopicAttributes",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "topic_arn" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ListSubscriptions" : {
        "method"  : "/aws/sns/sns:ListSubscriptions",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ListSubscriptionsByTopic" : {
        "method"  : "/aws/sns/sns:ListSubscriptionsByTopic",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "topic_arn" : {
            "type"   : "String",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      },
      "ListTopics" : {
        "method"  : "/aws/sns/sns:ListTopics",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "next_token" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    }
  },
  "VPC" : {
    "ACL" : {
      "DescribeNetworkAcls" : {
        "method"  : "/aws/vpc/acl:DescribeNetworkAcls",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "acl_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "CustomerGateway" : {
      "DescribeCustomerGateways" : {
        "method"  : "/aws/vpc/cgw:DescribeCustomerGateways",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "gw_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "DHCP" : {
      "DescribeDhcpOptions" : {
        "method"  : "/aws/vpc/dhcp:DescribeDhcpOptions",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "dhcp_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "ENI" : {
      "DescribeNetworkInterfaces" : {
        "method"  : "/aws/vpc/eni:DescribeNetworkInterfaces",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "eni_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeNetworkInterfaceAttribute" : {
        "method"  : "/aws/vpc/eni:DescribeNetworkInterfaceAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "eni_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attribute" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "InternetGateway" : {
      "DescribeInternetGateways" : {
        "method"  : "/aws/vpc/igw:DescribeInternetGateways",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "gw_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "RouteTable" : {
      "DescribeRouteTables" : {
        "method"  : "/aws/vpc/routetable:DescribeRouteTables",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "rt_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "Subnet" : {
      "DescribeSubnets" : {
        "method"  : "/aws/vpc/subnet:DescribeSubnets",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "subnet_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "VPC" : {
      "DescribeVpcs" : {
        "method"  : "/aws/vpc:DescribeVpcs",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "vpc_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeAccountAttributes" : {
        "method"  : "/aws/vpc:DescribeAccountAttributes",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attribute_name" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      },
      "DescribeVpcAttribute" : {
        "method"  : "/aws/vpc:DescribeVpcAttribute",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "vpc_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "attribute" : {
            "type"   : "String",
            "value"  : "null"
          }
        }
      }
    },
    "VPNGateway" : {
      "DescribeVpnGateways" : {
        "method"  : "/aws/vpc/vgw:DescribeVpnGateways",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "gw_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    },
    "VPN" : {
      "DescribeVpnConnections" : {
        "method"  : "/aws/vpc/vpn:DescribeVpnConnections",
        "param"   : {
          "username" : {
            "type"   : "String",
            "value"  : "null"
          },
          "session_id" : {
            "type"   : "String",
            "value"  : "null"
          },
          "region_name" : {
            "type"   : "String",
            "value"  : "null"
          },
          "vpn_ids" : {
            "type"   : "Array",
            "value"  : "null"
          },
          "filters" : {
            "type"   : "Array",
            "value"  : "null"
          }
        }
      }
    }
  }
};
