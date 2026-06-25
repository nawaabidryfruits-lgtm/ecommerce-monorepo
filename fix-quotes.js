const fs = require('fs');
const path = require('path');

function getAllFiles(dir, exts) {
  let results = [];
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory() && entry.name !== 'node_modules') {
      results = results.concat(getAllFiles(fullPath, exts));
    } else if (entry.isFile() && exts.some(ext => entry.name.endsWith(ext))) {
      results.push(fullPath);
    }
  }
  return results;
}

const srcDir = path.join(__dirname, 'adminfrontend', 'src');
const files = getAllFiles(srcDir, ['.tsx', '.ts']);
let totalFixes = 0;
let filesFixed = 0;

files.forEach(f => {
  let content = fs.readFileSync(f, 'utf8');
  const original = content;
  
  // Pattern 1: Inside template literals, a ternary's single-quoted string ends with backtick instead of quote
  // e.g., 'hover:bg-muted`} -> 'hover:bg-muted'}
  // Match: single quote opens, content, backtick closes before } or ` 
  content = content.replace(/'([^'`\n]{1,200})`\}/g, (match, inner) => {
    // This is inside a template literal where ' starts a string but ` incorrectly ends it
    totalFixes++;
    return "'" + inner + "'}";
  });

  // Pattern 2: ('something`) -> ('something') - quote opening with backtick closing
  content = content.replace(/\('([^'`\n]{1,200})`\)/g, (match, inner) => {
    totalFixes++;
    return "('" + inner + "')";
  });

  // Pattern 3: ('something`) at end of expression (not in parens)
  content = content.replace(/\('([^'`\n]{1,200})`;/g, (match, inner) => {
    totalFixes++;
    return "('" + inner + "';";
  });

  // Pattern 4: =`something' -> ="something" (opening backtick with closing single quote on simple strings without ${})
  content = content.replace(/=`([^`$\n]{1,200})'/g, (match, inner) => {
    totalFixes++;
    return '="' + inner + '"';
  });

  // Pattern 5: (`something') -> ('something') 
  content = content.replace(/\(`([^`$\n]{1,200})'\)/g, (match, inner) => {
    totalFixes++;
    return "('" + inner + "')";
  });

  // Pattern 6: (`something'); -> ('something');
  content = content.replace(/\(`([^`$\n]{1,200})'\);/g, (match, inner) => {
    totalFixes++;
    return "('" + inner + "');";
  });

  // Pattern 7: === `something' -> === 'something'
  content = content.replace(/=== `([^`$\n]{1,50})'/g, (match, inner) => {
    totalFixes++;
    return "=== '" + inner + "'";
  });

  // Pattern 8: useState('`); -> useState('');
  content = content.replace(/\('`\)/g, (match) => {
    totalFixes++;
    return "('')";
  });

  // Pattern 9: Template literal closed with single quote: ...something'} -> ...something`}
  // This catches cases like className={`...lg:inset-0'}>  where ' should be `
  content = content.replace(/=\{`([^`]*?)'\}/g, (match, inner) => {
    // Only fix if the inner content has no unmatched backtick (it's a real template literal)
    if (!inner.includes('`')) {
      totalFixes++;
      return '={`' + inner + '`}';
    }
    return match;
  });

  // Pattern 10: className={`...text-left`} but with backtick then '} at the end
  // (covered by pattern 1 already, but let's also handle triple: 'text`} at end of a className expression)
  
  // Pattern 11: toast.success(`Successfully uploaded ${response.count} image(s)`);
  // Some lines have (`...' instead of (`...`)  (template literal in function call closed with quote)
  content = content.replace(/\(`([^`]*?\$\{[^}]+\}[^`]*?)'\)/g, (match, inner) => {
    totalFixes++;
    return '(`' + inner + '`)';
  });

  // Pattern 12: =`something${var}rest' -> =`something${var}rest`  (template literal with interpolation closed by quote)
  content = content.replace(/=`([^`]*?\$\{[^}]+\}[^`]*?)'/g, (match, inner) => {
    totalFixes++;
    return '=`' + inner + '`';
  });

  if (content !== original) {
    fs.writeFileSync(f, content);
    filesFixed++;
    console.log('Fixed: ' + path.relative(srcDir, f));
  }
});

console.log(`\nTotal fixes: ${totalFixes} across ${filesFixed} files`);
