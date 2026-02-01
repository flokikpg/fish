function hypr_ws
    set -q HYPRLAND_INSTANCE_SIGNATURE; or return
    hyprctl activeworkspace -j 2>/dev/null | jq -r '.id' 2>/dev/null
end

