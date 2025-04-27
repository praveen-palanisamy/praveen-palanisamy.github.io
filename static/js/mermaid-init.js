// Initialize mermaid diagrams
document.addEventListener('DOMContentLoaded', function () {
  // Initialize mermaid with specific settings
  if (typeof mermaid !== 'undefined') {
    // console.log("Initializing mermaid...");
    mermaid.initialize({
      startOnLoad: true,
      theme: 'default',
      securityLevel: 'loose',
      flowchart: { useMaxWidth: true }
    });

    // Force re-initialization to catch all mermaid divs
    setTimeout(function () {
      // console.log("Re-initializing mermaid...");
      var mermaidDivs = document.querySelectorAll('.mermaid');
      // console.log("Found " + mermaidDivs.length + " mermaid divs");
      mermaidDivs.forEach(function (div) {
        // console.log("Mermaid div content: ", div.textContent);
      });
      mermaid.init(undefined, mermaidDivs);
    }, 1000);
  } else {
    console.error("Mermaid library not loaded!");
  }

  // Convert mermaid code blocks to divs and trigger Mermaid rendering
  document.querySelectorAll('pre code.language-mermaid').forEach(function (block) {
    var div = document.createElement('div');
    div.className = 'mermaid';
    div.innerHTML = block.textContent;
    block.parentNode.parentNode.replaceChild(div, block.parentNode);
  });
  if (window.mermaid && typeof mermaid.run === 'function') {
    mermaid.run();
  }
});
