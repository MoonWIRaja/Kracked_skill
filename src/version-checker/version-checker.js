/**
 * Version Compatibility Checker
 * AI Tool by KRACKEDDEVS
 * https://krackeddevs.com/
 * 
 * Checks latest versions and compatibility between technologies
 */

const https = require('https');
const fs = require('fs');
const path = require('path');

class VersionChecker {
    constructor() {
        this.registryPath = path.join(__dirname, 'registry.json');
        this.rulesPath = path.join(__dirname, 'compatibility-rules.json');
        
        // Load cached data
        this.registry = this.loadJSON(this.registryPath, { lastUpdated: null, cache: {} });
        this.rules = this.loadJSON(this.rulesPath, { rules: [], knownIssues: [] });
        
        // Cache expiry: 24 hours
        this.cacheExpiry = 24 * 60 * 60 * 1000;
    }
    
    /**
     * Load JSON file with fallback
     */
    loadJSON(filePath, fallback) {
        try {
            if (fs.existsSync(filePath)) {
                const data = fs.readFileSync(filePath, 'utf8');
                return JSON.parse(data);
            }
        } catch (error) {
            console.error(`Error loading ${filePath}: ${error.message}`);
        }
        return fallback;
    }
    
    /**
     * Save JSON file
     */
    saveJSON(filePath, data) {
        try {
            fs.writeFileSync(filePath, JSON.stringify(data, null, 2));
        } catch (error) {
            console.error(`Error saving ${filePath}: ${error.message}`);
        }
    }
    
    /**
     * Fetch data from URL (without external dependencies)
     */
    async fetch(url) {
        return new Promise((resolve, reject) => {
            https.get(url, {
                headers: { 'User-Agent': 'KD-VersionChecker/1.0' }
            }, (res) => {
                let data = '';
                res.on('data', chunk => data += chunk);
                res.on('end', () => {
                    try {
                        resolve(JSON.parse(data));
                    } catch (e) {
                        resolve(data);
                    }
                });
            }).on('error', reject);
        });
    }
    
    /**
     * Get latest version from npm registry
     */
    async getNpmLatest(packageName) {
        // Check cache first
        const cached = this.registry.cache[packageName];
        if (cached && Date.now() - new Date(cached.checked).getTime() < this.cacheExpiry) {
            return {
                latest: cached.latest,
                lts: cached.lts,
                cached: true
            };
        }
        
        try {
            const data = await this.fetch(`https://registry.npmjs.org/${packageName}`);
            
            const result = {
                latest: data['dist-tags']?.latest || 'unknown',
                lts: data['dist-tags']?.lts || null,
                next: data['dist-tags']?.next || null,
                versions: Object.keys(data.versions || {}).slice(-10), // Last 10 versions
                checked: new Date().toISOString(),
                cached: false
            };
            
            // Update cache
            this.registry.cache[packageName] = result;
            this.registry.lastUpdated = new Date().toISOString();
            this.saveJSON(this.registryPath, this.registry);
            
            return result;
        } catch (error) {
            console.error(`Error fetching ${packageName}: ${error.message}`);
            return { latest: 'error', error: error.message };
        }
    }
    
    /**
     * Get latest version from GitHub releases
     */
    async getGitHubLatest(owner, repo) {
        const key = `github:${owner}/${repo}`;
        
        // Check cache
        const cached = this.registry.cache[key];
        if (cached && Date.now() - new Date(cached.checked).getTime() < this.cacheExpiry) {
            return { ...cached, cached: true };
        }
        
        try {
            const data = await this.fetch(`https://api.github.com/repos/${owner}/${repo}/releases/latest`);
            
            const result = {
                latest: data.tag_name?.replace(/^v/, '') || 'unknown',
                name: data.name,
                publishedAt: data.published_at,
                url: data.html_url,
                checked: new Date().toISOString(),
                cached: false
            };
            
            // Update cache
            this.registry.cache[key] = result;
            this.registry.lastUpdated = new Date().toISOString();
            this.saveJSON(this.registryPath, this.registry);
            
            return result;
        } catch (error) {
            console.error(`Error fetching GitHub ${owner}/${repo}: ${error.message}`);
            return { latest: 'error', error: error.message };
        }
    }
    
    /**
     * Check Node.js version
     */
    async getNodeVersion() {
        const cached = this.registry.cache['nodejs'];
        if (cached && Date.now() - new Date(cached.checked).getTime() < this.cacheExpiry) {
            return { ...cached, cached: true };
        }
        
        try {
            const data = await this.fetch('https://nodejs.org/dist/index.json');
            
            const lts = data.find(v => v.lts);
            const current = data[0];
            
            const result = {
                latest: current.version.replace(/^v/, ''),
                lts: lts?.version.replace(/^v/, ''),
                ltsName: lts?.lts,
                checked: new Date().toISOString(),
                cached: false
            };
            
            this.registry.cache['nodejs'] = result;
            this.saveJSON(this.registryPath, this.registry);
            
            return result;
        } catch (error) {
            console.error(`Error fetching Node.js version: ${error.message}`);
            return { latest: 'error', error: error.message };
        }
    }
    
