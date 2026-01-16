<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up - Library Management System</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            'primary-blue': '#0a2463',
                            'secondary-blue': '#1e3a8a',
                            'accent-blue': '#3b82f6',
                            'light-blue': '#60a5fa',
                            'dark-blue': '#1e293b'
                        }
                    }
                }
            }
        </script>
    </head>

    <body class="font-sans overflow-x-hidden">
        <div class="flex min-h-screen flex-col md:flex-row">
            <!-- Left Image Section - 40% width -->
            <div class="relative w-full md:w-2/5 min-h-[200px] md:min-h-screen bg-cover bg-center"
                style="background-image: url('https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=1200&q=80');">
                <!-- Black Overlay -->
                <div class="absolute inset-0 bg-black bg-opacity-50"></div>

                <!-- Content -->
                <div class="absolute bottom-10 left-0 right-0 z-10 text-white text-center px-10">
                    <h1 class="text-4xl font-extrabold mb-4">Join Our Community</h1>
                    <p class="text-lg opacity-95 leading-relaxed">Discover endless possibilities and connect with a
                        world of knowledge at your fingertips.</p>
                </div>
            </div>

            <!-- Right Form Section - 60% width -->
            <div
                class="flex w-full md:w-3/5 items-start justify-center bg-gradient-to-br from-gray-50 to-gray-200 px-8 py-8 md:px-10">
                <div class="w-full max-w-xl pt-4">
                    <!-- Back to Home Link -->
                    <a href="${pageContext.request.contextPath}/"
                        class="inline-flex items-center text-primary-blue text-2xl mb-4 transition-all duration-300 hover:text-accent-blue hover:-translate-x-1">
                        <i class="fas fa-arrow-left"></i>
                    </a>

                    <!-- Header -->
                    <div class="text-center mb-6">
                        <i
                            class="text-5xl bg-gradient-to-r from-primary-blue to-accent-blue bg-clip-text text-transparent mb-3"></i>
                        <h2 class="text-3xl font-bold text-dark-blue mb-2">Create Account</h2>
                        <p class="text-gray-500">Join our library community today</p>
                    </div>

                    <!-- Error Alert -->
                    <% String error=(String) request.getAttribute("error"); %>
                        <% if (error !=null) { %>
                            <div class="flex items-center gap-2 p-4 mb-6 bg-red-50 text-red-800 rounded-xl font-medium">
                                <i class="fas fa-exclamation-circle"></i>
                                <span>
                                    <%= error %>
                                </span>
                            </div>
                            <% } %>

                                <!-- Registration Form -->
                                <form method="post" action="${pageContext.request.contextPath}/register"
                                    id="registerForm">
                                    <!-- Full Name & Email (2 columns) -->
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                                        <!-- Full Name -->
                                        <div>
                                            <label for="fullName"
                                                class="block mb-2 text-dark-blue font-semibold text-sm">Full
                                                Name</label>
                                            <div class="relative">
                                                <i
                                                    class="fas fa-user absolute left-4 top-1/2 -translate-y-1/2 text-accent-blue z-10"></i>
                                                <input type="text" id="fullName" name="fullName"
                                                    class="w-full pl-12 pr-5 py-3.5 border-2 border-gray-200 rounded-xl text-base bg-gray-50 transition-all duration-300 focus:outline-none focus:border-accent-blue focus:bg-white focus:ring-4 focus:ring-blue-100"
                                                    placeholder="Enter your full name" required minlength="2"
                                                    maxlength="100" pattern="[A-Za-z\s]+" title="Name should only contain letters and spaces">
                                            </div>
                                        </div>

                                        <!-- Email -->
                                        <div>
                                            <label for="email"
                                                class="block mb-2 text-dark-blue font-semibold text-sm">Email
                                                Address</label>
                                            <div class="relative">
                                                <i
                                                    class="fas fa-envelope absolute left-4 top-1/2 -translate-y-1/2 text-accent-blue z-10"></i>
                                                <input type="email" id="email" name="email"
                                                    class="w-full pl-12 pr-5 py-3.5 border-2 border-gray-200 rounded-xl text-base bg-gray-50 transition-all duration-300 focus:outline-none focus:border-accent-blue focus:bg-white focus:ring-4 focus:ring-blue-100"
                                                    placeholder="your.email@example.com" required
                                                    pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Please enter a valid email address with @ symbol">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Username (full width) -->
                                    <div class="mb-6">
                                        <label for="username"
                                            class="block mb-2 text-dark-blue font-semibold text-sm">Username</label>
                                        <div class="relative">
                                            <i
                                                class="fas fa-at absolute left-4 top-1/2 -translate-y-1/2 text-accent-blue z-10"></i>
                                            <input type="text" id="username" name="username"
                                                class="w-full pl-12 pr-5 py-3.5 border-2 border-gray-200 rounded-xl text-base bg-gray-50 transition-all duration-300 focus:outline-none focus:border-accent-blue focus:bg-white focus:ring-4 focus:ring-blue-100"
                                                placeholder="Choose a username" required minlength="3" maxlength="20"
                                                pattern="^[a-zA-Z0-9_]+$">
                                        </div>
                                        <small class="block mt-1 text-gray-500 text-xs">3-20 characters, letters,
                                            numbers, and underscore only</small>
                                    </div>

                                    <!-- Password & Confirm Password (2 columns) -->
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                                        <!-- Password -->
                                        <div>
                                            <label for="password"
                                                class="block mb-2 text-dark-blue font-semibold text-sm">Password</label>
                                            <div class="relative">
                                                <i
                                                    class="fas fa-lock absolute left-4 top-1/2 -translate-y-1/2 text-accent-blue z-10"></i>
                                                <input type="password" id="password" name="password"
                                                    class="w-full pl-12 pr-5 py-3.5 border-2 border-gray-200 rounded-xl text-base bg-gray-50 transition-all duration-300 focus:outline-none focus:border-accent-blue focus:bg-white focus:ring-4 focus:ring-blue-100"
                                                    placeholder="Create a strong password" required minlength="6">
                                            </div>
                                        </div>

                                        <!-- Confirm Password -->
                                        <div>
                                            <label for="confirmPassword"
                                                class="block mb-2 text-dark-blue font-semibold text-sm">Confirm
                                                Password</label>
                                            <div class="relative">
                                                <i
                                                    class="fas fa-lock absolute left-4 top-1/2 -translate-y-1/2 text-accent-blue z-10"></i>
                                                <input type="password" id="confirmPassword" name="confirmPassword"
                                                    class="w-full pl-12 pr-5 py-3.5 border-2 border-gray-200 rounded-xl text-base bg-gray-50 transition-all duration-300 focus:outline-none focus:border-accent-blue focus:bg-white focus:ring-4 focus:ring-blue-100"
                                                    placeholder="Re-enter your password" required minlength="6">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Submit Button -->
                                    <button type="submit"
                                        class="w-full py-3.5 mt-2 bg-gradient-to-r from-primary-blue to-accent-blue text-white text-lg font-semibold rounded-xl transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_8px_20px_rgba(59,130,246,0.3)] active:translate-y-0">
                                        <i class="fas fa-user-plus mr-2"></i>Create Account
                                    </button>
                                </form>

                                <!-- Login Link -->
                                <div class="text-center mt-8 text-gray-500">
                                    <p>Already have an account?
                                        <a href="${pageContext.request.contextPath}/jsp/login.jsp"
                                            class="text-accent-blue font-semibold transition-colors duration-300 hover:text-primary-blue">Login</a>
                                    </p>
                                </div>
                </div>
            </div>
        </div>

        <script>
            // Enhanced Form validation
            document.getElementById('registerForm').addEventListener('submit', function (e) {
                const fullName = document.getElementById('fullName').value.trim();
                const email = document.getElementById('email').value.trim();
                const username = document.getElementById('username').value.trim();
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                // Validate full name (only letters and spaces)
                if (!/^[A-Za-z\s]+$/.test(fullName)) {
                    e.preventDefault();
                    alert('Full name should only contain letters and spaces!');
                    return false;
                }

                // Validate email contains @
                if (!email.includes('@') || !/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email)) {
                    e.preventDefault();
                    alert('Please enter a valid email address with @ symbol!');
                    return false;
                }

                // Validate username (letters, numbers, underscore only)
                if (!/^[a-zA-Z0-9_]+$/.test(username)) {
                    e.preventDefault();
                    alert('Username should only contain letters, numbers, and underscores!');
                    return false;
                }

                // Validate password length
                if (password.length < 6) {
                    e.preventDefault();
                    alert('Password must be at least 6 characters long!');
                    return false;
                }

                // Check if passwords match
                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('Passwords do not match!');
                    return false;
                }
            });

            // Real-time validation feedback
            document.getElementById('fullName').addEventListener('input', function(e) {
                const value = e.target.value;
                if (value && !/^[A-Za-z\s]*$/.test(value)) {
                    e.target.setCustomValidity('Only letters and spaces are allowed');
                } else {
                    e.target.setCustomValidity('');
                }
            });

            document.getElementById('password').addEventListener('input', function(e) {
                const value = e.target.value;
                if (value.length > 0 && value.length < 6) {
                    e.target.setCustomValidity('Password must be at least 6 characters');
                } else {
                    e.target.setCustomValidity('');
                }
            });

            document.getElementById('confirmPassword').addEventListener('input', function(e) {
                const password = document.getElementById('password').value;
                if (e.target.value && e.target.value !== password) {
                    e.target.setCustomValidity('Passwords do not match');
                } else {
                    e.target.setCustomValidity('');
                }
            });
        </script>
    </body>

    </html>