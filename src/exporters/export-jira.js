// src/exporters/export-jira.js
// Kracked_Skills (KD) - Jira Export Utility
// AI Skill by KRACKEDDEVS | https://krackeddevs.com/

const fs = require('fs');
const path = require('path');

const OUTPUT_DIR = '.kracked/KD_output/jira-import';
const STORIES_DIR = '.kracked/KD_output/epics-and-stories';

// Ensure output directory exists
if (!fs.existsSync(OUTPUT_DIR)) {
    fs.mkdirSync(OUTPUT_DIR, { recursive: true });
}

/**
 * Recursively find all markdown files in a directory
 */
function findMarkdownFiles(dir, files = []) {
    if (!fs.existsSync(dir)) {
        console.log(`Directory not found: ${dir}`);
        return files;
    }

    const entries = fs.readdirSync(dir, { withFileTypes: true });

    for (const entry of entries) {
        const fullPath = path.join(dir, entry.name);

        if (entry.isDirectory()) {
            findMarkdownFiles(fullPath, files);
        } else if (entry.isFile() && entry.name.endsWith('.md')) {
            files.push(fullPath);
        }
    }

    return files;
}

/**
 * Parse a story file and extract Jira-compatible fields
 */
function parseStoryFile(filePath) {
    const content = fs.readFileSync(filePath, 'utf-8');
    const fileName = path.basename(filePath, '.md');
    const parentDir = path.basename(path.dirname(filePath));

    // Extract title from first heading
    const titleMatch = content.match(/^#\s+(.+)$/m);
    const title = titleMatch ? titleMatch[1].trim() : fileName;

    // Extract story ID from filename (e.g., "stories1-1" -> "STORY-1-1")
    const storyId = fileName.replace(/^stories/, 'STORY-');

    // Extract epic ID from parent directory (e.g., "epic-1" -> "EPIC-1")
    const epicId = parentDir.replace(/^epic-/, 'EPIC-');

    // Extract description (everything after the first heading)
    const descMatch = content.match(/^#\s+.+[\r\n]+([\s\S]*)/);
    let description = descMatch ? descMatch[1].trim() : content;

    // Clean up description for CSV (escape quotes, remove newlines)
    description = description
        .replace(/"/g, '""')
        .replace(/[\r\n]+/g, ' ')
        .substring(0, 30000); // Jira has a character limit

    // Extract priority from content
    let priority = 'Medium';
    if (content.includes('P0') || content.includes('CRITICAL') || content.toLowerCase().includes('priority: high')) {
        priority = 'High';
    } else if (content.includes('P2') || content.includes('LOW') || content.toLowerCase().includes('priority: low')) {
        priority = 'Low';
    }

    // Extract story points/estimate
    let storyPoints = '';
    const pointsMatch = content.match(/(?:points|estimate|story\s*points?)\s*:?\s*(\d+)/i);
    if (pointsMatch) {
        storyPoints = pointsMatch[1];
    }

    // Extract labels/tags
    const labels = [];
    if (content.toLowerCase().includes('frontend')) labels.push('frontend');
    if (content.toLowerCase().includes('backend')) labels.push('backend');
    if (content.toLowerCase().includes('api')) labels.push('api');
    if (content.toLowerCase().includes('database')) labels.push('database');
    if (content.toLowerCase().includes('security')) labels.push('security');

    return {
        summary: title,
        description: description,
        issueType: 'Story',
        priority: priority,
        storyId: storyId,
        epicId: epicId,
        storyPoints: storyPoints,
        labels: labels.join(';'),
        filePath: filePath
    };
}

/**
 * Parse an epic file and extract Jira-compatible fields
 */
function parseEpicFile(filePath) {
    const content = fs.readFileSync(filePath, 'utf-8');
    const fileName = path.basename(filePath, '.md');

    // Extract title from first heading
    const titleMatch = content.match(/^#\s+(.+)$/m);
    const title = titleMatch ? titleMatch[1].trim() : fileName;

    // Extract epic ID from filename
    const epicId = fileName.replace(/^epic-?/, 'EPIC-');

    // Extract description
    const descMatch = content.match(/^#\s+.+[\r\n]+([\s\S]*)/);
    let description = descMatch ? descMatch[1].trim() : content;

    description = description
        .replace(/"/g, '""')
        .replace(/[\r\n]+/g, ' ')
        .substring(0, 30000);

    return {
        summary: title,
        description: description,
        issueType: 'Epic',
        priority: 'Medium',
        epicId: epicId,
        epicName: title,
        filePath: filePath
    };
}

/**
 * Convert stories to Jira CSV format
 */
function exportStories() {
    console.log('📋 KD Jira Export Utility');
    console.log('=========================\n');

    if (!fs.existsSync(STORIES_DIR)) {
        console.log(`⚠️  Stories directory not found: ${STORIES_DIR}`);
        console.log('   Run /KD-epics-and-stories first to generate stories.\n');
        return;
    }

    // Find all markdown files
    const allFiles = findMarkdownFiles(STORIES_DIR);
    console.log(`📁 Found ${allFiles.length} markdown files\n`);

    if (allFiles.length === 0) {
        console.log('⚠️  No story files found. Run /KD-epics-and-stories first.\n');
        return;
    }

    // Separate epics and stories
    const epics = [];
    const stories = [];

    for (const file of allFiles) {
        const fileName = path.basename(file, '.md');
        const parentDir = path.basename(path.dirname(file));

        if (fileName.startsWith('epic') || parentDir === 'epics-and-stories') {
            // This might be an epic file
            if (fileName.match(/^epic-?\d/)) {
                epics.push(parseEpicFile(file));
            }
        }

        if (fileName.startsWith('stories') || fileName.startsWith('story')) {
            stories.push(parseStoryFile(file));
        }
    }

    console.log(`📊 Parsed: ${epics.length} epics, ${stories.length} stories\n`);

    // Generate CSV for epics
    if (epics.length > 0) {
        const epicHeaders = ['Summary', 'Description', 'Issue Type', 'Priority', 'Epic Name', 'Epic Key'];
        const epicRows = [epicHeaders.join(',')];

        for (const epic of epics) {
            epicRows.push([
                `"${epic.summary}"`,
                `"${epic.description}"`,
                epic.issueType,
                epic.priority,
                `"${epic.epicName}"`,
                epic.epicId
            ].join(','));
        }

        const epicCsvPath = path.join(OUTPUT_DIR, 'jira-epics.csv');
        fs.writeFileSync(epicCsvPath, epicRows.join('\n'));
        console.log(`✅ Exported ${epics.length} epics to: ${epicCsvPath}`);
    }

    // Generate CSV for stories
    if (stories.length > 0) {
        const storyHeaders = ['Summary', 'Description', 'Issue Type', 'Priority', 'Story Points', 'Labels', 'Epic Link'];
        const storyRows = [storyHeaders.join(',')];

        for (const story of stories) {
            storyRows.push([
                `"${story.summary}"`,
                `"${story.description}"`,
                story.issueType,
                story.priority,
                story.storyPoints,
                `"${story.labels}"`,
                story.epicId
            ].join(','));
        }

        const storyCsvPath = path.join(OUTPUT_DIR, 'jira-stories.csv');
        fs.writeFileSync(storyCsvPath, storyRows.join('\n'));
        console.log(`✅ Exported ${stories.length} stories to: ${storyCsvPath}`);
    }

    // Generate combined CSV
    const combinedHeaders = ['Summary', 'Description', 'Issue Type', 'Priority', 'Story Points', 'Labels', 'Epic Link', 'Epic Name'];
    const combinedRows = [combinedHeaders.join(',')];

    // Add epics first
    for (const epic of epics) {
        combinedRows.push([
            `"${epic.summary}"`,
            `"${epic.description}"`,
            epic.issueType,
            epic.priority,
            '',
            '',
            '',
            `"${epic.epicName}"`
        ].join(','));
    }

    // Add stories
    for (const story of stories) {
        combinedRows.push([
            `"${story.summary}"`,
            `"${story.description}"`,
            story.issueType,
            story.priority,
            story.storyPoints,
            `"${story.labels}"`,
            story.epicId,
            ''
        ].join(','));
    }

    const combinedCsvPath = path.join(OUTPUT_DIR, 'jira-import.csv');
    fs.writeFileSync(combinedCsvPath, combinedRows.join('\n'));
    console.log(`✅ Exported combined file to: ${combinedCsvPath}`);

    // Generate import instructions
    const instructions = `# Jira Import Instructions

Generated by Kracked_Skills (KD) v5.0.0
https://krackeddevs.com/

## Files Generated

- \`jira-import.csv\` - Combined file with all issues
- \`jira-epics.csv\` - Epic issues only
- \`jira-stories.csv\` - Story issues only

## Import Steps

1. Go to Jira > Settings > System > External System Import
2. Select "CSV" as the import type
3. Upload \`jira-import.csv\` (or separate files)
4. Map fields:
   - Summary → Summary
   - Description → Description
   - Issue Type → Issue Type
   - Priority → Priority
   - Story Points → Story Points (if field exists)
   - Labels → Labels
   - Epic Link → Epic Link (for stories)
   - Epic Name → Epic Name (for epics)

5. Review and confirm import

## Notes

- Epics should be imported before stories for proper linking
- Story Points field may need custom field mapping
- Labels are separated by semicolons

## Issue Counts

- Epics: ${epics.length}
- Stories: ${stories.length}
- Total: ${epics.length + stories.length}

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
`;

    const instructionsPath = path.join(OUTPUT_DIR, 'README.md');
    fs.writeFileSync(instructionsPath, instructions);
    console.log(`📄 Generated import instructions: ${instructionsPath}\n`);

    console.log('✅ Jira export complete!\n');
}

// Run export
module.exports = { exportStories, findMarkdownFiles, parseStoryFile, parseEpicFile };

// Execute if run directly
if (require.main === module) {
    exportStories();
}