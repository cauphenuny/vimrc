# proxy_server="http://host.docker.internal"
proxy_server="http://127.0.0.1"

function proxy() {
    if (( $# == 0 )); then
        echo "HTTP proxy: $http_proxy"
        return 0
    fi

    case $1 in
    "v2ray")
        export http_proxy="$proxy_server:8889"
        export https_proxy=$http_proxy
        echo "HTTP Proxy enabled $http_proxy $fg[gray](v2ray)$reset_color"
        ;;
    "clash")
        export http_proxy="$proxy_server:7890"
        export https_proxy=$http_proxy
        echo "HTTP Proxy enabled $http_proxy $fg[gray](clash)$reset_color"
        ;;
    "off")
        unset http_proxy
        unset https_proxy
        echo "HTTP Proxy $fg[red]disabled$reset_color"
        ;;
    *)
        echo "proxy v2ray/clash/off/(null)"
        return 1
    esac
}

proxy clash
