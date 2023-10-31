export function loadGoogleBooks(callback) {
    const script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = 'https://www.google.com/books/jsapi.js';
    script.onload = callback;
    document.head.appendChild(script);
  }
  
  // Load the Google Books API when the document is ready
  document.addEventListener('DOMContentLoaded', () => {
    loadGoogleBooks();
  });