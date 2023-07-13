Content-Type: multipart/mixed; boundary="===============0086047718136476635=="
MIME-Version: 1.0

--===============0086047718136476635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config"

config system global
    set hostname "${faz_vm_name}"
end
config system interface
    edit "port1"
        set ip ${faz_ipaddr}/${faz_mask}
        set allowaccess ping https ssh
    next
end
config system admin user
    edit ${faz_username}
        set password ${faz_password}
        set change-password disable
        set rpc-permit read-write
        unset password-expire
    end
end
execute vm-license ${faz_flex-license} 
--===============0086047718136476635==--