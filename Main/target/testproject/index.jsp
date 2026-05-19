<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>RealEstate Pro — Home</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600;700&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sora: ['Sora', 'sans-serif'],
                        dm: ['DM Sans', 'sans-serif'],
                    },
                    colors: {
                        navy: '#0d1b3e',
                        'navy-mid': '#1a3060',
                        accent: '#4f8ef7',
                    }
                }
            }
        }
    </script>
</head>
<body class="font-dm bg-gray-50 min-h-screen">

<!-- NAV -->
<nav class="bg-navy sticky top-0 z-50 shadow-lg">
    <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
        <a href="index.jsp" class="flex items-center gap-3 text-white font-sora font-semibold text-lg">
            RealEstate Pro
        </a>
        <div class="hidden md:flex items-center gap-1">
            <a href="AgentServlet?action=list" class="text-white/70 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-sm transition">Agents</a>
            <a href="PropertyServlet?action=list" class="text-white/70 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-sm transition">Properties</a>
            <a href="AppointmentServlet?action=list" class="text-white/70 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-sm transition">Appointments</a>
        </div>
    </div>
</nav>

<!-- HERO -->
<div class="bg-navy relative overflow-hidden">
    <div class="absolute inset-0 bg-gradient-to-br from-navy-mid/50 to-transparent"></div>
    <div class="relative max-w-7xl mx-auto px-6 py-24 text-center">
        <h1 class="font-sora text-4xl md:text-5xl font-bold text-white mb-4 leading-tight">
            Real Estate Agent <br/>
            <span class="text-accent">Finder &amp; Appointment</span> System
        </h1>
        <p class="text-white/60 text-lg max-w-xl mx-auto mb-10">
            Complete property management platform with Java Servlets and file-based storage.
        </p>
        <div class="flex flex-wrap gap-4 justify-center">
            <a href="register-agent.jsp" class="bg-accent hover:bg-blue-500 text-white font-sora font-semibold px-8 py-3 rounded-xl transition shadow-lg shadow-blue-500/30">
                Register Agent
            </a>
            <a href="add-property.jsp" class="bg-white/10 hover:bg-white/20 border border-white/20 text-white font-sora font-semibold px-8 py-3 rounded-xl transition">
                Add Property
            </a>
        </div>
    </div>
</div>

<!-- MAIN MODULES -->
<div class="max-w-7xl mx-auto px-6 py-16">
    <div class="text-center mb-12">
        <h2 class="font-sora text-2xl font-semibold text-gray-800 mb-2">System Modules</h2>
        <p class="text-gray-500 text-sm">Three complete management modules with full CRUD operations</p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

        <!-- AGENT MODULE -->
        <div class="bg-white rounded-2xl border border-gray-200 overflow-hidden hover:shadow-xl transition-all duration-300 hover:-translate-y-1">
            <div class="bg-gradient-to-br from-blue-500 to-blue-700 p-6">
                <div class="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center mb-4">
                    <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                </div>
                <h3 class="font-sora text-xl font-semibold text-white mb-1">Agent Management</h3>
                <p class="text-white/70 text-sm">Register and manage real estate agents</p>
            </div>
            <div class="p-6">
                <div class="space-y-2 mb-6">
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-blue-500"></div>
                        Register new agents
                    </div>
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-blue-500"></div>
                        View all agents list
                    </div>
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-blue-500"></div>
                        Search &amp; update agents
                    </div>
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-blue-500"></div>
                        Delete agents
                    </div>
                </div>
                <div class="grid grid-cols-2 gap-2">
                    <a href="register-agent.jsp" class="bg-blue-50 hover:bg-blue-100 text-blue-700 text-center text-xs font-semibold py-2 px-3 rounded-lg transition">
                        + Register
                    </a>
                    <a href="AgentServlet?action=list" class="bg-gray-50 hover:bg-gray-100 text-gray-700 text-center text-xs font-semibold py-2 px-3 rounded-lg transition">
                        View All →
                    </a>
                </div>
            </div>
        </div>

        <!-- PROPERTY MODULE -->
        <div class="bg-white rounded-2xl border border-gray-200 overflow-hidden hover:shadow-xl transition-all duration-300 hover:-translate-y-1">
            <div class="bg-gradient-to-br from-emerald-500 to-emerald-700 p-6">
                <div class="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center mb-4">
                    <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 0 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                    </svg>
                </div>
                <h3 class="font-sora text-xl font-semibold text-white mb-1">Property Management</h3>
                <p class="text-white/70 text-sm">List and manage property listings</p>
            </div>
            <div class="p-6">
                <div class="space-y-2 mb-6">
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-emerald-500"></div>
                        Add new properties
                    </div>
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-emerald-500"></div>
                        Browse all listings
                    </div>
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-emerald-500"></div>
                        Search &amp; update listings
                    </div>
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-emerald-500"></div>
                        Remove properties
                    </div>
                </div>
                <div class="grid grid-cols-2 gap-2">
                    <a href="add-property.jsp" class="bg-emerald-50 hover:bg-emerald-100 text-emerald-700 text-center text-xs font-semibold py-2 px-3 rounded-lg transition">
                        + Add
                    </a>
                    <a href="PropertyServlet?action=list" class="bg-gray-50 hover:bg-gray-100 text-gray-700 text-center text-xs font-semibold py-2 px-3 rounded-lg transition">
                        View All →
                    </a>
                </div>
            </div>
        </div>

        <!-- APPOINTMENT MODULE -->
        <div class="bg-white rounded-2xl border border-gray-200 overflow-hidden hover:shadow-xl transition-all duration-300 hover:-translate-y-1">
            <div class="bg-gradient-to-br from-purple-500 to-purple-700 p-6">
                <div class="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center mb-4">
                    <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                    </svg>
                </div>
                <h3 class="font-sora text-xl font-semibold text-white mb-1">Appointment System</h3>
                <p class="text-white/70 text-sm">Book and manage client appointments</p>
            </div>
            <div class="p-6">
                <div class="space-y-2 mb-6">
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-purple-500"></div>
                        Book appointments
                    </div>
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-purple-500"></div>
                        View all appointments
                    </div>
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-purple-500"></div>
                        Search &amp; reschedule
                    </div>
                    <div class="flex items-center gap-2 text-sm text-gray-600">
                        <div class="w-1.5 h-1.5 rounded-full bg-purple-500"></div>
                        Cancel appointments
                    </div>
                </div>
                <div class="grid grid-cols-2 gap-2">
                    <a href="book-appointment.jsp" class="bg-purple-50 hover:bg-purple-100 text-purple-700 text-center text-xs font-semibold py-2 px-3 rounded-lg transition">
                        + Book
                    </a>
                    <a href="AppointmentServlet?action=list" class="bg-gray-50 hover:bg-gray-100 text-gray-700 text-center text-xs font-semibold py-2 px-3 rounded-lg transition">
                        View All →
                    </a>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- FOOTER -->
<div class="bg-navy">
    <div class="max-w-7xl mx-auto px-6 py-8">
        <div class="text-center">
            <p class="text-white/40 text-sm">&copy; 2025 RealEstate Pro. All rights reserved.</p>
        </div>
    </div>
</div>

</body>
</html>