    /**
     * Technology name mapping
     */
    getTechMapping() {
        return {
            // Frontend
            'next.js': { type: 'npm', package: 'next' },
            'nextjs': { type: 'npm', package: 'next' },
            'react': { type: 'npm', package: 'react' },
            'vue': { type: 'npm', package: 'vue' },
            'vue.js': { type: 'npm', package: 'vue' },
            'angular': { type: 'npm', package: '@angular/core' },
            'svelte': { type: 'npm', package: 'svelte' },
            'nuxt': { type: 'npm', package: 'nuxt' },
            'nuxt.js': { type: 'npm', package: 'nuxt' },
            'astro': { type: 'npm', package: 'astro' },
            'remix': { type: 'npm', package: '@remix-run/react' },
            
            // Backend
            'express': { type: 'npm', package: 'express' },
            'express.js': { type: 'npm', package: 'express' },
            'nestjs': { type: 'npm', package: '@nestjs/core' },
            'nest.js': { type: 'npm', package: '@nestjs/core' },
            'fastify': { type: 'npm', package: 'fastify' },
            'hono': { type: 'npm', package: 'hono' },
            'fastapi': { type: 'pypi', package: 'fastapi' },
            'django': { type: 'pypi', package: 'django' },
            'flask': { type: 'pypi', package: 'flask' },
            
            // Database
            'prisma': { type: 'npm', package: 'prisma' },
            'drizzle': { type: 'npm', package: 'drizzle-orm' },
            'mongoose': { type: 'npm', package: 'mongoose' },
            'pg': { type: 'npm', package: 'pg' },
            
            // UI Libraries
            'material-ui': { type: 'npm', package: '@mui/material' },
            'mui': { type: 'npm', package: '@mui/material' },
            'chakra': { type: 'npm', package: '@chakra-ui/react' },
            'ant-design': { type: 'npm', package: 'antd' },
            'antd': { type: 'npm', package: 'antd' },
            'shadcn': { type: 'npm', package: '@radix-ui/react-dialog' }, // proxy for shadcn check
            'tailwindcss': { type: 'npm', package: 'tailwindcss' },
            
            // State Management
            'redux': { type: 'npm', package: '@reduxjs/toolkit' },
            'zustand': { type: 'npm', package: 'zustand' },
            'jotai': { type: 'npm', package: 'jotai' },
            'recoil': { type: 'npm', package: 'recoil' },
            
            // Testing
            'jest': { type: 'npm', package: 'jest' },
            'vitest': { type: 'npm', package: 'vitest' },
            'playwright': { type: 'npm', package: '@playwright/test' },
            'cypress': { type: 'npm', package: 'cypress' },
            
            // Build Tools
            'vite': { type: 'npm', package: 'vite' },
            'webpack': { type: 'npm', package: 'webpack' },
            'turbo': { type: 'npm', package: 'turbo' },
            'turborepo': { type: 'npm', package: 'turbo' },
            
            // Runtime
            'node': { type: 'nodejs', package: 'nodejs' },
            'node.js': { type: 'nodejs', package: 'nodejs' },
            'bun': { type: 'npm', package: 'bun' },
            'deno': { type: 'github', owner: 'denoland', repo: 'deno' },
            
            // TypeScript
            'typescript': { type: 'npm', package: 'typescript' },
            
            // Supabase
            'supabase': { type: 'npm', package: '@supabase/supabase-js' },
        };
    }
    
    /**
     * Get version for a technology
     */
    async getVersion(techName) {
        const mapping = this.getTechMapping();
        const normalizedName = techName.toLowerCase().trim();
        
        const tech = mapping[normalizedName];
        if (!tech) {
            return { error: `Unknown technology: ${techName}` };
        }
        
        switch (tech.type) {
            case 'npm':
                return await this.getNpmLatest(tech.package);
            case 'nodejs':
                return await this.getNodeVersion();
            case 'github':
                return await this.getGitHubLatest(tech.owner, tech.repo);
            case 'pypi':
                // Python packages - simplified check
                return { 
                    latest: 'check-pypi',
                    note: `Check https://pypi.org/project/${tech.package}/ for latest version`,
                    cached: false
                };
            default:
                return { error: `Unknown type: ${tech.type}` };
        }
    }
    
