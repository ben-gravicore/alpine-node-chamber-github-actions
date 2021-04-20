parse_jira_key_array() {
    # must save as ISSUE_KEYS='["CC-4"]'
    # see https://jqplay.org/s/TNq7c5ctot
    ISSUE_KEYS=$(cat $GITHUB_EVENT_PATH | jq '[.commits[].message | scan("([A-Z]{2,30}-[0-9]+)")   | .[] ]')
    if [ "$ISSUE_KEYS" == "[]" ]; then
        # No issue keys found.
        echo "No issue keys found. This build does not contain a match for a Jira Issue. Please add your issue ID to the commit message or within the branch name."
        exit 0
    fi
}
parse_jira_key_array
echo $ISSUE_KEYS