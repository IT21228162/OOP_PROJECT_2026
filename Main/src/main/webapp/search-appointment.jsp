<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.usermgmt.model.Appointment" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Search Appointment</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet"/>
    <script>tailwind.config={theme:{extend:{fontFamily:{sora:['Sora','sans-serif'],dm:['DM Sans','sans-serif']}}}}</script>
</head>
<body class="font-dm bg-gray-50 min-h-screen">

<nav class="bg-[#0d1b3e] sticky top-0 z-50 shadow-lg">
    <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
        <a href="index.jsp" class="flex items-center gap-3 text-white font-sora font-semibold text-lg">
            RealEstate Pro
        </a>
        <div class="flex items-center gap-1">
            <a href="book-appointment.jsp" class="text-white/70 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-sm transition">Book Appointment</a>
            <a href="AppointmentServlet?action=list" class="text-white/70 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-sm transition">All Appointments</a>
            <a href="search-appointment.jsp" class="bg-[#4f8ef7] text-white px-4 py-2 rounded-lg text-sm">Search</a>
        </div>
    </div>
</nav>

<main class="max-w-5xl mx-auto px-6 py-10">
    <div class="mb-6">
        <h1 class="font-sora text-2xl font-semibold text-gray-800">Search &amp; update appointment</h1>
        <p class="text-gray-500 text-sm mt-1">Find an appointment by ID, then view or edit its details.</p>
    </div>

    <% String success = (String) request.getAttribute("success");
        String error = (String) request.getAttribute("error");
        if (success != null) { %>
    <div class="bg-green-50 border border-green-200 text-green-800 rounded-xl px-4 py-3 text-sm mb-6"><%= success %></div>
    <% } else if (error != null) { %>
    <div class="bg-red-50 border border-red-200 text-red-800 rounded-xl px-4 py-3 text-sm mb-6"><%= error %></div>
    <% } %>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

        <!-- SEARCH -->
        <div class="bg-white border border-gray-200 rounded-2xl p-6">
            <h2 class="font-sora font-semibold text-gray-800 mb-4">Find appointment</h2>
            <form action="AppointmentServlet" method="get">
                <input type="hidden" name="action" value="search"/>
                <div class="mb-4">
                    <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Appointment ID</label>
                    <input type="text" name="appointmentId" placeholder="e.g. APT001"
                           value="<%= request.getParameter("appointmentId") != null ? request.getParameter("appointmentId") : "" %>"
                           class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                </div>
                <button type="submit" class="w-full bg-[#4f8ef7] hover:bg-blue-500 text-white font-sora font-semibold py-2.5 rounded-xl text-sm transition">Search</button>
            </form>
        </div>

        <% Appointment found = (Appointment) request.getAttribute("foundAppointment");
            boolean searched = request.getAttribute("searched") != null;
        %>

        <!-- EDIT FORM -->
        <% if (found != null) { %>
        <div class="bg-white border border-gray-200 rounded-2xl p-6">
            <h2 class="font-sora font-semibold text-gray-800 mb-4">Edit appointment</h2>
            <form action="AppointmentServlet" method="post" class="space-y-3">
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="originalId" value="<%= found.getAppointmentId() %>"/>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Client name</label>
                    <input type="text" name="clientName" value="<%= found.getClientName() %>" required
                           class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Client email</label>
                    <input type="email" name="clientEmail" value="<%= found.getClientEmail() %>"
                           class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Client phone</label>
                    <input type="tel" name="clientPhone" value="<%= found.getClientPhone() %>"
                           class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100"/>
                </div>
                <div class="grid grid-cols-2 gap-3">
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Agent ID</label>
                        <input type="text" name="agentId" value="<%= found.getAgentId() %>"
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400"/>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Property ID</label>
                        <input type="text" name="propertyId" value="<%= found.getPropertyId() %>"
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400"/>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Date</label>
                        <input type="date" name="date" value="<%= found.getDate() %>"
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400"/>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Time</label>
                        <input type="time" name="time" value="<%= found.getTime() %>"
                               class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400"/>
                    </div>
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Type</label>
                    <select name="type" class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400">
                        <option value="Property Viewing" <%= "Property Viewing".equals(found.getType()) ? "selected" : "" %>>Property Viewing</option>
                        <option value="Consultation" <%= "Consultation".equals(found.getType()) ? "selected" : "" %>>Consultation</option>
                        <option value="Document Signing" <%= "Document Signing".equals(found.getType()) ? "selected" : "" %>>Document Signing</option>
                        <option value="Follow Up" <%= "Follow Up".equals(found.getType()) ? "selected" : "" %>>Follow Up</option>
                    </select>
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Status</label>
                    <select name="status" class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400">
                        <option value="Pending" <%= "Pending".equals(found.getStatus()) ? "selected" : "" %>>Pending</option>
                        <option value="Confirmed" <%= "Confirmed".equals(found.getStatus()) ? "selected" : "" %>>Confirmed</option>
                        <option value="Completed" <%= "Completed".equals(found.getStatus()) ? "selected" : "" %>>Completed</option>
                        <option value="Cancelled" <%= "Cancelled".equals(found.getStatus()) ? "selected" : "" %>>Cancelled</option>
                    </select>
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-600 uppercase tracking-wide mb-1.5">Notes</label>
                    <input type="text" name="notes" value="<%= found.getNotes() != null ? found.getNotes() : "" %>"
                           class="w-full px-4 py-2.5 border border-gray-200 rounded-xl bg-gray-50 text-sm focus:outline-none focus:border-blue-400"/>
                </div>
                <button type="submit" class="w-full bg-emerald-500 hover:bg-emerald-600 text-white font-sora font-semibold py-2.5 rounded-xl text-sm transition">Save changes</button>
            </form>
        </div>

        <!-- DETAILS -->
        <div class="md:col-span-2 bg-white border border-gray-200 rounded-2xl p-6">
            <h2 class="font-sora font-semibold text-gray-800 mb-4">Appointment details</h2>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <div class="bg-gray-50 rounded-xl p-3">
                    <div class="text-xs text-gray-400 mb-1">Appointment ID</div>
                    <div class="font-medium text-sm text-gray-800"><%= found.getAppointmentId() %></div>
                </div>
                <div class="bg-gray-50 rounded-xl p-3">
                    <div class="text-xs text-gray-400 mb-1">Client</div>
                    <div class="font-medium text-sm text-gray-800"><%= found.getClientName() %></div>
                </div>
                <div class="bg-gray-50 rounded-xl p-3">
                    <div class="text-xs text-gray-400 mb-1">Date</div>
                    <div class="font-medium text-sm text-gray-800"><%= found.getDate() %></div>
                </div>
                <div class="bg-gray-50 rounded-xl p-3">
                    <div class="text-xs text-gray-400 mb-1">Time</div>
                    <div class="font-medium text-sm text-gray-800"><%= found.getTime() %></div>
                </div>
                <div class="bg-gray-50 rounded-xl p-3">
                    <div class="text-xs text-gray-400 mb-1">Agent ID</div>
                    <div class="font-medium text-sm text-gray-800"><%= found.getAgentId() %></div>
                </div>
                <div class="bg-gray-50 rounded-xl p-3">
                    <div class="text-xs text-gray-400 mb-1">Property ID</div>
                    <div class="font-medium text-sm text-gray-800"><%= found.getPropertyId() %></div>
                </div>
                <div class="bg-gray-50 rounded-xl p-3">
                    <div class="text-xs text-gray-400 mb-1">Type</div>
                    <div class="font-medium text-sm text-gray-800"><%= found.getType() %></div>
                </div>
                <div class="bg-gray-50 rounded-xl p-3">
                    <div class="text-xs text-gray-400 mb-1">Status</div>
                    <div class="font-medium text-sm text-gray-800"><%= found.getStatus() %></div>
                </div>
            </div>
            <% if (found.getNotes() != null && !found.getNotes().isEmpty()) { %>
            <div class="mt-4 bg-blue-50 border border-blue-100 rounded-xl p-3">
                <div class="text-xs text-blue-400 mb-1">Notes</div>
                <div class="text-sm text-blue-800"><%= found.getNotes() %></div>
            </div>
            <% } %>
        </div>

        <% } else if (searched) { %>
        <div class="bg-white border border-gray-200 rounded-2xl p-6 flex items-center justify-center">
            <div class="text-center">
                <div class="text-4xl mb-3">🔍</div>
                <div class="font-medium text-gray-700 mb-1">No appointment found</div>
                <div class="text-sm text-gray-400">Try a different Appointment ID.</div>
            </div>
        </div>
        <% } else { %>
        <div class="bg-white border border-gray-200 rounded-2xl p-6 flex items-center justify-center">
            <div class="text-center">
                <div class="text-4xl mb-3">👈</div>
                <div class="font-medium text-gray-700 mb-1">Search for an appointment</div>
                <div class="text-sm text-gray-400">Enter an Appointment ID on the left.</div>
            </div>
        </div>
        <% } %>
    </div>
</main>
</body>
</html>