    /**
     * Check compatibility between technologies
     */
    checkCompatibility(techs) {
        const issues = [];
        const warnings = [];
        const recommendations = [];
        
        // Apply compatibility rules
        for (const rule of this.rules.rules) {
            const tech1 = techs.find(t => t.name.toLowerCase() === rule.tech1.toLowerCase());
            const tech2 = techs.find(t => t.name.toLowerCase() === rule.tech2.toLowerCase());
            
            if (tech1 && tech2) {
                const result = this.evaluateRule(rule, tech1.version, tech2.version);
                if (result) {
                    if (result.severity === 'error') {
                        issues.push(result);
                    } else {
                        warnings.push(result);
                    }
                }
            }
        }
        
        // Check known issues
        for (const known of this.rules.knownIssues) {
            const matches = known.combination.every(combo => {
                const [name, version] = combo.split('@');
                const tech = techs.find(t => t.name.toLowerCase() === name.toLowerCase());
                if (!tech) return false;
                
                // Simple version matching
                if (version === '*' || version === 'latest') return true;
                if (version.startsWith('^') || version.startsWith('~')) {
                    return tech.version?.startsWith(version.substring(1));
                }
                return tech.version?.startsWith(version);
            });
            
            if (matches) {
                warnings.push({
                    type: 'known-issue',
                    status: known.status,
                    message: known.description,
                    suggestion: known.suggestion
                });
            }
        }
        
        return { issues, warnings, recommendations };
    }
    
    /**
     * Evaluate a single compatibility rule
     */
    evaluateRule(rule, version1, version2) {
        // Parse constraint
        const constraint = rule.constraint;
        
        // Simple constraint evaluation
        // In production, use semver library for proper version comparison
        
        if (constraint.includes('requires')) {
            return {
                type: 'dependency',
                severity: rule.severity || 'warning',
                message: constraint,
                tech1: rule.tech1,
                tech2: rule.tech2
            };
        }
        
        if (constraint.includes('incompatible')) {
            return {
                type: 'incompatible',
                severity: 'error',
                message: constraint,
                tech1: rule.tech1,
                tech2: rule.tech2
            };
        }
        
        return null;
    }
    
    /**
     * Generate recommendations based on issues
     */
    generateRecommendations(techs, issues, warnings) {
        const recommendations = [];
        
        // Process issues first
        for (const issue of issues) {
            if (issue.type === 'incompatible') {
                recommendations.push({
                    priority: 'high',
                    action: 'change',
                    message: `Consider using alternative to ${issue.tech1} or ${issue.tech2}`,
                    details: issue.message
                });
            }
        }
        
        // Process warnings
        for (const warning of warnings) {
            if (warning.type === 'known-issue') {
                recommendations.push({
                    priority: 'medium',
                    action: 'caution',
                    message: warning.message,
                    suggestion: warning.suggestion
                });
            }
        }
        
        // Add general recommendations
        const hasReact = techs.some(t => t.name.toLowerCase() === 'react');
        const hasNext = techs.some(t => t.name.toLowerCase() === 'next.js' || t.name.toLowerCase() === 'nextjs');
        
        if (hasNext && !hasReact) {
            recommendations.push({
                priority: 'info',
                action: 'note',
                message: 'Next.js requires React. React 19.x is recommended for Next.js 15.x'
            });
        }
        
        return recommendations;
    }
    
