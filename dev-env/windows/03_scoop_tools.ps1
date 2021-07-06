$pkg_mgr = "scoop"
$operation = "install"

# ---------- #
# Dev Tools
# ---------- #
$cli_tools = @(
"7zip",
"bat",
"busybox", # comes with sed, awk, vim, etc.
"gh",
"lf",
"jq",
"ripgrep",
"tokei"
)

foreach($tool in $cli_tools) {
    $command = "$($pkg_mgr) $($operation) $($tool)"
    echo "executing...$command"
    Invoke-Expression $command	
}
