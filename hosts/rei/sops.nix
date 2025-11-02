{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      "users/jin/password" = {
        neededForUsers = true;
      };
      "users/rei/bcsi/lun" = {};
      "users/rei/bcsi/dev" = {};
      "users/rei/bcsi/wwn" = {};
      "users/rei/bcsi/chap/user" = {};
      "users/rei/bcsi/chap/password" = {};
      "users/rei/bcsi/chap/node" = {};
      "networks/rei/main/name" = {};
      "networks/rei/main/dhcp" = {};
      "networks/rei/vm/kind" = {};
      "networks/rei/vm/name" = {};
      "networks/rei/bridge/name" = {};
      "networks/rei/bridge/dhcp" = {};
      "networks/rei/bridge/mad" = {};
    };
    templates = {
      "10-lan.network" = {
        content = ''
          [Match]
          Name=${config.sops.placeholder."networks/rei/main/name"}

          [Link]
          MACAddress=${config.sops.placeholder."networks/rei/bridge/mad"}

          [Network]
          DHCP=${config.sops.placeholder."networks/rei/main/dhcp"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/10-lan.network";
      };
      "saveconfig.json" = {
        content = ''
          {
            "fabric_modules": [],
            "storage_objects": [
              {
                "alua_tpgs": [
                  {
                    "alua_access_state": 0,
                    "alua_access_status": 0,
                    "alua_access_type": 3,
                    "alua_support_active_nonoptimized": 1,
                    "alua_support_active_optimized": 1,
                    "alua_support_offline": 1,
                    "alua_support_standby": 1,
                    "alua_support_transitioning": 1,
                    "alua_support_unavailable": 1,
                    "alua_write_metadata": 0,
                    "implicit_trans_secs": 0,
                    "name": "default_tg_pt_gp",
                    "nonop_delay_msecs": 100,
                    "preferred": 0,
                    "tg_pt_gp_id": 0,
                    "trans_delay_msecs": 0
                  }
                ],
                "attributes": {
                  "alua_support": 1,
                  "block_size": 512,
                  "emulate_3pc": 1,
                  "emulate_caw": 1,
                  "emulate_dpo": 1,
                  "emulate_fua_read": 1,
                  "emulate_fua_write": 1,
                  "emulate_model_alias": 1,
                  "emulate_pr": 1,
                  "emulate_rest_reord": 0,
                  "emulate_rsoc": 1,
                  "emulate_tas": 1,
                  "emulate_tpu": 0,
                  "emulate_tpws": 0,
                  "emulate_ua_intlck_ctrl": 0,
                  "emulate_write_cache": 0,
                  "enforce_pr_isids": 1,
                  "force_pr_aptpl": 0,
                  "is_nonrot": 1,
                  "max_unmap_block_desc_count": 1,
                  "max_unmap_lba_count": 2097152,
                  "max_write_same_len": 65535,
                  "optimal_sectors": 32768,
                  "pgr_support": 1,
                  "pi_prot_format": 0,
                  "pi_prot_type": 0,
                  "pi_prot_verify": 0,
                  "queue_depth": 128,
                  "submit_type": 0,
                  "unmap_granularity": 128,
                  "unmap_granularity_alignment": 0,
                  "unmap_zeroes_data": 0
                },
                "dev": "${config.sops.placeholder."users/rei/bcsi/dev"}",
                "name": "server-1",
                "plugin": "block",
                "readonly": false,
                "write_back": false,
                "wwn": "${config.sops.placeholder."users/rei/bcsi/lun"}"
              }
            ],
            "targets": [
              {
                "fabric": "iscsi",
                "parameters": {
                  "cmd_completion_affinity": "-1"
                },
                "tpgs": [
                  {
                    "attributes": {
                      "authentication": 0,
                      "cache_dynamic_acls": 0,
                      "default_cmdsn_depth": 64,
                      "default_erl": 0,
                      "demo_mode_discovery": 1,
                      "demo_mode_write_protect": 1,
                      "fabric_prot_type": 0,
                      "generate_node_acls": 0,
                      "login_keys_workaround": 1,
                      "login_timeout": 15,
                      "prod_mode_write_protect": 0,
                      "t10_pi": 0,
                      "tpg_enabled_sendtargets": 1
                    },
                    "enable": true,
                    "luns": [
                      {
                        "alias": "053e505f59",
                        "alua_tg_pt_gp_name": "default_tg_pt_gp",
                        "index": 0,
                        "storage_object": "/backstores/block/server-1"
                      }
                    ],
                    "node_acls": [
                      {
                        "attributes": {
                          "authentication": -1,
                          "dataout_timeout": 3,
                          "dataout_timeout_retries": 5,
                          "default_erl": 0,
                          "nopin_response_timeout": 30,
                          "nopin_timeout": 15,
                          "random_datain_pdu_offsets": 0,
                          "random_datain_seq_offsets": 0,
                          "random_r2t_offsets": 0
                        },
                        "chap_password": "${config.sops.placeholder."users/rei/bcsi/chap/user"}",
                        "chap_userid": "${config.sops.placeholder."users/rei/bcsi/chap/password"}",
                        "mapped_luns": [
                          {
                            "alias": "cb18979672",
                            "index": 0,
                            "tpg_lun": 0,
                            "write_protect": false
                          }
                        ],
                        "node_wwn": "${config.sops.placeholder."users/rei/bcsi/chap/node"}"
                      }
                    ],
                    "parameters": {
                      "AuthMethod": "CHAP,None",
                      "DataDigest": "CRC32C,None",
                      "DataPDUInOrder": "Yes",
                      "DataSequenceInOrder": "Yes",
                      "DefaultTime2Retain": "20",
                      "DefaultTime2Wait": "2",
                      "ErrorRecoveryLevel": "0",
                      "FirstBurstLength": "65536",
                      "HeaderDigest": "CRC32C,None",
                      "IFMarkInt": "Reject",
                      "IFMarker": "No",
                      "ImmediateData": "Yes",
                      "InitialR2T": "Yes",
                      "MaxBurstLength": "262144",
                      "MaxConnections": "1",
                      "MaxOutstandingR2T": "1",
                      "MaxRecvDataSegmentLength": "8192",
                      "MaxXmitDataSegmentLength": "262144",
                      "OFMarkInt": "Reject",
                      "OFMarker": "No",
                      "TargetAlias": "LIO Target"
                    },
                    "portals": [
                      {
                        "ip_address": "[::0]",
                        "iser": false,
                        "offload": false,
                        "port": 3260
                      }
                    ],
                    "tag": 1
                  }
                ],
                "wwn": "${config.sops.placeholder."users/rei/bcsi/wwn"}"
              }
            ]
          }
        '';
        mode = "0644";
        path = "/etc/target/saveconfig.json";
      };
    };
  };
}
