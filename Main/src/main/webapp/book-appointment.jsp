<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Book Appointment</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet"/>
    <script>tailwind.config={theme:{extend:{fontFamily:{sora:['Sora','sans-serif'],dm:['DM Sans','sans-serif']}}}}</script>
</head>
<body class="font-dm bg-gray-50 min-h-screen flex flex-col">

<nav class="bg-[#0d1b3e] sticky top-0 z-50 shadow-lg">
    <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
        <a href="index.jsp" class="flex items-center gap-3 text-white font-sora font-semibold text-lg">
            RealEstate Pro
        </a>
        <div class="flex items-center gap-1">
            <a href="book-appointment.jsp" class="bg-[#4f8ef7] text-white px-4 py-2 rounded-lg text-sm">Book Appointment</a>
            <a href="AppointmentServlet?action=list" class="text-white/70 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-sm transition">All Appointments</a>
            <a href="search-appointment.jsp" class="text-white/70 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-sm transition">Search</a>
        </div>
    </div>
</nav>

<main class="flex-1 flex justify-center py-12 px-4">
    <div class="bg-white rounded-2xl border border-gray-200 shadow-sm p-8 w-full max-w-2xl">
        <div class="mb-6">
            <h1 class="font-sora text-2xl font-semibold text-gray-800">Book appointment</h1>
            <p class="text-gray-500 text-sm mt-1">Schedule a property viewing or consultation.</p>
        </div>

        <% String success = (String) request.getAttribute("success");
            String error = (String) request.getAttribute("error");
            if (success != null) { %>
        <div class="bg-green-50 border border-green-200 text-green-800 rounded-xl px-4 py-3 text-sm mb-6"><%= success %></div>
        <% } else if (error != null) { %>
        <div class="bg-red-50 border border-red-200 text-red-800 rounded-xl px-4 py-3 text-sm mb-6"><%= error %></div>
        <% } %>

        <form action="AppointmentServlet" method="post" class="space-y-5">
            <input type="hidden" name="action" value="create"/>

            <div>
                <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Appointment ID</label>
                <input type="text" name="appointmentId" placeholder="e.g. APT001" required
                       class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
            </div>

            <div class="border-t border-gray-100 pt-5">
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide mb-4">Client Information</p>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Client name</label>
                        <input type="text" name="clientName" placeholder="Full name" required
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Client email</label>
                        <input type="email" name="clientEmail" placeholder="client@email.com"
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Client phone</label>
                        <input type="tel" name="clientPhone" placeholder="+94 77 123 4567"
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Type</label>
                        <select name="type" class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100">
                            <option value="Property Viewing">Property Viewing</option>
                            <option value="Consultation">Consultation</option>
                            <option value="Document Signing">Document Signing</option>
                            <option value="Follow Up">Follow Up</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="border-t border-gray-100 pt-5">
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide mb-4">Booking Details</p>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Agent ID</label>
                        <input type="text" name="agentId" placeholder="e.g. AGT001"
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Property ID</label>
                        <input type="text" name="propertyId" placeholder="e.g. PROP001"
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Date</label>
                        <input type="date" name="date" required
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Time</label>
                        <input type="time" name="time"
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Status</label>
                        <select name="status" class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100">
                            <option value="Pending">Pending</option>
                            <option value="Confirmed">Confirmed</option>
                            <option value="Completed">Completed</option>
                            <option value="Cancelled">Cancelled</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Notes</label>
                        <input type="text" name="notes" placeholder="Any special notes..."
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                    </div>
                </div>
            </div>

            <button type="submit" class="w-full bg-[#4f8ef7] hover:bg-blue-500 text-white font-sora font-semibold py-3 rounded-xl transition mt-2">
                Book appointment
            </button>
        </form>
    </div>
</main>
</body>
</html>