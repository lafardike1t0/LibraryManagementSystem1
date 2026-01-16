<%-- Modern Navigation Bar Component --%>
    <%@ page import="com.library.model.User" %>
        <% 
            User navUser = (User) session.getAttribute("user"); 
            String currentPage = request.getRequestURI(); 
            boolean navIsAdmin = navUser != null && "ADMIN".equals(navUser.getUserType()); 
        %>

            <nav
                class="sticky top-0 z-50 bg-gradient-to-r from-[#0a2463] via-[#1e3a8a] to-[#0a2463] shadow-xl border-b border-white/10">
                <div class="container mx-auto px-6">
                    <div class="flex items-center justify-between py-4">

                        <!-- Mobile Menu Button -->
                        <button id="mobile-menu-button"
                            class="lg:hidden text-white p-2 rounded-lg hover:bg-white/10 transition-colors">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M4 6h16M4 12h16M4 18h16"></path>
                            </svg>
                        </button>

                        <!-- Desktop Navigation -->
                        <div class="hidden lg:flex items-center gap-3">
                            <% if (navIsAdmin) { %>
                                <a href="${pageContext.request.contextPath}/adminDashboard" class="flex items-center gap-2 px-5 py-2 rounded-lg text-white/90 hover:bg-white/10 transition-all font-medium <%= currentPage.contains("adminDashboard") ? "bg-white/15" : "" %>">
                                    <i class="fas fa-chart-line"></i>
                                    <span>Dashboard</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/books" class="flex items-center gap-2 px-5 py-2 rounded-lg text-white/90 hover:bg-white/10 transition-all font-medium <%= currentPage.contains("manageBooks") || currentPage.contains("books") ? "bg-white/15" : "" %>">
                                    <i class="fas fa-book"></i>
                                    <span>Manage Books</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/memberManagement" class="flex items-center gap-2 px-5 py-2 rounded-lg text-white/90 hover:bg-white/10 transition-all font-medium <%= currentPage.contains("memberManagement") ? "bg-white/15" : "" %>">
                                    <i class="fas fa-users"></i>
                                    <span>Manage Members</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/adminManagement" class="flex items-center gap-2 px-5 py-2 rounded-lg text-white/90 hover:bg-white/10 transition-all font-medium <%= currentPage.contains("adminManagement") ? "bg-white/15" : "" %>">
                                    <i class="fas fa-users-cog"></i>
                                    <span>Manage Admins</span>
                                </a>
                                <% } %>
                        </div>

                        <!-- User Dropdown Menu -->
                        <div class="relative dropdown ml-auto">
                            <button id="dropdownButton"
                                class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-white/10 transition-all">
                                <% if (!navIsAdmin) { %>
                                    <i class="fas fa-user-circle text-white text-xl"></i>
                                    <% } %>
                                        <span class="text-white font-semibold text-base">
                                            <%= navUser.getFullName() %>
                                        </span>
                                        <i id="dropdownIcon" class="fas fa-chevron-down text-white/70 text-sm transition-transform"></i>
                            </button>

                            <!-- Dropdown Menu -->
                            <div id="dropdownMenu"
                                class="hidden absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-2xl border border-gray-200 overflow-hidden">
                                <!-- User Info Header -->
                                <div
                                    class="px-4 py-3 bg-gradient-to-r from-[#1e3a8a] to-[#3b82f6] border-b border-gray-200">
                                    <p class="text-white font-semibold text-sm">
                                        <%= navUser.getFullName() %>
                                    </p>
                                    <p class="text-white/80 text-xs">
                                        <%= navIsAdmin ? "Administrator" : "Member" %>
                                    </p>
                                </div>

                                <!-- Menu Items -->
                                <div class="py-2">
                                    <a href="${pageContext.request.contextPath}/profile"
                                        class="flex items-center gap-3 px-4 py-2.5 text-gray-700 hover:bg-[#3b82f6] hover:text-white transition-colors">
                                        <i class="fas fa-user-circle w-5"></i>
                                        <span class="font-medium">My Profile</span>
                                    </a>
                                    <a href="#" onclick="confirmLogout(event)"
                                        class="flex items-center gap-3 px-4 py-2.5 text-red-600 hover:bg-red-50 transition-colors border-t border-gray-100">
                                        <i class="fas fa-sign-out-alt w-5"></i>
                                        <span class="font-medium">Logout</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Mobile Menu (Hidden by default) -->
                    <div id="mobile-menu-content" class="hidden lg:hidden pb-4 border-t border-white/10 pt-4">
                        <div class="flex flex-col gap-2">
                            <% if (navIsAdmin) { %>
                                <a href="${pageContext.request.contextPath}/adminDashboard" class="flex items-center gap-3 px-4 py-3 rounded-lg text-white/90 hover:bg-white/10 transition-all font-medium <%= currentPage.contains("adminDashboard") ? "bg-white/15" : "" %>">
                                    <i class="fas fa-chart-line w-5"></i>
                                    <span>Dashboard</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/books" class="flex items-center gap-3 px-4 py-3 rounded-lg text-white/90 hover:bg-white/10 transition-all font-medium <%= currentPage.contains("manageBooks") || currentPage.contains("books") ? "bg-white/15" : "" %>">
                                    <i class="fas fa-book w-5"></i>
                                    <span>Manage Books</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/memberManagement" class="flex items-center gap-3 px-4 py-3 rounded-lg text-white/90 hover:bg-white/10 transition-all font-medium <%= currentPage.contains("memberManagement") ? "bg-white/15" : "" %>">
                                    <i class="fas fa-users w-5"></i>
                                    <span>Manage Members</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/adminManagement" class="flex items-center gap-3 px-4 py-3 rounded-lg text-white/90 hover:bg-white/10 transition-all font-medium <%= currentPage.contains("adminManagement") ? "bg-white/15" : "" %>">
                                    <i class="fas fa-users-cog w-5"></i>
                                    <span>Manage Admins</span>
                                </a>
                                <% } %>

                                    <!-- Mobile Profile Link -->
                                    <a href="${pageContext.request.contextPath}/profile"
                                        class="flex items-center gap-3 px-4 py-3 rounded-lg text-white/90 hover:bg-white/10 transition-all font-medium border-t border-white/10 mt-2 pt-3">
                                        <i class="fas fa-user-circle w-5"></i>
                                        <span>My Profile</span>
                                    </a>

                                    <!-- Mobile Logout Button -->
                                    <a href="#" onclick="confirmLogout(event)"
                                        class="flex items-center gap-3 px-4 py-3 rounded-lg bg-red-500/20 text-red-300 hover:bg-red-500/30 transition-all font-medium">
                                        <i class="fas fa-sign-out-alt w-5"></i>
                                        <span>Logout</span>
                                    </a>
                        </div>
                    </div>
                </div>
            </nav>

            <script>
                // Mobile menu toggle
                document.getElementById('mobile-menu-button').addEventListener('click', function () {
                    const mobileMenu = document.getElementById('mobile-menu-content');
                    mobileMenu.classList.toggle('hidden');
                });

                // Toggle dropdown on click
                document.getElementById('dropdownButton').addEventListener('click', function (e) {
                    e.stopPropagation();
                    const dropdownMenu = document.getElementById('dropdownMenu');
                    const dropdownIcon = document.getElementById('dropdownIcon');
                    dropdownMenu.classList.toggle('hidden');
                    dropdownIcon.classList.toggle('rotate-180');
                });

                // Close dropdown when clicking outside
                document.addEventListener('click', function (event) {
                    const dropdown = document.querySelector('.dropdown');
                    const dropdownMenu = document.getElementById('dropdownMenu');
                    const dropdownIcon = document.getElementById('dropdownIcon');
                    if (dropdown && !dropdown.contains(event.target)) {
                        if (dropdownMenu && !dropdownMenu.classList.contains('hidden')) {
                            dropdownMenu.classList.add('hidden');
                            dropdownIcon.classList.remove('rotate-180');
                        }
                    }
                });

                // Logout confirmation
                function confirmLogout(event) {
                    event.preventDefault();
                    if (confirm('Do you want to log out?')) {
                        window.location.href = '${pageContext.request.contextPath}/logout';
                    }
                }
            </script>