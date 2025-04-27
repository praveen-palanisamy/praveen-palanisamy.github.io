/**
 * Citation functionality for academic blog posts
 */
(function() {
  // Show/hide citation formats
  function showCitation(format) {
    document.querySelectorAll('.citation-text').forEach(function(el) {
      el.style.display = 'none';
    });
    document.getElementById('citation-' + format).style.display = 'block';
    
    // Update active button state
    document.querySelectorAll('.citation-formats button').forEach(function(btn) {
      btn.classList.remove('active');
    });
    document.querySelector('button[onclick*="showCitation(\'' + format + '\')"]').classList.add('active');
  }

  // Copy citation to clipboard
  function copyCitation(format) {
    const text = document.getElementById('citation-' + format).textContent.trim();
    navigator.clipboard.writeText(text).then(function() {
      const btn = document.getElementById('copy-' + format);
      const originalText = btn.textContent;
      btn.textContent = 'Copied!';
      setTimeout(function() {
        btn.textContent = originalText;
      }, 2000);
    }).catch(function(err) {
      console.error('Failed to copy: ', err);
    });
  }

  // Initialize with IEEE format as default
  document.addEventListener('DOMContentLoaded', function() {
    // Set IEEE as default if it exists
    if (document.getElementById('citation-ieee')) {
      showCitation('ieee');
    } else if (document.getElementById('citation-apa')) {
      showCitation('apa');
    }
  });

  // Make functions globally available
  window.showCitation = showCitation;
  window.copyCitation = copyCitation;
})();
