<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Library Management System - Welcome</title>
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
                            'dark-blue': '#1e293b',
                        }
                    }
                }
            }
        </script>
        <style>
            @keyframes slideShow {
                0% {
                    opacity: 0;
                    transform: scale(1);
                }

                5% {
                    opacity: 1;
                    transform: scale(1);
                }

                33.33% {
                    opacity: 1;
                    transform: scale(1.05);
                }

                38.33% {
                    opacity: 0;
                    transform: scale(1.05);
                }

                100% {
                    opacity: 0;
                    transform: scale(1);
                }
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @keyframes bounce {

                0%,
                20%,
                50%,
                80%,
                100% {
                    transform: translateX(-50%) translateY(0);
                }

                40% {
                    transform: translateX(-50%) translateY(-10px);
                }

                60% {
                    transform: translateX(-50%) translateY(-5px);
                }
            }

            .hero-slide {
                position: absolute;
                inset: 0;
                background-size: cover;
                background-position: center;
                opacity: 0;
                animation: slideShow 15s infinite;
            }

            .hero-slide:nth-child(1) {
                background-image: url('https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=1920&q=80');
                animation-delay: 0s;
            }

            .hero-slide:nth-child(2) {
                background-image: url('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?w=1920&q=80');
                animation-delay: 5s;
            }

            .hero-slide:nth-child(3) {
                background-image: url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=1920&q=80');
                animation-delay: 10s;
            }

            .hero-content {
                animation: fadeInUp 1s ease-out;
            }

            .scroll-indicator {
                animation: bounce 2s infinite;
            }
        </style>
    </head>

    <body class="m-0 p-0 overflow-x-hidden">
        <!-- Hero Section -->
        <section class="relative h-screen overflow-hidden flex items-center justify-center">
            <!-- Slideshow Background -->
            <div class="absolute inset-0 z-[1]">
                <div class="hero-slide"></div>
                <div class="hero-slide"></div>
                <div class="hero-slide"></div>
            </div>

            <!-- Overlay -->
            <div class="absolute inset-0 bg-black/35 z-[2]"></div>

            <!-- Content -->
            <div class="hero-content relative z-[3] text-center text-white max-w-4xl px-5">
                <h1 class="text-4xl md:text-5xl lg:text-7xl font-extrabold mb-6 leading-tight capitalize"
                    style="text-shadow: 2px 2px 6px rgba(0,0,0,0.5)">
                    Your Gateway to Organized Knowledge, Efficient Access, and Seamless Learning
                </h1>

                <div class="flex flex-wrap gap-5 justify-center mt-12">
                    <a href="${pageContext.request.contextPath}/login"
                        class="px-8 py-3 text-base font-semibold rounded-full transition-all duration-300 bg-white text-primary-blue border-2 border-white hover:scale-105 hover:-translate-y-1 shadow-lg inline-flex items-center gap-2">
                        <i class="fas fa-sign-in-alt"></i>
                        <span>Login</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/jsp/register.jsp"
                        class="px-8 py-3 text-base font-semibold rounded-full transition-all duration-300 bg-transparent text-white border-2 border-white hover:scale-105 hover:-translate-y-1 shadow-lg inline-flex items-center gap-2">
                        <i class="fas fa-user-plus"></i>
                        <span>Register</span>
                    </a>
                </div>
            </div>

            <!-- Scroll Indicator -->
            <div class="scroll-indicator absolute bottom-8 left-1/2 -translate-x-1/2 z-[3] cursor-pointer"
                onclick="document.querySelector('section:nth-of-type(2)').scrollIntoView({behavior: 'smooth'})">
                <i class="fas fa-chevron-down text-3xl text-white/80"></i>
            </div>
        </section>

        <!-- Features Section -->
        <section class="py-24 bg-white">
            <div class="container mx-auto px-4 max-w-7xl">
                <!-- Section Title -->
                <div class="text-center mb-16">
                    <h2 class="relative inline-block text-4xl font-bold text-gray-900 mb-4">
                        Our Library Features
                        <span
                            class="absolute -bottom-3 left-1/2 -translate-x-1/2 w-20 h-1 bg-gradient-to-r from-accent-blue to-light-blue rounded"></span>
                    </h2>
                    <p class="text-xl text-gray-600 max-w-2xl mx-auto mt-6">
                        Discover the powerful features that make managing your library simple and efficient
                    </p>
                </div>

                <!-- Feature Cards -->
                <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <!-- Card 1 -->
                    <div
                        class="group relative bg-white rounded-3xl p-10 text-center transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] shadow-[0_4px_20px_rgba(10,36,99,0.08)] hover:-translate-y-4 hover:shadow-[0_25px_50px_rgba(10,36,99,0.2)] border-2 border-transparent hover:border-light-blue overflow-hidden">
                        <div
                            class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-accent-blue to-light-blue scale-x-0 group-hover:scale-x-100 transition-transform duration-[400ms]">
                        </div>
                        <div
                            class="w-24 h-24 mx-auto mb-6 bg-primary-blue rounded-3xl flex items-center justify-center text-4xl text-white transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] group-hover:scale-110 group-hover:-rotate-6 shadow-[0_8px_16px_rgba(10,36,99,0.3)] group-hover:shadow-[0_12px_24px_rgba(10,36,99,0.5)]">
                            <i class="fas fa-book"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900 mb-4">Extensive Book Collection</h3>
                        <p class="text-gray-600 leading-relaxed">Access thousands of books across various genres. Our
                            collection is constantly updated with the latest titles and classic literature.</p>
                    </div>

                    <!-- Card 2 -->
                    <div
                        class="group relative bg-white rounded-3xl p-10 text-center transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] shadow-[0_4px_20px_rgba(10,36,99,0.08)] hover:-translate-y-4 hover:shadow-[0_25px_50px_rgba(10,36,99,0.2)] border-2 border-transparent hover:border-light-blue overflow-hidden">
                        <div
                            class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-accent-blue to-light-blue scale-x-0 group-hover:scale-x-100 transition-transform duration-[400ms]">
                        </div>
                        <div
                            class="w-24 h-24 mx-auto mb-6 bg-primary-blue rounded-3xl flex items-center justify-center text-4xl text-white transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] group-hover:scale-110 group-hover:-rotate-6 shadow-[0_8px_16px_rgba(10,36,99,0.3)] group-hover:shadow-[0_12px_24px_rgba(10,36,99,0.5)]">
                            <i class="fas fa-search"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900 mb-4">Easy Book Search</h3>
                        <p class="text-gray-600 leading-relaxed">Find your favorite books quickly with our advanced
                            search features. Search by title, author, ISBN, or category.</p>
                    </div>

                    <!-- Card 3 -->
                    <div
                        class="group relative bg-white rounded-3xl p-10 text-center transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] shadow-[0_4px_20px_rgba(10,36,99,0.08)] hover:-translate-y-4 hover:shadow-[0_25px_50px_rgba(10,36,99,0.2)] border-2 border-transparent hover:border-light-blue overflow-hidden">
                        <div
                            class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-accent-blue to-light-blue scale-x-0 group-hover:scale-x-100 transition-transform duration-[400ms]">
                        </div>
                        <div
                            class="w-24 h-24 mx-auto mb-6 bg-primary-blue rounded-3xl flex items-center justify-center text-4xl text-white transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] group-hover:scale-110 group-hover:-rotate-6 shadow-[0_8px_16px_rgba(10,36,99,0.3)] group-hover:shadow-[0_12px_24px_rgba(10,36,99,0.5)]">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900 mb-4">Simple Borrowing</h3>
                        <p class="text-gray-600 leading-relaxed">Borrow books with just a few clicks. Track your
                            borrowed books and return dates in your personalized dashboard.</p>
                    </div>

                    <!-- Card 4 -->
                    <div
                        class="group relative bg-white rounded-3xl p-10 text-center transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] shadow-[0_4px_20px_rgba(10,36,99,0.08)] hover:-translate-y-4 hover:shadow-[0_25px_50px_rgba(10,36,99,0.2)] border-2 border-transparent hover:border-light-blue overflow-hidden">
                        <div
                            class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-accent-blue to-light-blue scale-x-0 group-hover:scale-x-100 transition-transform duration-[400ms]">
                        </div>
                        <div
                            class="w-24 h-24 mx-auto mb-6 bg-primary-blue rounded-3xl flex items-center justify-center text-4xl text-white transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] group-hover:scale-110 group-hover:-rotate-6 shadow-[0_8px_16px_rgba(10,36,99,0.3)] group-hover:shadow-[0_12px_24px_rgba(10,36,99,0.5)]">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900 mb-4">Secure Access</h3>
                        <p class="text-gray-600 leading-relaxed">Your account and borrowing history are protected with
                            industry-standard security measures.</p>
                    </div>

                    <!-- Card 5 -->
                    <div
                        class="group relative bg-white rounded-3xl p-10 text-center transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] shadow-[0_4px_20px_rgba(10,36,99,0.08)] hover:-translate-y-4 hover:shadow-[0_25px_50px_rgba(10,36,99,0.2)] border-2 border-transparent hover:border-light-blue overflow-hidden">
                        <div
                            class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-accent-blue to-light-blue scale-x-0 group-hover:scale-x-100 transition-transform duration-[400ms]">
                        </div>
                        <div
                            class="w-24 h-24 mx-auto mb-6 bg-primary-blue rounded-3xl flex items-center justify-center text-4xl text-white transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] group-hover:scale-110 group-hover:-rotate-6 shadow-[0_8px_16px_rgba(10,36,99,0.3)] group-hover:shadow-[0_12px_24px_rgba(10,36,99,0.5)]">
                            <i class="fas fa-bell"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900 mb-4">Smart Notifications</h3>
                        <p class="text-gray-600 leading-relaxed">Get timely reminders about due dates and notifications
                            about new arrivals in your favorite genres.</p>
                    </div>

                    <!-- Card 6 -->
                    <div
                        class="group relative bg-white rounded-3xl p-10 text-center transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] shadow-[0_4px_20px_rgba(10,36,99,0.08)] hover:-translate-y-4 hover:shadow-[0_25px_50px_rgba(10,36,99,0.2)] border-2 border-transparent hover:border-light-blue overflow-hidden">
                        <div
                            class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-accent-blue to-light-blue scale-x-0 group-hover:scale-x-100 transition-transform duration-[400ms]">
                        </div>
                        <div
                            class="w-24 h-24 mx-auto mb-6 bg-primary-blue rounded-3xl flex items-center justify-center text-4xl text-white transition-all duration-[400ms] ease-[cubic-bezier(0.175,0.885,0.32,1.275)] group-hover:scale-110 group-hover:-rotate-6 shadow-[0_8px_16px_rgba(10,36,99,0.3)] group-hover:shadow-[0_12px_24px_rgba(10,36,99,0.5)]">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900 mb-4">Admin Dashboard</h3>
                        <p class="text-gray-600 leading-relaxed">Comprehensive management tools for librarians to track
                            inventory, manage users, and generate reports.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- About Section -->
        <section class="py-24 bg-white">
            <div class="container mx-auto px-4 max-w-7xl">
                <div class="flex flex-col md:flex-row items-center gap-16">
                    <!-- Text Content -->
                    <div class="flex-1 order-1">
                        <h2 class="text-4xl font-bold text-gray-900 mb-5">Our Library System</h2>
                        <p class="text-lg text-gray-600 leading-relaxed mb-4">
                            Our Library Management System is designed to streamline library operations and enhance the
                            reading experience for all members. Built with modern technology and user-friendly
                            interfaces, we make library management effortless.
                        </p>
                        <p class="text-lg text-gray-600 leading-relaxed mb-8">
                            Whether you're a member looking to borrow books or an administrator managing the library,
                            our system provides all the tools you need for a seamless experience.
                        </p>

                        <!-- Features List -->
                        <div class="space-y-4 mt-8">
                            <div class="flex items-center gap-4 transition-transform hover:translate-x-3">
                                <i class="fas fa-check-circle text-accent-blue text-2xl w-8"></i>
                                <span class="text-gray-900">User-friendly interface for all users</span>
                            </div>
                            <div class="flex items-center gap-4 transition-transform hover:translate-x-3">
                                <i class="fas fa-check-circle text-accent-blue text-2xl w-8"></i>
                                <span class="text-gray-900">Real-time book availability tracking</span>
                            </div>
                            <div class="flex items-center gap-4 transition-transform hover:translate-x-3">
                                <i class="fas fa-check-circle text-accent-blue text-2xl w-8"></i>
                                <span class="text-gray-900">Comprehensive reporting and analytics</span>
                            </div>
                            <div class="flex items-center gap-4 transition-transform hover:translate-x-3">
                                <i class="fas fa-check-circle text-accent-blue text-2xl w-8"></i>
                                <span class="text-gray-900">Mobile-responsive design</span>
                            </div>
                        </div>
                    </div>

                    <!-- Image -->
                    <div class="flex-1 order-2">
                        <div class="rounded-2xl overflow-hidden shadow-2xl">
                            <img src="https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=600&q=80"
                                alt="Modern Library Interior" class="w-full h-auto block">
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Community Section -->
        <section
            class="py-20 bg-gradient-to-br from-primary-blue via-secondary-blue to-accent-blue text-white text-center">
            <div class="container mx-auto px-4">
                <h2 class="text-5xl font-extrabold mb-5">Join Our Community</h2>
                <p class="text-2xl font-normal opacity-95">Discover, manage, and explore knowledge with ease.</p>
            </div>
        </section>


    </body>

    </html>