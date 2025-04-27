/**
 * BibTeX Parser for Academic Citations
 * This script parses the BibTeX data and makes it available for citations
 */

document.addEventListener('DOMContentLoaded', function() {
  console.log('Citation system initializing...');
  // Use the correct path for the BibTeX file
  loadBibTexFile('/static/assets/bibtex/references.bib');
});

function loadBibTexFile(path) {
  console.log('Loading BibTeX file from:', path);
  fetch(path + '?t=' + new Date().getTime())
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      return response.text();
    })
    .then(data => {
      console.log('BibTeX data loaded successfully. Length:', data.length);
      processBibTexData(data);
    })
    .catch(error => {
      console.error('Error loading BibTeX file:', error);
    });
}

function processBibTexData(bibtexData) {
  // Parse the BibTeX data
  const references = parseBibtex(bibtexData);
  window.__bibtexReferences = references;
  console.log('Parsed references:', references);
  
  // Wait for DOM to be ready for citation and references
  setTimeout(function() {
    setupCitations(references);
    setupReferences(references);
  }, 0);
}

// BibTeX parser function - simplified but effective for our needs
function parseBibtex(bibtex) {
  console.log('Starting BibTeX parsing...');
  const entries = {};
  let currentEntry = null;
  let currentKey = null;
  let currentField = null;
  let fieldValue = '';
  
  const lines = bibtex.split('\n');
  console.log('BibTeX lines to parse:', lines.length);
  
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();
    
    // Skip empty lines
    if (line === '') continue;
    
    // Start of a new entry
    if (line.match(/^@\w+\s*{/)) {
      const match = line.match(/@(\w+)\s*{\s*([^,]+),?/);
      if (match) {
        const type = match[1];
        currentKey = match[2].trim();
        console.log('Found entry:', currentKey, 'of type:', type);
        currentEntry = { type: type, id: currentKey };
      }
    }
    // End of current entry
    else if (line === '}' && currentEntry) {
      entries[currentKey] = currentEntry;
      console.log('Completed entry:', currentKey);
      currentEntry = null;
      currentKey = null;
      currentField = null;
    }
    // Field definition
    else if (currentEntry && line.match(/^\s*\w+\s*=/)) {
      // Save previous field if any
      if (currentField && fieldValue) {
        currentEntry[currentField] = fieldValue.trim();
        fieldValue = '';
      }
      
      const match = line.match(/^\s*(\w+)\s*=\s*{?(.*?)(?:,\s*)?$/);
      if (match) {
        currentField = match[1].toLowerCase();
        const value = match[2];
        
        // If the value ends with a closing brace, it's a complete field
        if (value.endsWith('}')) {
          currentEntry[currentField] = value.slice(0, -1).trim();
          currentField = null;
        } else {
          fieldValue = value;
        }
      }
    }
    // Continuation of a field value
    else if (currentEntry && currentField) {
      fieldValue += ' ' + line;
      
      // If the line ends with a closing brace and comma, the field is complete
      if (line.match(/}(\s*,\s*)?$/)) {
        currentEntry[currentField] = fieldValue.replace(/}(\s*,\s*)?$/, '').trim();
        currentField = null;
        fieldValue = '';
      }
    }
  }
  
  // Handle any remaining entry
  if (currentEntry && currentKey) {
    entries[currentKey] = currentEntry;
  }
  
  console.log('Parsed entries:', Object.keys(entries));
  return entries;
}

