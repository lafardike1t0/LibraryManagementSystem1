<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Library Management System</title>
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

    <body class="font-sans min-h-screen overflow-x-hidden">
        <div class="flex min-h-screen flex-col md:flex-row">
            <!-- Left Image Section - 40% width -->
            <div class="relative w-full md:w-2/5 min-h-[300px] md:min-h-screen bg-cover bg-center"
                style="background-image: url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=1200&q=80');">
                <!-- Black Overlay -->
                <div class="absolute inset-0 bg-black bg-opacity-50"></div>

                <!-- Content -->
                <div class="absolute bottom-10 left-0 right-0 z-10 text-white text-center px-10">
                    <h1 class="text-4xl font-extrabold mb-4">Welcome Back!</h1>
                    <p class="text-lg opacity-95 leading-relaxed">Access your library account and continue your journey
                        through knowledge and discovery.</p>
                </div>
            </div>

            <!-- Right Form Section - 60% width -->
            <div class="flex w-full md:w-3/5 items-center justify-center bg-white px-8 py-10 md:px-10">
                <div class="w-full max-w-lg">
                    <!-- Back to Home Link -->
                    <div class="mb-5">
                        <a href="${pageContext.request.contextPath}/"
                            class="inline-flex items-center text-primary-blue text-2xl transition-all duration-300 hover:text-accent-blue hover:-translate-x-1">
                            <i class="fas fa-arrow-left"></i>
                        </a>
                    </div>

                    <!-- Header -->
                    <div class="text-center mb-10">
                        <h2 class="text-4xl font-bold text-gray-900 mb-3">Login</h2>
                        <p class="text-gray-500">Enter your credentials to access your account</p>
                    </div>

                    <!-- Error Alert -->
                    <% if (request.getAttribute("error") !=null) { %>
                        <div
                            class="flex items-center gap-2 p-4 mb-6 bg-red-50 border border-red-200 text-red-800 rounded-xl">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>
                                <%= request.getAttribute("error") %>
                            </span>
                        </div>
                        <% } %>

                            <!-- Success Alert -->
                            <% if (request.getAttribute("success") !=null) { %>
                                <div
                                    class="flex items-center gap-2 p-4 mb-6 bg-green-50 border border-green-200 text-green-800 rounded-xl">
                                    <i class="fas fa-check-circle"></i>
                                    <span>
                                        <%= request.getAttribute("success") %>
                                    </span>
                                </div>
                                <% } %>

                                    <!-- Login Form -->
                                    <form action="${pageContext.request.contextPath}/login" method="post">
                                        <!-- Email/Username Field -->
                                        <div class="mb-6">
                                            <label for="username"
                                                class="block mb-2 text-gray-900 font-semibold text-sm">Email or
                                                Username</label>
                                            <div class="relative">
                                                <i
                                                    class="fas fa-user absolute left-5 top-1/2 -translate-y-1/2 text-gray-400"></i>
                                                <input type="text" id="username" name="username"
                                                    class="w-full pl-12 pr-5 py-3.5 border-2 border-gray-200 rounded-xl text-base transition-all duration-300 focus:outline-none focus:border-accent-blue focus:ring-4 focus:ring-blue-100"
                                                    placeholder="Enter your email or username" required>
                                            </div>
                                        </div>

                                        <!-- Password Field -->
                                        <div class="mb-6">
                                            <label for="password"
                                                class="block mb-2 text-gray-900 font-semibold text-sm">Password</label>
                                            <div class="relative">
                                                <i
                                                    class="fas fa-lock absolute left-5 top-1/2 -translate-y-1/2 text-gray-400"></i>
                                                <input type="password" id="password" name="password"
                                                    class="w-full pl-12 pr-5 py-3.5 border-2 border-gray-200 rounded-xl text-base transition-all duration-300 focus:outline-none focus:border-accent-blue focus:ring-4 focus:ring-blue-100"
                                                    placeholder="Enter your password" required>
                                            </div>
                                        </div>

                                        <!-- Login Button -->
                                        <button type="submit"
                                            class="w-full py-3.5 bg-gradient-to-r from-primary-blue to-accent-blue text-white text-lg font-semibold rounded-xl transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_10px_25px_rgba(10,36,99,0.3)]">
                                            <i class="fas fa-sign-in-alt mr-2"></i>Login
                                        </button>

                                        <!-- Sign Up Link -->
                                        <div class="text-center mt-8">
                                            <p class="text-gray-500 text-sm">
                                                Don't have an account?
                                                <a href="${pageContext.request.contextPath}/jsp/register.jsp"
                                                    class="text-accent-blue font-semibold hover:underline">Sign Up</a>
                                            </p>
                                        </div>
                                    </form>
                </div>
            </div>
        </div>
    </body>

    </html>