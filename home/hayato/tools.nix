{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # NETWORK
    arping
    arpoison
    atftp
    bandwhich
    bngblaster
    crackmapexec
    evillimiter
    iperf2
    iputils
    lftp
    mitm6
    mtr
    ncftp
    netcat-gnu
    netdiscover
    netexec
    nload
    nuttcp
    pingu
    putty
    pwnat
    responder
    route-graph
    rustcat
    sshping
    sslh
    tunnelgraf
    wbox
    whois
    yersinia
    
    # WIRELESS
    aircrack-ng
    airgeddon
    bully
    cowpatty
    dbmonster
    horst
    killerbee
    kismet
    netscanner
    pixiewps
    reaverwps
    wavemon
    wifite2
    zigpy-cli

    # WINDOWS
#    adidnsdump
#    adreaper
#    autobloody
#    bloodhound-py
#    chainsaw
#    certi
#    certipy
#    certsync
#    coercer
#    donpapi
#    enum4linux
#    enum4linux-ng
#    erosmb
#    evil-winrm
#    go365
#    gomapenum
#    kerbrute
#    knowsmore
#    lil-pwny
#    nbtscan
#    nbtscanner
#    offensive-azure
#    pre2k
#    python3Packages.lsassy
#    python3Packages.pypykatz
#    rdwatool
#    samba
#    smbmap
#    smbscan

    # WEB
#    dirb
#    apachetomcatscanner
#    arjun
#    brakeman
    #cameradar
#    cansina
#    cariddi
#    chopchop
#    clairvoyance
#    commix
#    crackql
#    crlfsuite
#    dalfox
#    dismap
#    dirstalk
#    dontgo403
#    forbidden
#    galer
#    gau
#    gospider
#    gotestwaf
#    gowitness
#    graphqlmap
#    graphw00f
#    hakrawler
#    hey
#    httpx
#    nodePackages.hyperpotamus
#    jaeles
#    jsubfinder
#    jwt-hack
#    katana
#    kiterunner
#    mantra
#    mitmproxy2swagger
#    monsoon
#    nikto
#    nomore403
#    ntlmrecon
#    ntopng
#    offat
#    photon
#    plecost
#    scraper
#    slowlorust
#    snallygaster
#    subjs
#    swaggerhole
#    uddup
#    wad
#    webanalyze
#    websecprobe
#    whatweb
#    wprecon
#    wpscan
#    wsrepl
#    wuzz
#    xcrawl3r
#    xnlinkfinder
#    xsubfind3r

    # VOIP | SIP
#    sipp
#    sipsak
#    sipvicious
#    sngrep

    # TUNNELING
#    bore-cli
#    corkscrew
#    hans
#    chisel
#    httptunnel
#    iodine
#    sish
#    stunnel
#    udptunnel
#    wstunnel

    # TRAFFIC
#    anevicon
#    dhcpdump
#    dnstop
#    driftnet
#    dsniff
#    goreplay
#    joincap
#    junkie
#    netsniff-ng
#    ngrep
#    secrets-extractor
#    sniffglue
#    tcpdump
#    tcpflow
#    tcpreplay
#    termshark
#    wireshark
#    wireshark-cli
#    zeek

    # SSL | TLS
#    cero
#    sslscan
#    ssldump
#    sslsplit
#    sslstrip
#    testssl
#    tlsx

    # TERMINAL
#    cutecom
#    minicom
#    picocom
#    socat
#    x3270

    # SMARTCARD
#    cardpeek
#    libfreefare
#    mfcuk
#    mfoc
#    python3Packages.emv

    # SERVICES
#    acltoolkit
#    checkip
#    ghunt
#    ike-scan
#    keepwn
#    metasploit
#    nbutools
#    nuclei
#    openrisk
#    osv-scanner
#    uncover
#    traitor

    # E-Mail
#    mx-takeover
#    ruler
#    swaks
#    trustymail

    # Databases
#    ghauri
#    laudanum
#    mongoaudit
#    nosqli
#    pysqlrecon
#    sqlmap

    # SNMP
#    braa
#    onesixtyone
#    snmpcheck

    # SSH
#    baboossh
#    sshchecker
#    ssh-audit
#    ssh-mitm

    # IDS/IPS/WAF
#    teler
#    waf-tester
#    wafw00f

    # CI
#    oshka

    # Terraform
#    terrascan
#    tfsec

    # Supply chain
#    chain-bench
#    witness
    
    # WebDAV
#    davtest

    # PROXY
#    bettercap
#    burpsuite
#    ettercap
#    mitmproxy
#    mubeng
#    proxify
#    proxychains
#    redsocks
#    rshijack
#    zap

    # PORT SCAN
#    arp-scan
#    das
#    ipscan
#    masscan
#    naabu
#    nmap
#    udpx
#    sx-go
#    rustscan
#    zmap

    # PASSWORD | HASHING
    chntpw
    crowbar
    authoscope
    bruteforce-luks
    brutespray
    crunch
    h8mail
    hashcat
    hashcat-utils
    hashdeep
    john
    hcxtools
    legba
    medusa
    nasty
    ncrack
    nth
    phrasendrescher
    python3Packages.patator
    thc-hydra
    truecrack

    # PACKET GEN
#    boofuzz
#    gping
#    fping
#    hping
#    ostinato
#    pktgen
#    python3Packages.scapy

    # MOBILE
#    abootimg
#    androguard
#    apkeep
#    apkleaks
#    apktool
#    dex2jar
#    genymotion
#    ghost
#    payload-dumper-go
#    scrcpy
#    simg2img
#    trueseeing

    # MISC
#    ares-rs
#    badchars
#    changetower
#    creds
#    doona
#    galleta
#    honeytrap
#    jwt-cli
#    kepler
#    nmap-formatter
#    pwntools
#    python3Packages.pytenable
#    snscrape
#    troubadix

    # MALWARE
#    bingrep
#    cutter
#    flare-floss
#    gdb
#    ghidra-bin
#    ioc-scan
#    pev
#    pwndbg
#    python3Packages.binwalk
#    python3Packages.malduck
#    python3Packages.karton-core
#    python3Packages.unicorn
#    python3Packages.r2pipe
#    radare2
#    radare2-cutter
#    rizin
#    stacs
#    unicorn
#    unicorn-emu
    #volatility
#    xortool
#    yara
#    zkar
#    zydis

    # LOAD TEST
#    ali
#    drill
#    cassowary
#    ddosify
#    oha
#    siege
#    tsung
#    vegeta

    #LDAP | AD
#    adenum
#    hekatomb
#    msldapdump
#    ldapmonitor
#    ldapdomaindump
#    ldapnomnom
#    ldeep
#    silenthound

    # KUBERNETES
#    cfripper
#    checkov
#    cirrusgo
#    kdigger
#    kube-score
#    kubeaudit
#    kubestroyer
#    kubescape
#    popeye

    # INFO GATHER
#    cloudbrute
#    enumerepo
#    holehe
#    maigret
#    metabigor
#    p0f
#    sn0int
#    socialscan
#    theharvester
#    urlhunter

    # HOST SEC
#    checksec
#    chkrootkit
#    linux-exploit-suggester
#    lynis
#    safety-cli
#    tracee
#    vulnix

    # HARDWARE ACCESS
#    cantoolz
#    chipsec
#    cmospwd
#    esptool
#    extrude
#    gallia
#    hachoir
#    nrfutil
#    teensy-loader-cli
#    tytools
#    python3Packages.angr
#    python3Packages.angrop
#    python3Packages.can
#    python3Packages.pyi2cflash
#    python3Packages.pyspiflash
#    routersploit

    # GENERIC
#    chrony
#    clamav
#    curl
#    cyberchef
#    dorkscout
#    easyeasm
#    exiflooter
#    flashrom
#    girsh
#    gtfocli
#    httpie
#    hurl
#    inetutils
#    inxi
#    ioccheck
#    iproute
#    iproute2
#    iw
#    lynx
#    macchanger
#    nano
#    parted
#    pwgen
#    ronin
#    spyre
#    utillinux
#    wget
#    xh

    # Terminal helpers
#    eternal-terminal
#    mosh
#    shellz

    # Common client for various protocols
#    cifs-utils
#    freerdp
#    net-snmp
#    nfs-utils
#    ntp
#    openssh
#    openvpn
#    samba
#    step-cli
#    tightvnc
#    wireguard-go
#    wireguard-tools
#    xrdp

    # Network design helpers
#    ipcalc
#    netmask

    # Terminal multiplexer
#    tmux
#    zellij

    # Archive tools
#    cabextract
#    p7zip
#    unrar
#    unzip

    # FUZZ
    #afl
#    aflplusplus
#    feroxbuster
#    ffuf
#    gobuster
#    honggfuzz
#    radamsa
#    regexploit
#    scout
#    ssdeep
#    wfuzz
#    zzuf

    # FORENSIC
#    capstone
#    afflib
#    amoco
#    acquire
#    dcfldd
#    ddrescue
#    dislocker
#    dismember
#    exiv2
#    ext4magic
#    extundelete
#    foremost
#    gef
#    gzrt
#    hivex
#    hstsparser
#    noseyparker
#    ntfs3g
#    ntfsprogs
#    nwipe
#    recoverjpeg
#    safecopy
#    sleuthkit
#    srm
#    stegseek
#    testdisk
#    volatility3
#    wipe
#    xorex
#    python39Packages.distorm3

    # EXPLOITS
#    exploitdb
#    go-exploitdb
#    keedump
#    padre

    # log4j
#    lmp
#    log4jcheck
#    log4j-detect
#    log4j-scan
#    log4j-sniffer
#    log4j-vuln-scanner
#    logmap

    # DNS
#    aiodnsbrute
#    amass
#    bind
#    dnsenum
#    dnsmon-go
#    dnsmonster
#    dnsrecon
#    dnstake
#    dnstracer
#    dnstwist
#    dnspeep
#    dnsx
#    fierce
#    findomain
#    knockpy
#    subfinder
#    subzerod
#    wtfis

    # CONTAINER
#    cdk-go
#   clair
#    cliam
#    cloudlist
#    dive
#    dockle
#    fwanalyzer
#    grype
#    trivy

    # CODE ANALYSIS
#    bomber-go
#    cargo-audit
#    credential-detector
#    deepsecrets
#    detect-secrets
#    freeze
#    garble
#    git-secret
#    gitjacker
#    gitleaks
#    gitls
#    gokart
#    legitify
#    osv-detector
#    packj
#    pip-audit
#    python310Packages.safety
#    secretscanner
#    skjold
#    tell-me-your-secrets
#    trufflehog
#    whispers
#    xeol

    # CLOUD ENV
#    cloud-nuke
#    cloudfox
#    ec2stepshell
#    gato
#    gcp-scanner
#    ggshield
#    goblob
#    imdshift
#    pacu
#    prowler
#    yatas

    # BLUETOOTH
#    bluez
#    bluewalker
#    python3Packages.bleak
#    redfang
#    ubertooth

    # REVERSE
#    binutils
#    elfutils
    #jd
#    jd-gui
#    patchelf
#    retdec
#    snowman
#    valgrind
  ];
}