// Setup citation popups
function setupCitations(references) {
  // Auto-numbering map
  const refNumMap = {};
  let currentNum = 1;
  // Find all citation links in DOM order
  const citationLinks = Array.from(document.querySelectorAll('.citation-ref'));
  citationLinks.forEach(function(link) {
    var refId = link.getAttribute('data-ref-id');
    if (!(refId in refNumMap)) {
      refNumMap[refId] = currentNum++;
    }
    // Set the number in the link text
    link.textContent = '[' + refNumMap[refId] + ']';
    
    // Create tooltip element if it doesn't exist
    let popup = document.getElementById('popup-' + refId);
    if (!popup) {
      popup = document.createElement('div');
      popup.id = 'popup-' + refId;
      popup.className = 'citation-popup';
      document.body.appendChild(popup);
    }
    
    // Fill popup content
    if (references[refId]) {
      popup.innerHTML = formatReferenceTooltip(references[refId]);
    } else {
      popup.textContent = 'Reference not found';
    }
    
    // Tooltip hover logic (using mouseenter/mouseleave)
    link.addEventListener('mouseenter', function(e) {
      const rect = link.getBoundingClientRect();
      popup.style.left = rect.left + 'px';
      popup.style.top = (rect.bottom + 6) + 'px';
      popup.style.display = 'block';
    });
    
    link.addEventListener('mouseleave', function() {
      setTimeout(function() {
        if (!popup.matches(':hover')) {
          popup.style.display = 'none';
        }
      }, 300);
    });
    
    // Allow tooltip to stay open if hovered
    popup.addEventListener('mouseleave', function() {
      popup.style.display = 'none';
    });
    
    // Click-to-scroll logic
    link.addEventListener('click', function(e) {
      var refRow = document.getElementById('ref-' + refId);
      if (refRow) {
        e.preventDefault();
        refRow.scrollIntoView({behavior: 'smooth', block: 'center'});
        refRow.classList.add('reference-highlight');
        setTimeout(function() {
          refRow.classList.remove('reference-highlight');
        }, 1500);
      }
    });
  });
  // Store mapping globally for references
  window.__citationRefNumMap = refNumMap;
}

function formatReferenceTooltip(ref) {
  // Enhanced tooltip: prominent title, authors, meta, and DOI/link
  let html = '';
  if (ref.title) html += '<span class="citation-title">' + ref.title + '</span>';
  if (ref.doi) html += '<span class="citation-doi"><a href="https://doi.org/' + ref.doi + '" target="_blank">doi:' + ref.doi + '</a></span>';
  if (ref.url && !ref.doi) html += '<span class="citation-link"><a href="' + ref.url + '" target="_blank">link</a></span>';
  if (ref.author) html += '<span class="citation-authors">' + ref.author + '</span>';
  let meta = [];
  if (ref.journal) meta.push(ref.journal);
  if (ref.booktitle) meta.push(ref.booktitle);
  if (ref.year) meta.push(ref.year);
  if (meta.length > 0) html += '<span class="citation-meta">' + meta.join(', ') + '</span>';
  return html;
}

// Setup references section
function setupReferences(references) {
  var refSection = document.querySelector('.references-list');
  if (!refSection) return;
  refSection.innerHTML = '';
  // Use the same order as citation appearance
  var refNumMap = window.__citationRefNumMap || {};
  var refIdToNum = Object.entries(refNumMap).sort((a, b) => a[1] - b[1]);
  if (refIdToNum.length === 0) {
    refSection.innerHTML = '<em>No references found.</em>';
    return;
  }
  refIdToNum.forEach(function([key, num]) {
    var ref = references[key];
    var div = document.createElement('div');
    div.className = 'reference-row';
    div.id = 'ref-' + key;
    div.innerHTML = '<span class="reference-number">[' + num + ']</span> ' + formatReferenceFull(ref);
    refSection.appendChild(div);
  });
}

function formatReferenceFull(ref) {
  // Simple full reference format
  var str = '';
  if (ref.author) str += ref.author + '. ';
  if (ref.title) str += '<b>"' + ref.title + '"</b>. ';
  if (ref.journal) str += '<i>' + ref.journal + '</i>, ';
  if (ref.booktitle) str += '<i>' + ref.booktitle + '</i>, ';
  if (ref.year) str += ref.year + '. ';
  if (ref.doi) str += '<a href="https://doi.org/' + ref.doi + '" target="_blank">doi:' + ref.doi + '</a>. ';
  if (ref.url) str += '<a href="' + ref.url + '" target="_blank">link</a>. ';
  return str;
}