    /**
     * Main check function
     */
    async check(techList) {
        console.log('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        console.log('📦 VERSION COMPATIBILITY CHECK');
        console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
        
        const currentDate = new Date().toLocaleDateString('en-GB', { 
            day: '2-digit', 
            month: '2-digit', 
            year: 'numeric' 
        });
        console.log(`📅 Date: ${currentDate}\n`);
        
        // Parse tech list
        const techs = [];
        for (const tech of techList) {
            const [name, specifiedVersion] = tech.split('@');
            console.log(`🔍 Checking ${name}...`);
            
            const versionInfo = await this.getVersion(name);
            
            techs.push({
                name: name,
                specifiedVersion: specifiedVersion || null,
                version: versionInfo.latest,
                versionInfo: versionInfo
            });
            
            const cachedTag = versionInfo.cached ? ' (cached)' : '';
            if (versionInfo.error) {
                console.log(`   ❌ Error: ${versionInfo.error}`);
            } else {
                console.log(`   ✓ ${name}: ${versionInfo.latest}${cachedTag}`);
                if (versionInfo.lts) {
                    console.log(`   ✓ LTS: ${versionInfo.lts}`);
                }
            }
        }
        
        // Check compatibility
        console.log('\n🔗 Compatibility Analysis:\n');
        const { issues, warnings, recommendations } = this.checkCompatibility(techs);
        
        if (issues.length === 0 && warnings.length === 0) {
            console.log('   ✅ No compatibility issues detected!\n');
        }
        
        if (issues.length > 0) {
            console.log('   ❌ COMPATIBILITY ISSUES:\n');
            for (const issue of issues) {
                console.log(`   • ${issue.message}`);
            }
            console.log('');
        }
        
        if (warnings.length > 0) {
            console.log('   ⚠️  WARNINGS:\n');
            for (const warning of warnings) {
                console.log(`   • ${warning.message || warning.description || JSON.stringify(warning)}`);
            }
            console.log('');
        }
        
        // Generate recommendations
        const allRecommendations = this.generateRecommendations(techs, issues, warnings);
        
        // Print recommended configuration
        console.log('📊 Recommended Configuration:');
        console.log('   ┌─────────────────────────────────────────────┐');
        for (const tech of techs) {
            const version = tech.specifiedVersion || tech.version;
            console.log(`   │ ${tech.name.padEnd(12)} ${version.padEnd(30)}│`);
        }
        console.log('   └─────────────────────────────────────────────┘\n');
        
        if (allRecommendations.length > 0) {
            console.log('💡 Recommendations:\n');
            for (const rec of allRecommendations) {
                const icon = rec.priority === 'high' ? '🔴' : rec.priority === 'medium' ? '🟡' : 'ℹ️';
                console.log(`   ${icon} ${rec.message}`);
                if (rec.suggestion) {
                    console.log(`      → ${rec.suggestion}`);
                }
            }
            console.log('');
        }
        
        console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
        
        return {
            date: currentDate,
            technologies: techs,
            issues,
            warnings,
            recommendations: allRecommendations
        };
    }
    
    /**
     * Get report as JSON
     */
    async getReport(techList) {
        const result = await this.check(techList);
        return JSON.stringify(result, null, 2);
    }
    
    /**
     * Save report to file
     */
    async saveReport(techList, outputPath) {
        const result = await this.check(techList);
        const reportPath = outputPath || '.kracked/KD_output/version-check/report.json';
        
        // Ensure directory exists
        const dir = path.dirname(reportPath);
        if (!fs.existsSync(dir)) {
            fs.mkdirSync(dir, { recursive: true });
        }
        
        // Save JSON
        fs.writeFileSync(reportPath, JSON.stringify(result, null, 2));
        
        // Save markdown
        const mdPath = reportPath.replace('.json', '.md');
        const mdReport = this.generateMarkdownReport(result);
        fs.writeFileSync(mdPath, mdReport);
        
        console.log(`📄 Reports saved to:`);
        console.log(`   JSON: ${reportPath}`);
        console.log(`   Markdown: ${mdPath}\n`);
        
        return result;
    }
    
    /**
     * Generate markdown report
     */
    generateMarkdownReport(result) {
        let md = `# Version Compatibility Report\n\n`;
        md += `**Generated:** ${result.date}\n\n`;
        md += `---\n\n`;
        
        md += `## Technologies Checked\n\n`;
        md += `| Technology | Version | Status |\n`;
        md += `|------------|---------|--------|\n`;
        for (const tech of result.technologies) {
            const status = tech.versionInfo?.error ? '❌ Error' : '✅ OK';
            md += `| ${tech.name} | ${tech.version} | ${status} |\n`;
        }
        
        if (result.issues.length > 0) {
            md += `\n## Issues\n\n`;
            for (const issue of result.issues) {
                md += `- **${issue.type}**: ${issue.message}\n`;
            }
        }
        
        if (result.warnings.length > 0) {
            md += `\n## Warnings\n\n`;
            for (const warning of result.warnings) {
                md += `- ${warning.message || JSON.stringify(warning)}\n`;
            }
        }
        
        if (result.recommendations.length > 0) {
            md += `\n## Recommendations\n\n`;
            for (const rec of result.recommendations) {
                md += `- **${rec.priority}**: ${rec.message}\n`;
                if (rec.suggestion) {
                    md += `  - ${rec.suggestion}\n`;
                }
            }
        }
        
        md += `\n---\n*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*\n`;
        
        return md;
    }
}

// CLI usage
if (require.main === module) {
    const args = process.argv.slice(2);
    
    if (args.length === 0) {
        console.log(`
Usage: node version-checker.js <tech1,tech2,...> [options]

Options:
  --output=<path>   Save report to file
  --json            Output as JSON

Examples:
  node version-checker.js next.js,express.js
  node version-checker.js react,vue,angular --json
  node version-checker.js next.js,express --output=./report.json
`);
        process.exit(0);
    }
    
    (async () => {
        const checker = new VersionChecker();
        const techList = args[0].split(',').map(t => t.trim());
        
        const outputIndex = args.findIndex(a => a.startsWith('--output='));
        const asJson = args.includes('--json');
        
        if (outputIndex !== -1) {
            const outputPath = args[outputIndex].split('=')[1];
            await checker.saveReport(techList, outputPath);
        } else if (asJson) {
            console.log(await checker.getReport(techList));
        } else {
            await checker.check(techList);
        }
    })().catch(console.error);
}

module.exports = VersionChecker;