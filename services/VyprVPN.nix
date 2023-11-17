{
  config,
  pkgs,
  ...
}: {
  systemd.services.Vypr = {
    path = [
      pkgs.bash
      pkgs.busybox
      pkgs.openvpn
    ];
    enable = false;
    description = "VyprVPN to Spain";
    after = ["multi-user.target"];
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = 30;
      ExecStart = "${pkgs.openvpn}/bin/openvpn /etc/services/Vypr.ovpn";
    };
  };

  environment.etc.Vypr = {
    target = "services/Vypr.ovpn";
    text = ''
      client
      dev tun
      proto udp
      remote es1.vyprvpn.com 443
      resolv-retry infinite
      nobind
      persist-key
      persist-tun
      persist-remote-ip
      verify-x509-name es1.vyprvpn.com name
      auth-user-pass /etc/services/.auth.txt
      comp-lzo
      keepalive 10 60
      verb 3
      auth SHA256
      cipher AES-256-CBC
      tls-cipher TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384:TLS-DHE-RSA-WITH-AES-256-CBC-SHA256:TLS-DHE-RSA-WITH-AES-256-CBC-SHA

      <ca>
      -----BEGIN CERTIFICATE-----
      MIIEpDCCA4ygAwIBAgIJANd2Uwt7SabsMA0GCSqGSIb3DQEBBQUAMIGSMQswCQYD
      VQQGEwJLWTEUMBIGA1UECBMLR3JhbmRDYXltYW4xEzARBgNVBAcTCkdlb3JnZVRv
      d24xFzAVBgNVBAoTDkdvbGRlbkZyb2ctSW5jMRowGAYDVQQDExFHb2xkZW5Gcm9n
      LUluYyBDQTEjMCEGCSqGSIb3DQEJARYUYWRtaW5AZ29sZGVuZnJvZy5jb20wHhcN
      MTAwNDA5MjExOTIxWhcNMjAwNDA2MjExOTIxWjCBkjELMAkGA1UEBhMCS1kxFDAS
      BgNVBAgTC0dyYW5kQ2F5bWFuMRMwEQYDVQQHEwpHZW9yZ2VUb3duMRcwFQYDVQQK
      Ew5Hb2xkZW5Gcm9nLUluYzEaMBgGA1UEAxMRR29sZGVuRnJvZy1JbmMgQ0ExIzAh
      BgkqhkiG9w0BCQEWFGFkbWluQGdvbGRlbmZyb2cuY29tMIIBIjANBgkqhkiG9w0B
      AQEFAAOCAQ8AMIIBCgKCAQEA37JesfCwOj69el0AmqwXyiUJ2Bm+q0+eR9hYZEk7
      pVoj5dF9RrKirZyCM/9zEvON5z4pZMYjhpzrq6eiLu3j1xV6lX73Hg0dcflweM5i
      qxFAHCwEFIiMpPwOgLV399sfHCuda11boIPE4SRooxUPEju908AGg/i+egntvvR2
      d7pnZl2SCJ1sxlbeAAkYjX6EXmIBFyJdmry1y05BtpdTgPmTlJ0cMj7DlU+2gehP
      ss/q6YYRAhrKtlZwxeunc+RD04ieah+boYU0CBZinK2ERRuAjx3hbCE4b0S6eizr
      QmSuGFNu6Ghx+E1xasyl1Tz/fHgHl3P93Jf0tFov7uuygQIDAQABo4H6MIH3MB0G
      A1UdDgQWBBTh9HiMh5RnRVIt/ktXddiGkDkXBTCBxwYDVR0jBIG/MIG8gBTh9HiM
      h5RnRVIt/ktXddiGkDkXBaGBmKSBlTCBkjELMAkGA1UEBhMCS1kxFDASBgNVBAgT
      C0dyYW5kQ2F5bWFuMRMwEQYDVQQHEwpHZW9yZ2VUb3duMRcwFQYDVQQKEw5Hb2xk
      ZW5Gcm9nLUluYzEaMBgGA1UEAxMRR29sZGVuRnJvZy1JbmMgQ0ExIzAhBgkqhkiG
      9w0BCQEWFGFkbWluQGdvbGRlbmZyb2cuY29tggkA13ZTC3tJpuwwDAYDVR0TBAUw
      AwEB/zANBgkqhkiG9w0BAQUFAAOCAQEAwihrN0QNE19RRvGywBvsYDmzmM5G8ta5
      8yB+02Mzbm0KuVxnPJaoVy4L4WocAnqLeKfmpYWUid1MPwDPtwtQ00U7QmRBRNLU
      hS6Bth1wXtuDvkRoHgymSvg1+wonJNpv/VquNgwt7XbC9oOjVEd9lbUd+ttxzboI
      8P1ci6+I861PylA0DOv9j5bbn1oE0hP8wDv3bTklEa612zzEVnnfgw+ErVnkrnk8
      8fTiv6NZtHgUOllMq7ymlV7ut+BPp20rjBdOCNn2Q7dNCKIkI45qkwHtXjzFXIxz
      Gq3tLVeC54g7XZIc7X0S9avgAE7h9SuRYmsSzvLTtiP1obMCHB5ebQ==
      -----END CERTIFICATE-----
      -----BEGIN CERTIFICATE-----
      MIIGDjCCA/agAwIBAgIJAL2ON5xbane/MA0GCSqGSIb3DQEBDQUAMIGTMQswCQYD
      VQQGEwJDSDEQMA4GA1UECAwHTHVjZXJuZTEPMA0GA1UEBwwGTWVnZ2VuMRkwFwYD
      VQQKDBBHb2xkZW4gRnJvZyBHbWJIMSEwHwYDVQQDDBhHb2xkZW4gRnJvZyBHbWJI
      IFJvb3QgQ0ExIzAhBgkqhkiG9w0BCQEWFGFkbWluQGdvbGRlbmZyb2cuY29tMB4X
      DTE5MTAxNzIwMTQxMFoXDTM5MTAxMjIwMTQxMFowgZMxCzAJBgNVBAYTAkNIMRAw
      DgYDVQQIDAdMdWNlcm5lMQ8wDQYDVQQHDAZNZWdnZW4xGTAXBgNVBAoMEEdvbGRl
      biBGcm9nIEdtYkgxITAfBgNVBAMMGEdvbGRlbiBGcm9nIEdtYkggUm9vdCBDQTEj
      MCEGCSqGSIb3DQEJARYUYWRtaW5AZ29sZGVuZnJvZy5jb20wggIiMA0GCSqGSIb3
      DQEBAQUAA4ICDwAwggIKAoICAQCtuddaZrpWZ+nUuJpG+ohTquO3XZtq6d4U0E2o
      iPeIiwm+WWLY49G+GNJb5aVrlrBojaykCAc2sU6NeUlpg3zuqrDqLcz7PAE4OdNi
      OdrLBF1o9ZHrcITDZN304eAY5nbyHx5V6x/QoDVCi4g+5OVTA+tZjpcl4wRIpgkn
      WznO73IKCJ6YckpLn1BsFrVCb2ehHYZLg7Js58FzMySIxBmtkuPeHQXL61DFHh3c
      TFcMxqJjzh7EGsWRyXfbAaBGYnT+TZwzpLXXt8oBGpNXG8YBDrPdK0A+lzMnJ4nS
      0rgHDSRF0brx+QYk/6CgM510uFzB7zytw9UTD3/5TvKlCUmTGGgI84DbJ3DEvjxb
      giQnJXCUZKKYSHwrK79Y4Qn+lXu4Bu0ZTCJBje0GUVMTPAvBCeDvzSe0iRcVSNMJ
      VM68d4kD1PpSY/zWfCz5hiOjHWuXinaoZ0JJqRF8kGbJsbDlDYDtVvh/Cd4aWN6Q
      /2XLpszBsG5i8sdkS37nzkdlRwNEIZwsKfcXwdTOlDinR1LUG68LmzJAwfNE47xb
      rZUsdGGfG+HSPsrqFFiLGe7Y4e2+a7vGdSY9qR9PAzyx0ijCCrYzZDIsb2dwjLct
      Ux6a3LNV8cpfhKX+s6tfMldGufPI7byHT1Ybf0NtMS1d1RjD6IbqedXQdCKtaw68
      kTX//wIDAQABo2MwYTAdBgNVHQ4EFgQU2EbQvBd1r/EADr2jCPMXsH7zEXEwHwYD
      VR0jBBgwFoAU2EbQvBd1r/EADr2jCPMXsH7zEXEwDwYDVR0TAQH/BAUwAwEB/zAO
      BgNVHQ8BAf8EBAMCAYYwDQYJKoZIhvcNAQENBQADggIBAAViCPieIronV+9asjZy
      o5oSZSNWUkWRYdezjezsf49+fwT12iRgnkSEQeoj5caqcOfNm/eRpN4G7jhhCcxy
      9RGF+GurIlZ4v0mChZbx1jcxqr9/3/Z2TqvHALyWngBYDv6pv1iWcd9a4+QL9kj1
      Tlp8vUDIcHMtDQkEHnkhC+MnjyrdsdNE5wjlLljjFR2Qy5a6/kWwZ1JQVYof1J1E
      zY6mU7YLMHOdjfmeci5i0vg8+9kGMsc/7Wm69L1BeqpDB3ZEAgmOtda2jwOevJ4s
      ABmRoSThFp4DeMcxb62HW1zZCCpgzWv/33+pZdPvnZHSz7RGoxH4Ln7eBf3oo2PM
      lu7wCsid3HUdgkRf2Og1RJIrFfEjb7jga1JbKX2Qo/FH3txzdUimKiDRv3ccFmEO
      qjndUG6hP+7/EsI43oCPYOvZR+u5GdOkhYrDGZlvjXeJ1CpQxTR/EX+Vt7F8YG+i
      2LkO7lhPLb+LzgPAxVPCcEMHruuUlE1BYxxzRMOW4X4kjHvJjZGISxa9lgTY3e0m
      noQNQVBHKfzI2vGLwvcrFcCIrVxeEbj2dryfByyhZlrNPFbXyf7P4OSfk+fVh6Is
      1IF1wksfLY/6gWvcmXB8JwmKFDa9s5NfzXnzP3VMrNUWXN3G8Eee6qzKKTDsJ70O
      rgAx9j9a+dMLfe1vP5t6GQj5
      -----END CERTIFICATE-----
      </ca>
    '';
    mode = "0755";
  };
}