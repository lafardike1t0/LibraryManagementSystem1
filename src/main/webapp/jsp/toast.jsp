<!-- Toast Notification Container -->
<div id="toastContainer" class="fixed top-24 right-4 z-[99999] space-y-2" style="pointer-events: none;">
</div>

<script>
    // Show toast notification with Tailwind CSS
    function showToast(message, type = 'success') {
        const container = document.getElementById('toastContainer');
        
        // Create toast element
        const toast = document.createElement('div');
        toast.style.pointerEvents = 'auto';
        toast.className = 'transform translate-x-full transition-transform duration-300 ease-out';
        
        // Set icon based on type
        let icon;
        switch(type) {
            case 'success':
                icon = '<i class="fas fa-check-circle"></i>';
                break;
            case 'error':
                icon = '<i class="fas fa-exclamation-circle"></i>';
                break;
            case 'info':
                icon = '<i class="fas fa-info-circle"></i>';
                break;
            case 'warning':
                icon = '<i class="fas fa-exclamation-triangle"></i>';
                break;
        }
        
        toast.innerHTML = `
            <div class="bg-gray-900 rounded-xl shadow-2xl min-w-[320px] max-w-md overflow-hidden border-2 border-gray-700">
                <div class="flex items-center gap-3 p-4">
                    <div class="text-2xl flex-shrink-0" style="color: #ffffff;">${icon}</div>
                    <div class="flex-1 font-semibold text-sm leading-relaxed" style="color: #ffffff !important;">${message}</div>
                    <button onclick="this.closest('div').parentElement.remove()" class="flex-shrink-0 ml-2" style="color: #ffffff;">
                        <i class="fas fa-times text-lg"></i>
                    </button>
                </div>
            </div>
        `;
        
        container.appendChild(toast);
        
        // Trigger animation
        setTimeout(() => {
            toast.classList.remove('translate-x-full');
        }, 10);
        
        // Auto remove after 5 seconds
        setTimeout(() => {
            toast.classList.add('translate-x-full');
            setTimeout(() => toast.remove(), 300);
        }, 5000);
    }

    // Check for session messages on page load
    document.addEventListener('DOMContentLoaded', function() {
        <% 
            String toastMessage = (String) session.getAttribute("toastMessage");
            String toastType = (String) session.getAttribute("toastType");
            if (toastMessage != null && toastType != null) { 
        %>
            showToast('<%= toastMessage %>', '<%= toastType %>');
            <% 
                session.removeAttribute("toastMessage"); 
                session.removeAttribute("toastType");
            %>
        <% } %>
    });
</script>
