#!/usr/bin/env bash
# ============================================================================
# KRACKED_skill (KD) - Status Management
# AI Skill by KRACKEDDEVS | https://krackeddevs.com/
# ============================================================================

# ---------------------------------------------------------------------------
# Read Status
# ---------------------------------------------------------------------------
kd_status_get_stage() {
    local status_file="$1"
    grep -o 'Stage:[[:space:]]*.*' "$status_file" | head -1 | sed 's/^Stage:[[:space:]]*//'
}

kd_status_get_role() {
    local status_file="$1"
    grep -o 'Active Role:[[:space:]]*.*' "$status_file" | head -1 | sed 's/^Active Role:[[:space:]]*//'
}

kd_status_get_story() {
    local status_file="$1"
    grep -o 'Active Story:[[:space:]]*.*' "$status_file" | head -1 | sed 's/^Active Story:[[:space:]]*//'
}

# ---------------------------------------------------------------------------
# Update Status
# ---------------------------------------------------------------------------
kd_status_set_stage() {
    local status_file="$1"
    local new_stage="$2"
    sed -i "s/^- Stage:.*/- Stage: ${new_stage}/" "$status_file"
    kd_status_add_changelog "$status_file" "$new_stage" "Stage changed to ${new_stage}" "System" "Workflow progression"
}

kd_status_set_role() {
    local status_file="$1"
    local new_role="$2"
    sed -i "s/^- Active Role:.*/- Active Role: ${new_role}/" "$status_file"
}

kd_status_set_story() {
    local status_file="$1"
    local story_id="$2"
    sed -i "s/^- Active Story:.*/- Active Story: ${story_id}/" "$status_file"
}

# ---------------------------------------------------------------------------
# Update Last Updated
# ---------------------------------------------------------------------------
kd_status_touch() {
    local status_file="$1"
    local current_date
    current_date="$(date +"%Y-%m-%d")"
    sed -i "s/^- Last Updated:.*/- Last Updated: ${current_date}/" "$status_file"
}

# ---------------------------------------------------------------------------
# Add Changelog Entry
# ---------------------------------------------------------------------------
kd_status_add_changelog() {
    local status_file="$1"
    local stage="$2"
    local change="$3"
    local role="$4"
    local reason="$5"
    local timestamp
    timestamp="$(date +"%Y-%m-%d %H:%M")"

    # Append to change log section
    sed -i "/^## Change Log/,/^$/{
        /^|.*|.*|.*|.*|.*|$/!{
            /^$/i\\
| ${timestamp} | ${stage} | ${change} | ${role} | ${reason} |
        }
    }" "$status_file"

    kd_status_touch "$status_file"
}

# ---------------------------------------------------------------------------
# Add Artifact
# ---------------------------------------------------------------------------
kd_status_add_artifact() {
    local status_file="$1"
    local name="$2"
    local location="$3"
    local stage="$4"
    local date
    date="$(date +"%Y-%m-%d")"

    sed -i "/^## Completed Artifacts/,/^$/{
        /^|.*|.*|.*|.*|$/!{
            /^$/i\\
| ${name} | ${location} | ${stage} | ${date} |
        }
    }" "$status_file"
}

# ---------------------------------------------------------------------------
# Mark Stage Complete
# ---------------------------------------------------------------------------
kd_status_complete_stage() {
    local status_file="$1"
    local stage_name="$2"
    local artifact="$3"
    local current_date
    current_date="$(date +"%Y-%m-%d")"

    sed -i "s/| ${stage_name} | pending |/| ${stage_name} | complete | ${current_date} | ${artifact} |/" "$status_file"
}
