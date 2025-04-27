/**
 * Academic Citation Manager for Blog Posts
 * Handles rendering of inline citations and tooltips
 */
document.addEventListener('DOMContentLoaded', function() {
  // Find all citation placeholders and replace with properly formatted citations
  const citationElements = document.querySelectorAll('.citation-placeholder');
  
  if (citationElements.length > 0) {
    // Get reference data from the page
    let references = [];
    try {
      // Get references from the data attribute
      const referencesData = document.getElementById('page-references');
      if (referencesData) {
        references = JSON.parse(referencesData.getAttribute('data-references'));
      }
    } catch (e) {
      console.error('Error parsing references data:', e);
    }
    
    // Process each citation placeholder
    citationElements.forEach(function(element) {
      const refId = element.getAttribute('data-refid');
      const num = element.getAttribute('data-num');
      
      if (refId && num) {
        // Find the reference data
        const reference = references.find(ref => ref.id === refId);
        
        if (reference) {
          // Create the citation element
          const citationHTML = createCitationHTML(reference, refId, num);
          // Replace the placeholder with the citation
          element.outerHTML = citationHTML;
        }
      }
    });
    
    // Initialize tooltips after all citations are rendered
    initializeTooltips();
  }
});

/**
 * Create HTML for a citation
 */
function createCitationHTML(reference, refId, num) {
  return `
    <a href="#ref-${refId}" class="citation-ref" id="cite-${refId}">
      <sup>[${num}]</sup>
      <div class="citation-popup">
        <div class="citation-title">${reference.title}</div>
        <div class="citation-authors">${reference.authors}</div>
        <div class="citation-source">${reference.journal}, ${reference.year}</div>
        ${reference.doi ? `<a href="https://doi.org/${reference.doi}" class="citation-link" target="_blank">doi:${reference.doi}</a>` : ''}
        ${reference.url ? `<a href="${reference.url}" class="citation-link" target="_blank">${reference.url}</a>` : ''}
      </div>
    </a>`;
}

/**
 * Initialize tooltips for citations
 */
function initializeTooltips() {
  // Ensure tooltips don't go off-screen
  const tooltips = document.querySelectorAll('.citation-ref');
  
  tooltips.forEach(function(tooltip) {
    tooltip.addEventListener('mouseenter', function() {
      const popup = this.querySelector('.citation-popup');
      if (popup) {
        // Reset position first
        popup.style.left = '50%';
        popup.style.marginLeft = '-160px';
        
        // Get positions
        const rect = this.getBoundingClientRect();
        const popupRect = popup.getBoundingClientRect();
        
        // Check if tooltip is too close to the left edge
        if (rect.left < 170) {
          popup.style.left = '0';
          popup.style.marginLeft = '0';
        }
        
        // Check if tooltip is too close to the right edge
        if (window.innerWidth - rect.right < 170) {
          popup.style.left = 'auto';
          popup.style.right = '0';
          popup.style.marginLeft = '0';
        }
      }
    });
  });
}
